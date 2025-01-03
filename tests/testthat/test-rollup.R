test_that("rollup works", {
  result <- rollup(
    wbs_tree,
    wbs_table,
    update = function(d, p, c) {
      if (length(c) > 0)
        d[d$id == p, c("work", "budget")] <-
          apply(d[is.element(d$id, c), c("work", "budget")], 2, sum)
      d
    },
    validate_ds = function(tree, ds)
      TRUE
  )

  expect_equal(result, wbs_table_rollup)
})

test_that("update_rollup() works", {
  input <- wbs_table_rollup
  input[input$id == "3.2", "budget"] <- 22000
  input[input$id == "2.2", "work"] <- NA
  result <- update_rollup(
    wbs_tree,
    input,
    igraph::V(wbs_tree)["3.2"],
    update = function(d, p, c) {
      if (length(c) > 0)
        d[d$id == p, c("work", "budget")] <-
          apply(d[is.element(d$id, c), c("work", "budget")], 2, sum)
      d
    }
  )
  expect_equal(result[result$id == "top", "budget"], 216000)
  expect_equal(result[result$id == "top", "work"], 100)
})

test_that("validate_ds() detects mismatched ids", {
  bad_graph <- wbs_tree |> igraph::add_vertices(1, name = c("bad"))
  expect_error(validate_ds(bad_graph, wbs_table, function(d) d$id, function(d, l) d[d$id == l, "work"]),
               "mismatched ids")
})

test_that("validate_ds() detects invalid leaf property values", {
  bad_table <- wbs_table
  bad_table[bad_table$id == "3.2", "work"] <- "bad"
  expect_error(validate_ds(wbs_tree, bad_table, function(d) d$id, function(d, l) d[d$id == l, "work"]),
               "leaf with invalid value")
})

test_that("default_validate_tree() finds the root of a valid tree", {
  expect_equal(names(default_validate_tree(wbs_tree)), "top")
})

test_that("default_validate_tree() rejects a cyclic graph (1)", {
  bad_graph <- wbs_tree |> igraph::add_edges(c("top", "1.2"))
  expect_error(default_validate_tree(bad_graph), "graph is cyclic")
})

test_that("default_validate_tree() rejects a cyclic graph (2)", {
  bad_graph <- wbs_tree |> igraph::add_edges(c("1", "1.2"))
  expect_error(default_validate_tree(bad_graph), "graph is cyclic")
})

test_that("default_validate_tree() rejects a graph with loops", {
  bad_graph <- wbs_tree |> igraph::add_edges(c("top", "top"))
  expect_error(default_validate_tree(bad_graph), "graph is cyclic")
})

test_that("default_validate_tree() rejects a graph with multiple edges", {
  bad_graph <- wbs_tree |> igraph::add_edges(c("1", "top"))
  expect_error(default_validate_tree(bad_graph), "graph contains multiple edges")
})

test_that("default_validate_tree() rejects a disconnected graph", {
  bad_graph <- wbs_tree |> igraph::delete_edges(c("1|top"))
  expect_error(default_validate_tree(bad_graph), "graph is disconnected")
})

test_that("default_validate_tree() rejects an undirected graph", {
  bad_graph <- igraph::as.undirected(wbs_tree)
  expect_error(default_validate_tree(bad_graph), "graph is undirected")
})

test_that("default_validate_tree() rejects a graph with multiple roots", {
  bad_graph <- wbs_tree |> igraph::add_vertices(1, name = ("bad")) |> igraph::add_edges(c("1", "bad"))
  expect_error(default_validate_tree(bad_graph), "graph contains multiple roots")
})

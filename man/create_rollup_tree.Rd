% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rollup.R
\name{create_rollup_tree}
\alias{create_rollup_tree}
\title{Create a tree for use with \code{rollup()}}
\usage{
create_rollup_tree(get_keys, get_parent_key_by_child_key)
}
\arguments{
\item{get_keys}{A function() that returns a collection of names for vertices.}

\item{get_parent_key_by_child_key}{A function(key) that returns for each child key the key of its parent.}
}
\value{
An \code{igraph} directed graph with vertices and edges as supplied
}
\description{
\code{create_rollup_tree()} creates a tree suitable for use with \code{rollup()}
by applying helper functions to construct vertices and edges.
}
\examples{
get_keys <- function() wbs_table$id
get_parent_key_by_child_key <- function(key) wbs_table[which(wbs_table$id == key), "pid"]
create_rollup_tree(get_keys, get_parent_key_by_child_key)

}

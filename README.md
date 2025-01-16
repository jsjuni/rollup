
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rollupTree

<!-- badges: start -->
<!-- badges: end -->

`rollupTree` implements a general function for computations in which
some property of a parent element is a combination of corresponding
properties of its child elements. The mass of an assembly, for example,
is the sum of the masses of its subassemblies, and the mass of each
subassembly is the sum of masses of its parts, etc.

`rollupTree` can perform computations specified by arbitrarily-shaped
(but well-formed) trees, arbitrarily-defined properties and
property-combining operations. Defaults are provided to simplify common
cases (atomic numerical properties combined by summing), but functional
programming techniques allow the caller to pass arbitrary *update*
methods as required.

## Installation

``` r
install.packages("rollupTree")
```

You can install the development version of `rollupTree` from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("jsjuni/rollupTree")
```

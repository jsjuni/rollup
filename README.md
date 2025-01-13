
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rollupTree

<!-- badges: start -->
<!-- badges: end -->

`rollupTree` is a general framework for computations in which some
property of a parent element is some combination of corresponding
properties of its child elements. The mass of an assembly, for example,
is the sum of the masses of its subassemblies, and the mass of each
subassembly is the sum of masses of its parts.

`rollupTree` can solve problems specified by arbitrarily-shaped (but
well-formed) trees, arbitrarily-defined properties and
property-combining operations. Defaults are provided to simplify common
cases (atomic numerical properties combined by summing), but functional
programming techniques allow the caller to pass arbitrary *get*, *set*,
and *combine* methods at runtime.

## Installation

You can install the development version of `rollupTree` from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("jsjuni/rollupTree")
```

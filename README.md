
<!-- README.md is generated from README.Rmd. Please edit that file -->

# paprpkgr

<!-- badges: start -->

<!-- badges: end -->

The goal of **paprpkgr** is to generate a skeleton to develop a research
compendium containing the data, analysis, code, and images to reproduce
one manuscript. I began working ont his package around the same time
that the more sophisticated
[**rrtools**](https://github.com/benmarwick/rrtools) package was being
developed by Ben Marwick and colleagues. If you are looking to
incorporate Docker or Travis in your workflows, that package will be
more useful to you.

## Installation

You can install paprpkgr from [GitHub](https://github.com) with either
of the following:

``` r
devtools::install_github("wmoldham/paprpkgr")
renv::install("wmoldham/paprpkgr")
```

## Getting Started

1.  Create a new package using `usethis::create_package()`.
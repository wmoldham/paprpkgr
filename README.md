
<!-- README.md is generated from README.Rmd. Please edit that file -->

# paprpkgr

<!-- badges: start -->
<!-- badges: end -->

The goal of **paprpkgr** is to generate a skeleton to develop a research
compendium containing the data, analysis, code, and images to reproduce
one manuscript. I began working on this package around the same time
that the more sophisticated
[**rrtools**](https://github.com/benmarwick/rrtools) package was being
developed by Ben Marwick and colleagues. If you are looking to
incorporate Docker or Travis in your workflows, that package will
definitely be more useful to you.

## Installation

You can install **paprpkgr** from [GitHub](https://github.com) with
either of the following:

``` r
devtools::install_github("wmoldham/paprpkgr")
renv::install("wmoldham/paprpkgr")
```

## Getting Started

1.  Create a new package using `usethis::create_package()`.
2.  Start version control with Git by `usethis::use_git()`.
3.  Link version control to GitHub by `usethis::use_github()`.
4.  Restart the session when prompted.
5.  Run `paprpkgr::new_papr()`.

## Compendium Development

1.  Edit `README.Rmd` and `DESCRIPTION` files with basic information
    about your project.
2.  Original data goes into the `data-raw` folder.
3.  Analyze the raw data and generate cleaned data for analysis using
    Rmarkdown files in `inst/analysis/`. Figures from these analyses
    should be saved in `inst/analysis/figures/`.
4.  The clean data should be saved by `usethis::use_data()` and
    documented appropriately.
5.  Draft the manuscript and supplement using the `Rmd` templates
    installed in `inst/manususcript/`.
6.  Build processing pipeline using the `targets` package.

## Research Compendium Resources

Many others have thought much more deeply about the hows and whys of
using R packages in service of reproducible research efforts. I took my
inspiration from their efforts:

-   Ben Marwick and his [rrtools](https://github.com/benmarwick/rrtools)
    package
-   Francisco Rodriguez-Sanchez and his
    [template](https://github.com/Pakillo/template) package
-   Carl Boettiger and his
    [template](https://github.com/cboettig/template) package
-   Jeff Hollister and his
    [manuscriptPackage](https://github.com/jhollist/manuscriptPackage)
-   Robert Flight:
    <http://rmflight.github.io/posts/2014/07/analyses_as_packages.html>
-   <https://github.com/ropensci/rrrpkg>
-   <https://github.com/Reproducible-Science-Curriculum/rr-init>
-   <http://ropensci.github.io/reproducibility-guide/>

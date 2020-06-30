new_papr <- function() {

  # MIT license to cover code in the package
  usethis::use_mit_license()

  # create a package README file
  usethis::use_template(
    "README.Rmd",
    save_as = "README.Rmd",
    data = as.package("."),
    ignore = TRUE,
    open = TRUE,
    package = as.package(".")$package
  )

  # setup directory structure
  paths <- c(
    # data gets cleaned data as R objects used to generate manuscript figures
    "data",

    # similar to the data-raw directory with standard package naming convention
    "inst/extdata",

    # plan to have analysis folder installed with the package
    "inst/analysis/figures",
    "inst/analysis/pdfs",

    # will write the manuscript here
    "inst/manuscript/figures"
  )
  lapply(paths, function(x) dir.create(x, recursive = TRUE))

  # add files to .gitignore
  gitignore <- c(
    "*.html",
    "inst/analysis/figures",
    "*.pdf",
    "*.jpg",
    "*.ai",
    "*.tif",
    "*.log"
  )
  usethis::use_git_ignore(gitignore)

  # add files to .Rbuildignore
  rbuildignore <- c(
    "^inst/analysis/figures"
  )
  usethis::use_build_ignore(rbuildignore, escape = FALSE)

}

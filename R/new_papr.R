#' Create a new research compendium
#'
#' @export
new_papr <- function() {

  # MIT license to cover code in the package
  usethis::use_mit_license()

  # create a package README file
  usethis::use_template(
    "README.Rmd",
    save_as = "README.Rmd",
    data = devtools::as.package("."),
    ignore = TRUE,
    open = TRUE,
    package = "paprpkgr"
  )

  # setup directory structure
  paths <- c(
    # data gets cleaned data as R objects used to generate manuscript figures
    "data",

    # raw data goes here
    "data-raw",

    # top-level analysis
    "analysis/figures",
    "analysis/pdfs",

    # will write the manuscript here
    "manuscript/figures"
  )
  lapply(paths, function(x) dir.create(x, recursive = TRUE))

  # add files to .gitignore
  gitignore <- c(
    "_targets",
    "*.html",
    "analysis/figures",
    "*.pdf",
    "*.jpg",
    "*.ai",
    "*.tif",
    "*.log"
  )
  usethis::use_git_ignore(gitignore)

  # add files to .Rbuildignore
  rbuildignore <- c(
    "^analysis/figures"
  )
  usethis::use_build_ignore(rbuildignore, escape = FALSE)

  # generate package documentation
  usethis::use_template(
    "pkgname-package.R",
    save_as = paste0("R/", devtools::as.package(".")$package, "-package.R"),
    package = "paprpkgr"
  )

  # start renv
  pkgs <- c(
    "qs",
    "rmarkdown",
    "bookdown",
    "patchwork",
    "tidyverse",
    "targets",
    "tarchetypes"
  )
  renv::init(restart = FALSE, bare = TRUE)
  renv::install(pkgs)
  renv::snapshot()
  unlink(".Rprofile")

  file_names <- c(
    "author-info-blocks.lua",
    "multiple-bibliographies.lua",
    "scholarly-metadata.lua",
    "pagebreak.lua",
    "template.docx",

    "cell-metabolism.csl",
    "library.bib",
    "packages.bib",

    "manuscript.Rmd",
    "supplement.Rmd"
  )
  copy_files(file_names, "manuscript")
  copy_files("analysis.Rmd", "analysis")
  copy_files(c("1_utils.R", "1_figures.R"), "R")
  copy_files("_targets.R", ".")
}

copy_files <- function(nm, to) {
  file_from <- paste0("templates/", nm)
  file_to <- paste0(to, "/", nm)
  invisible(
    file.copy(
      from = system.file(file_from, package = "paprpkgr", mustWork = TRUE),
      to = file_to
    )
  )
}

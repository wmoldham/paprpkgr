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
    package = "paprpkgr"
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

  # generate package documentation
  usethis::use_template(
    "pkgname-package.R",
    save_as = paste0("R/", as.package(".")$package, "-package.R"),
    package = "paprpkgr"
  )

  # install manuscript templates
  file_names <- c(
    "author-info-blocks.lua",
    "template.tex",
    "multiple-bibliographies.lua",
    "scholarly-metadata.lua",
    "cell-metabolism.csl",
    "library.bib",
    "packages.bib",
    "manuscript.Rmd",
    "supplement.Rmd",
    "pagebreak.lua"
  )
  file_from <- paste0("templates/", file_names)
  file_to <- paste0("inst/manuscript/", file_names)
  invisible(
    file.copy(from = system.file(file_from, package = "paprpkgr", mustWork = TRUE),
              to = file_to)
  )

  # start version control
  renv::init(restart = FALSE)
  renv::hydrate()
  renv::update()
  renv::snapshot()
  unlink(".Rprofile")
}

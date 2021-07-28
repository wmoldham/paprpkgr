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
    "manuscript/figures",

    # targets functions go here
    "functions"
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

  # install manuscript templates
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
  file_from <- paste0("templates/", file_names)
  file_to <- paste0("manuscript/", file_names)
  invisible(
    file.copy(
      from = system.file(file_from, package = "paprpkgr", mustWork = TRUE),
      to = file_to)
  )

  # copy analysis template
  invisible(
    file.copy(
      from = system.file("templates/analysis.Rmd", package = "paprpkgr", mustWork = TRUE),
      to = "analysis/"
    )
  )

  # start version control
  renv::init(restart = FALSE, bare = TRUE)
  renv::hydrate()
  renv::update()
  renv::snapshot()
  unlink(".Rprofile")

  # copy over utility scripts
  invisible(
    file.copy(
      from = system.file("templates/1_utils.R", package = "paprpkgr", mustWork = TRUE),
      to = "R/"
    )
  )

  # start targets
  invisible(
    file.copy(
      from = system.file("templates/_targets.R", package = "paprpkgr", mustWork = TRUE),
      to = "."
    )
  )
}

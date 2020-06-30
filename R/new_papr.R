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
}

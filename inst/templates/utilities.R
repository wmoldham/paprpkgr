# utilities.R

# src ---------------------------------------------------------------------

src <- function() {
  files <-
    list.files(
      "functions",
      pattern = "\\.R$",
      full.names = TRUE
    )

  invisible(lapply(files, source))
}

# my_kable ----------------------------------------------------------------

my_kable <- function(data, ...) {
  kableExtra::kable(data, booktabs = TRUE, linesep = "", ...) %>%
    kableExtra::kable_styling(
      latex_options = c("hold_position"),
      font_size = 9
    )
}

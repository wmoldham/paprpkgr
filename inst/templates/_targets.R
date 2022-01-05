# setup -------------------------------------------------------------------

devtools::load_all()
library(targets)
library(tarchetypes)

invisible(
  lapply(
    list.files(path = "R", pattern = "\\.R$", full.names = TRUE),
    source
  )
)

conflicted::conflict_prefer("filter", "dplyr")

options(
  tidyverse.quiet = TRUE,
  usethis.quiet = TRUE
)

future::plan(future.callr::callr(workers = future::availableCores() - 1))

# target-specific options
tar_option_set(
  packages = c("tidyverse", "patchwork"),
  # packages = c("tidyverse", "patchwork", "xcms"),
  # imports = c("rnaseq.lf.hypoxia.molidustat"),
  format = "qs"
)

# list of targets ---------------------------------------------------------

list(

  # write manuscript --------------------------------------------------------

  # tar_render(
  #   manuscript,
  #   path = path_to_manuscript("manuscript.Rmd"),
  #   output_dir = path_to_manuscript("")
  # ),
  # tar_render(
  #   supplement,
  #   path = path_to_manuscript("supplement.Rmd"),
  #   output_dir = path_to_manuscript("")
  # ),
  NULL
)

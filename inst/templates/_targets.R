# _targets.R

# setup -------------------------------------------------------------------

devtools::load_all()
library(targets)
library(tarchetypes)

src()

conflicted::conflict_prefer("filter", "dplyr")

options(
  tidyverse.quiet = TRUE,
  usethis.quiet = TRUE
)

future::plan(future::multisession(workers = future::availableCores() - 1))

# target-specific options
tar_option_set(
  packages = c("tidyverse", "patchwork"),
  # imports = c("rnaseq.lf.hypoxia.molidustat"),
  format = "qs"
)

# plot setup
# clrs <- c(RColorBrewer::brewer.pal(4, "Set1")[1:4], "#08306b")
# names(clrs) <- c("21%", "0.5%", "DMSO", "BAY", "0.2%")


# list of targets ---------------------------------------------------------

list(

  # write manuscript --------------------------------------------------------

  tar_render(
    manuscript,
    path = path_to_manuscript("manuscript.Rmd"),
    output_dir = path_to_manuscript("")
  ),
  tar_render(
    supplement,
    path = path_to_manuscript("supplement.Rmd"),
    output_dir = path_to_manuscript("")
  )
)

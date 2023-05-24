# _targets.R

# setup -------------------------------------------------------------------

devtools::load_all()
library(targets)
library(tarchetypes)

# set target options
tar_option_set(
  packages = c(
    "tidyverse",
    "patchwork",
    "scales",
    "grid"
  ),
  format = "qs"
)

# source R scripts
tar_source()

# parallel processing
options(clustermq.scheduler = "multicore")
future::plan(future.callr::callr(workers = future::availableCores() - 1))

# quiet packages
options(
  dplyr.summarise.inform = FALSE
)

extrafont::loadfonts(quiet = TRUE)


# targets -----------------------------------------------------------------

list(

  # manuscript --------------------------------------------------------------

  tar_target(
    template,
    system.file(
      "manuscript/template.docx",
      # package = "Copeland.2023.hypoxia.flux"
    ),
    format = "file"
  ),
  tar_target(
    pkg_citations,
    write_pkg_cites(),
    cue = tar_cue(mode = "always")
  ),
  tar_target(
    csl,
    system.file(
      "manuscript/cell-metabolism.csl",
      # package = "Copeland.2023.hypoxia.flux"
    ),
    format = "file"
  ),
  tar_target(
    refs,
    rbbt::bbt_update_bib(
      path = "manuscript/manuscript.qmd",
      ignore = c("R-base"),
      path_bib = "manuscript/library.bib"
    ),
    cue = tar_cue("always")
  ),
  tar_quarto(
    manuscript,
    path = manuscript_path("manuscript.qmd"),
  ),
  NULL
)

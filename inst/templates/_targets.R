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

  # tar_target(
  #   template,
  #   system.file("manuscript/template.docx", package = "McGarrity.2022.hypoxia.omics"),
  #   format = "file"
  # ),
  # tar_target(
  #   pkgs,
  #   system.file("manuscript/packages.bib", package = "McGarrity.2022.hypoxia.omics"),
  #   format = "file"
  # ),
  # tar_target(
  #   bib,
  #   system.file("manuscript/library.json", package = "McGarrity.2022.hypoxia.omics"),
  #   format = "file"
  # ),
  # tar_target(
  #   csl,
  #   system.file("manuscript/cell-metabolism.csl", package = "McGarrity.2022.hypoxia.omics"),
  #   format = "file"
  # ),
  # tar_render(
  #   manuscript,
  #   path = path_to_manuscript("manuscript.Rmd"),
  #   output_dir = path_to_manuscript(""),
  #   output_format = bookdown::word_document2(
  #     reference_docx = template,
  #     df_print = "kable",
  #     fig_caption = TRUE,
  #     number_sections = FALSE,
  #     pandoc_args = c(
  #       "--lua-filter=scholarly-metadata.lua",
  #       "--lua-filter=author-info-blocks.lua",
  #       "--lua-filter=pagebreak.lua"
  #     )
  #   ),
  #   params = list(
  #     bibliography = c(bib, pkgs),
  #     csl = csl
  #   )
  # ),
  # tar_render(
  #   supplement,
  #   path = path_to_manuscript("supplement.Rmd"),
  #   output_dir = path_to_manuscript(""),
  #   output_format = bookdown::word_document2(
  #     reference_docx = template,
  #     df_print = "kable",
  #     fig_caption = TRUE,
  #     number_sections = FALSE,
  #     pandoc_args = c(
  #       "--lua-filter=scholarly-metadata.lua",
  #       "--lua-filter=author-info-blocks.lua",
  #       "--lua-filter=pagebreak.lua",
  #       "--lua-filter=multiple-bibliographies.lua"
  #     )
  #   ),
  #   params = list(
  #     bibliography = c(bib, pkgs),
  #     csl = csl
  #   )
  # ),

  NULL
)

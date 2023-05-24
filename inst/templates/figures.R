# figures.R

clrs <- c(
  "21%"    = "#E41A1C",
  "0.5%"   = "#377EB8",
  "0.2%"   = "#08306b",
  "DMSO"   = "#4DAF4A",
  "BAY"    = "#984EA3",
  "siCTL"  = "#999999",
  "siMYC"  = "#F781BF",
  "siPHD2" = "#984EA3",
  "N.DMSO" = "#b2df8a",
  "H.DMSO" = "#33a02c",
  "N.BAY"  = "#cab2d6",
  "H.BAY"  = "#6a3d9a"
)

theme_plots <- function() {
  list(
    wmo::theme_wmo(
      base_family = "Calibri",
      base_size = 8
    ),
    ggplot2::theme(
      # panel.border = ggplot2::element_rect(size = 0.1),
      axis.line = ggplot2::element_line(
        colour = "black",
        linewidth = 0.25,
        lineend = "square"
      ),
      panel.border = ggplot2::element_blank(),
      plot.margin = ggplot2::margin(5, 5, 5, 5),
      plot.tag = ggplot2::element_text(face = "bold"),
      axis.title.y.left = ggplot2::element_text(margin = ggplot2::margin(r = 3))
    ),
    ggplot2::coord_cartesian(clip = "off")
  )
}

theme_patchwork <- function(
    design = NULL,
    widths = NULL,
    heights = NULL,
    tags = "A",
    ...
) {
  list(
    patchwork::plot_layout(
      design = design,
      widths = widths,
      heights = heights,
      ...
    ),
    patchwork::plot_annotation(
      tag_levels = tags,
      theme = ggplot2::theme(plot.margin = ggplot2::margin(0, 0, 0, 0))
    )
  )
}

write_figures <- function(plot, filename, path = "manuscript/figs") {
  gtab <- patchwork::patchworkGrob(plot)

  overall_width <-
    grid::convertWidth(
      sum(gtab$widths),
      unitTo = "in",
      valueOnly = TRUE
    )

  overall_height <-
    grid::convertHeight(
      sum(gtab$heights),
      unitTo = "in",
      valueOnly = TRUE
    )

  ggplot2::ggsave(
    filename = stringr::str_c(filename, ".png"),
    plot = plot,
    device = ragg::agg_png,
    path = path,
    width = overall_width,
    height = overall_height,
    units = "in"
  )

  if (file.exists("Rplots.pdf")) unlink("Rplots.pdf")

  stringr::str_c(path, "/", filename, ".png")
}

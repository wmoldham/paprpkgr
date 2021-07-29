# figures.R

# plot setup
pair_clrs <- RColorBrewer::brewer.pal(8, "Paired")
names(pair_clrs) <-c("CTL.CTL", "TGFβ.CTL", "CTL.AZD3965", "TGFβ.AZD3965", "CTL.VB124", "TGFβ.VB124", "CTL.Dual", "TGFβ.Dual")

clrs <- pair_clrs[1:2]
names(clrs) <- c("CTL", "TGFβ")

theme_plots <- function() {
  list(
    wmo::theme_wmo(
      base_family = "Calibri",
      base_size = 8
    ),
    ggplot2::theme(
      panel.border = ggplot2::element_rect(size = 0.25),
      plot.margin = ggplot2::margin(5, 5, 5, 5),
      plot.tag = ggplot2::element_text(face = "bold"),
      axis.title.y.left = ggplot2::element_text(margin = ggplot2::margin(r = 3))
    ),
    ggplot2::coord_cartesian(clip = "off")
  )
}

# utils.R

#' Negate %in%
#'
#' Binary operator that returns a logical vector returning `TRUE` if there is
#' not a match for its left operand.
#'
#' @param x The values to be matched
#' @param y The values to be matched against
#'
"%nin%" <- function(x, table) {
  match(x, table, nomatch = 0L) == 0L
}

path_to_data <- function(nm) {
  dir(
    path = "data-raw/",
    pattern = nm,
    all.files = TRUE,
    full.names = TRUE,
    recursive = TRUE,
    include.dirs = TRUE
  )
}

path_to_reports <- function(nm) {
  stringr::str_c("analysis/", nm)
}

path_to_manuscript <- function(nm) {
  stringr::str_c("manuscript/", nm)
}

path_to_plots <- function(nm) {
  path <- stringr::str_c("analysis/figures/", nm)

  if (dir.exists(path)) unlink(path, recursive = TRUE)

  if (!dir.exists(path)) dir.create(path = path, recursive = TRUE)

  path

}

read_multi_excel <- function(excel_file) {
  sheets <- readxl::excel_sheets(excel_file)
  purrr::map(sheets, ~readxl::read_excel(excel_file, sheet = .x)) %>%
    rlang::set_names(sheets)
}

clean_technical_replicates <- function(tbl) {
  tidyr::pivot_longer(
    data = tbl,
    cols = .data$a:.data$c,
    names_to = "replicate",
    values_to = "value"
  ) %>%
    dplyr::group_by(
      dplyr::across(-c(.data$replicate, .data$value))
    ) %>%
    dplyr::mutate(value = replace_outliers(value)) %>%
    dplyr::summarise(value = mean(.data$value, na.rm = TRUE)) %>%
    dplyr::ungroup()
}

make_std_curves <- function(df, fo = NULL) {

  if (is.null(fo)){
    fo <- ~lm(value ~ conc, data = .x, na.action = modelr::na.warn)
  }

  df %>%
    dplyr::filter(!is.na(.data$conc)) %>%
    dplyr::select(where(~all(!is.na(.)))) %>%
    dplyr::group_by(dplyr::across(-c(.data$conc, .data$value))) %>%
    tidyr::nest() %>%
    dplyr::mutate(
      title = stringr::str_c(!!!rlang::syms(dplyr::groups(.)), sep = "_")
    ) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(
      model = furrr::future_map(.data$data, fo),
      summary = furrr::future_map(.data$model, ~broom::glance(.x)),
      plots = furrr::future_map2(.data$data, .data$title, make_std_plots)
    ) %>%
    dplyr::group_by(
      dplyr::across(
        -c(.data$data, .data$title, .data$model, .data$summary, .data$plots)
      )
    )
}

make_std_plots <- function(df, title = NULL) {
  ggplot2::ggplot(df) +
    ggplot2::aes(
      x = .data$conc,
      y = .data$value
    ) +
    ggplot2::geom_smooth(
      method = "lm",
      formula = y ~ x,
      color = "gray20",
      se = FALSE
    ) +
    ggplot2::geom_point(
      size = 3,
      alpha = 0.3,
      color = "blue"
    ) +
    ggplot2::stat_summary(
      fun = "mean",
      size = 4,
      geom = "point",
      alpha = 0.8,
      color = "blue"
    ) +
    ggplot2::labs(
      x = "Concentration",
      y = "Value",
      title = title
    )
}

interp_data <- function(tbl, std) {
  tbl %>%
    dplyr::filter(is.na(.data$conc)) %>%
    dplyr::select(-.data$conc) %>%
    dplyr::group_by(dplyr::across(dplyr::group_vars(std))) %>%
    tidyr::nest() %>%
    dplyr::left_join(dplyr::select(std, .data$model)) %>%
    dplyr::mutate(conc = purrr::map2(.data$data, .data$model, wmo::interpolate)) %>%
    tidyr::unnest(c(.data$data, .data$conc)) %>%
    dplyr::select(-c(.data$model, .data$value))
}

interpolate <- function(new_df, model) {
  x <- stats::model.frame(model)[[deparse(model$terms[[3]])]]
  p <- polynom::polynomial(stats::coefficients(model))
  new_y <- as.list(new_df[[deparse(model$terms[[2]])]])
  new_x <- unlist(lapply(new_y, function(y) {
    roots <- solve(p, y)
    roots <- round(roots, digits = 8)
    root <- roots[which(Im(roots) == 0 & Re(roots) >= 0 & Re(roots) <= 1.25 * max(x))]
    ifelse(identical(root, numeric(0)), NA, Re(root))
  }))
  new_x
}

print_plots <- function(
  plot_list,
  name_list,
  path_name,
  width = 20,
  height = 15
) {
  path <- path_to_plots(path_name)
  furrr::future_walk2(
    plot_list,
    name_list,
    ~ggplot2::ggsave(
      filename = stringr::str_c(.y, ".pdf"),
      path = path,
      plot = .x,
      device = cairo_pdf,
      width = width,
      height = height,
      units = "cm"
    )
  )
  invisible(path)
}

annot_p <- function(num) dplyr::if_else(num < 0.05, "*", NA_character_)

reverselog_trans <- function(base = exp(1)) {
  trans <- function(x) -log(x, base)
  inv <- function(x) base^(-x)
  scales::trans_new(paste0("reverselog-", format(base)), trans, inv,
                    scales::log_breaks(base = base),
                    domain = c(1e-100, Inf))
}

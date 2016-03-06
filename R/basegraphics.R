
#' Let rmote know that a base R plot is complete and ready to serve
#' @export
plot_done <- function() {
  make_base_plot()
  options(rmote_baseplot = NULL)
}

make_base_plot <- function() {
  html <- getOption("rmote_baseplot")
  if(!is.null(html)) {
    dev.off()
    write_html(html)
  }
}

set_base_plot_hook <- function() {
  options(prev_plot_hook = getHook("before.plot.new"))
  setHook("before.plot.new", function() {
    # in case previous plot has never finished
    getFromNamespace("make_base_plot", "rmote")()

    # this will call png or pdf with appropriate options
    dummy <- structure(list(Sys.time()), class = "base_graphics")
    getFromNamespace("print_graphics", "rmote")(dummy)
  }, "replace")
}

unset_base_plot_hook <- function() {
  setHook("before.plot.new", getOption("pre_plot_hook"), "replace")
}

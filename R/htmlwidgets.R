
#' Print an htmlwidget to servr
#'
#' @param x htmlwidget object
#' @param \ldots  additional parameters
#' @export
print.htmlwidget <- function(x, ...) {

  widget_opt <- getOption("rmote_htmlwidgets", FALSE)

  if (is_rmote_on() && widget_opt) {
    message("serving htmlwidgets through rmote")

    res <- try({
      html <- htmltools::as.tags(x, standalone = TRUE)
      write_html(html)
    })

    # make thumbnail of htmlwidget
    if (is_history_on()) {
      message("making thumbnail")
      fbase <- file.path(get_server_dir(), "thumbs")
      nf <- file.path(fbase, gsub("html$", "png", basename(res)))
      if (!inherits(res, "try-error")) {
        width <- x$width
        height <- x$height
        x$sizingPolicy$padding <- 0
        if (is.null(width)) width <- 600
        if (is.null(height)) height <- 400

        tf <- tempfile(fileext = ".png")
        ws_res <- try(webshot::webshot(paste0("file://", res), file = tf,
          selector = ".html-widget"), silent = TRUE)
        if (!inherits(ws_res, "try-error")) {
          suppressMessages(make_thumb(tf, nf, width = width, height = height))
        } else {
          opts <- list(filename = nf, width = 300, height = 150)
          if (capabilities("cairo"))
            opts$type <- "cairo-png"
          do.call(png, opts)
          getFromNamespace("print.trellis", "lattice")(text_plot("htmlwidget"))
          dev.off()
        }
      }
      return()
    }

  } else {
    getFromNamespace("print.htmlwidget", "htmlwidgets")(x)
  }
}


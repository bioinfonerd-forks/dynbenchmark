#' Helper function for controlling experiments
#'
#' @param experiment_id id for the experiment
#' @param filename the filename
#'
#' @export
#'
#' @rdname experiment
#'
#' @examples
#' \dontrun{
#' experiment("test_plots")
#'
#' data <- matrix(runif(200), ncol = 2)
#' pdf(figure_file("testplot.pdf"), 5, 5)
#' plot(data)
#' dev.off()
#' }
experiment <- function(experiment_id) {
  # check whether the working directory is indeed the dynbenchmark folder
  dyn_fold <- get_dynbenchmark_folder()

  # set option
  options(dynbenchmark_experiment_id = experiment_id)
}

# create a helper function
experiment_subfolder <- function(path) {
  function(filename = "", experiment_id = NULL) {
    filename <- paste0(filename, collapse = "")

    dyn_fold <- get_dynbenchmark_folder()

    # check whether exp_id is given
    if (is.null(experiment_id)) {
      experiment_id <- getOption("dynbenchmark_experiment_id")
    }

    # check whether exp_fold could be found
    if (is.null(experiment_id)) {
      stop("No experiment folder found. Did you run experiment(...) yet?")
    }

    # determine the full path
    full_path <- paste0(dyn_fold, "/", path, "/", experiment_id, "/")

    # create if necessary
    dir.create(full_path, recursive = TRUE, showWarnings = FALSE)

    # get complete filename
    paste(full_path, filename, sep = "")
  }
}

#' @rdname experiment
#' @export
derived_file <- experiment_subfolder("derived")

#' @rdname experiment
#' @export
data_file <- experiment_subfolder("data")

#' @rdname experiment
#' @export
figure_file <- experiment_subfolder("figures")

#' @rdname experiment
#' @export
result_file <- experiment_subfolder("results")

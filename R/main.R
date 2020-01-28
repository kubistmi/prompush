#' @title Post status
#'
#' @description
#' \code{status} is a utility to post a value to Prometheus (pushgateway)
#'
#' @usage
#' status(job, instance, metric, tags, value, host = "localhost:9091")
#'
#' @param job character. Top level name, such as project name.
#'
#' @param instance character. Implementation name (project used for more client?)
#'
#' @param metric character. Metric name, e.g. status, exec_time_s (execution time in seconds)
#'
#' @param tags named vector(character=character). A vector of tag and tag values
#'
#' @param value numeric. A value for the metric (status = 1, exec_time_s = 600)
#'
#' @param value character. Hostname with port
#'
#' @return Returns an invisible \code{NULL} or character (in case of error)
#'
#' @author Michal Kubista
#'
#' @examples
#' \dontrun{
#' # successful job run
#' status("validation", "client1", "status", c("run_at" = "14:00"), 1)
#'
#' # job took 25 minutes
#' status("database", "update", "exec_time_s", c("scope" = "full", "delete_strategy"="truncate"), 25*60)
#'
#' }
#' @export
status = function(job, instance, metric, tags, value, host = "http://localhost:9091"){
    endpoint = paste0("/metrics/job/", job)
    url = paste0(host, endpoint)

    tags = c("instance" = instance, tags)
    tagsV = rep('', length(tags))
    for (i in seq_along(tags)) {
        tagsV[i] = paste0(names(tags)[i], '=', '"', tags[i], '"')
    }
    tagsF = paste(tagsV, collapse = ',')
    meta = paste0(metric,'{',tagsF,'}')

    body = paste0(meta, ' ', value, '\n')

    resp = POST(url, body = body)
    if (resp$status_code != 200) {
        return(
            paste(
                "Error in the request: status code =", resp$status_code,
                "; response =", resp$content
                )
            )
    }
}

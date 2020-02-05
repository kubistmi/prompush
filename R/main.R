sw = suppressWarnings

#' @title Post status
#'
#' @description
#' \code{status} is a utility to post a value to Prometheus (pushgateway)
#'
#' @usage
#' status(job, instance, metric, tags, value, host = 'localhost:9091')
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
#' @return invisible \code{NULL} or character (in case of error)
#'
#' @author Michal Kubista
#'
#' @examples
#' \dontrun{
#' # successful job run
#' status('validation', 'client1', 'status', c('run_at' = '14:00'), 1)
#'
#' # job took 25 minutes
#' status('database', 'update', 'exec_time_s', c('scope' = 'full', 'delete_strategy'='truncate'), 25*60)
#'
#' }
#' @export
status = function(job, instance, metric, tags=c(), value,
                  host = 'http://localhost:9091') {
    endpoint = paste('/metrics/job/', job)
    url = paste0(host, endpoint)

    tags = c('instance' = instance, tags)
    tagsV = rep('', length(tags))

    for (i in seq_along(tags)) {
        tagsV[i] = sprintf('%s="%s"', names(tags)[i], tags[i] )
    }
    tagsF = paste(tagsV, collapse = ',')
    meta = paste0(metric,sprintf('{%s}', tagsF))

    body = paste0(meta, ' ', value, '\n')

    resp = POST(url, body = body)
    if (resp$status_code != 200) {
        return(
            paste(
                'Error in the request: status code =', resp$status_code,
                '; response =', resp$content
            )
        )
    }
}

#' @title Send status on error
#'
#' @description
#' \code{status_on_error} is a utility to post an error to Prometheus (pushgateway)
#'
#' @usage
#' status_on_error(job, instance, metric='error', tags, value, host = 'localhost:9091')
#'
#' @inheritParams status
#'
#' @return invisible \code{NULL}
#'
#' @author Michal Kubista
#'
#' @examples
#' \dontrun{
#' status_on_error('validation', 'client1', 'error', c('run_at' = '14:00'), 1)
#'
#' }
#' @export
status_on_error = function(job, instance, metric = 'error', tags=c(), value,
                           host = 'http://localhost:9091') {
    options(error = function() {
        status(job, instance, metric, tags, value, host)

    })
}

reset_on_error = function(){
    options(error = NULL)
}

#' R6 class for docker app
#'
#' @description
#' A R6 Class representation of dockerized prometheus application
docker = R6Class('docker', list(
    #' @field path. A path to the docker-compose file
    path = NA_character_,
    #' @field id. Vector of the container IDs
    id = c(),

    #' @description
    #' Create a new docker object.
    #' @return `docker` object.
    initialize = function() {
        self$check_docker()
        self$path = system.file('extdata', package = 'prompush')

    },
    #' @description
    #' Check if docker commands can be found in path.
    #' @return invisible \code{NULL}
    check_docker = function() {
        docker = length(sw(system('type docker', intern = T)))
        docomp = length(sw(system('type docker-compose', intern = T)))
        if (docker + docomp == 0) {
            stop('docker or docker-compose not found in path')
        }
    },
    #' @description
    #' Start the docker containers
    #' @return invisible \code{NULL}
    start = function() {
        self$check_docker()
        system(
            sprintf('cd %s && docker-compose up -d', self$path)
        )
        self$id = system(
            sprintf('cd %s && docker-compose ps -q', self$path),
            intern = T
        )
        cat('Success!')
    },
    #' @description
    #' Stop the docker containers
    #' @return invisible \code{NULL}
    stop = function() {
        system(
            sprintf('cd %s && docker-compose down', self$path)
        )
        self$id = c()
        cat('Success!')
    },
    #' @description
    #' Check if the containers are active
    #' @return invisible \code{NULL}
    running = function() {
        if (is.null(self$id)) return(F)
        return(T)
    },
    #' @description
    #' Save the object
    #' @return invisible \code{NULL}
    save = function(path) {
        saveRDS(self, path)
    }
))


#' @title Create a new docker object
#'
#' @description
#' \code{create_docker} is the prefered way to create a new docker object, either with default values, or by loading a previously saved configuration
#'
#' @usage
#' create_docker(path = '')
#'
#' @param path character. A path to previously saved object. Keep empty for new object
#'
#' @return \code{docker} object.
#'
#' @author Michal Kubista
#'
#' @examples
#' \dontrun{
#' # load existing config
#' docker = create_docker('old_config.RDS')
#'
#' # create new
#' docker = create_docker()
#' }
#' @export
create_docker = function(path = '') {
    stopifnot(is.character(path), length(path) == 1)

    if (path == '') {
        return(docker$new())
    } else {
        return(readRDS(path))
    }
}

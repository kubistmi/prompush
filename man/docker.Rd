% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/main.R
\name{docker}
\alias{docker}
\title{docker R6 class}
\description{
A R6 Class representation of dockerized prometheus application
}
\section{Public fields}{
\if{html}{\out{<div class="r6-fields">}}
\describe{
\item{\code{path.}}{A path to the docker-compose file}

\item{\code{id.}}{Vector of the container IDs}
}
\if{html}{\out{</div>}}
}
\section{Active bindings}{
\if{html}{\out{<div class="r6-active-bindings">}}
\describe{
\item{\code{path.}}{A path to the docker-compose file}

\item{\code{id.}}{Vector of the container IDs}
}
\if{html}{\out{</div>}}
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-new}{\code{docker$new()}}
\item \href{#method-check_docker}{\code{docker$check_docker()}}
\item \href{#method-start}{\code{docker$start()}}
\item \href{#method-stop}{\code{docker$stop()}}
\item \href{#method-running}{\code{docker$running()}}
\item \href{#method-save}{\code{docker$save()}}
\item \href{#method-clone}{\code{docker$clone()}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-new"></a>}}
\subsection{Method \code{new()}}{
Create a new docker object.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{docker$new()}\if{html}{\out{</div>}}
}

\subsection{Returns}{
`docker` object.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-check_docker"></a>}}
\subsection{Method \code{check_docker()}}{
Check if docker commands can be found in path.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{docker$check_docker()}\if{html}{\out{</div>}}
}

\subsection{Returns}{
invisible \code{NULL}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-start"></a>}}
\subsection{Method \code{start()}}{
Start the docker containers
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{docker$start()}\if{html}{\out{</div>}}
}

\subsection{Returns}{
invisible \code{NULL}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-stop"></a>}}
\subsection{Method \code{stop()}}{
Stop the docker containers
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{docker$stop()}\if{html}{\out{</div>}}
}

\subsection{Returns}{
invisible \code{NULL}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-running"></a>}}
\subsection{Method \code{running()}}{
Check if the containers are active
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{docker$running()}\if{html}{\out{</div>}}
}

\subsection{Returns}{
invisible \code{NULL}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-save"></a>}}
\subsection{Method \code{save()}}{
Save the object
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{docker$save(path)}\if{html}{\out{</div>}}
}

\subsection{Returns}{
invisible \code{NULL}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-clone"></a>}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{docker$clone(deep = FALSE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{deep}}{Whether to make a deep clone.}
}
\if{html}{\out{</div>}}
}
}
}

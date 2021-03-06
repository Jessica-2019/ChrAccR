% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DsATAC-class.R
\docType{methods}
\name{exportCountTracks,DsATAC-method}
\alias{exportCountTracks,DsATAC-method}
\alias{exportCountTracks}
\title{exportCountTracks-methods}
\usage{
\S4method{exportCountTracks}{DsATAC}(.object, type, outDir,
  formats = c("bed", "igv"), groupBy = NULL)
}
\arguments{
\item{.object}{\code{\linkS4class{DsATAC}} object}

\item{type}{character string specifying the region type}

\item{outDir}{output directory. Must be existing.}

\item{formats}{browser format. Currently only bed and "igv" are supported}

\item{groupBy}{a column in the sample annotation table to group by (the mean will be computed)}
}
\value{
nothing of particular interest
}
\description{
export count data as genome tracks (e.g. for visualization in the browser)
}
\author{
Fabian Mueller
}

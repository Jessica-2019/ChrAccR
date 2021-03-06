% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DsATAC-class.R
\docType{methods}
\name{getMonocleCellDataSet,DsATAC-method}
\alias{getMonocleCellDataSet,DsATAC-method}
\alias{getMonocleCellDataSet}
\title{getMonocleCellDataSet-methods}
\usage{
\S4method{getMonocleCellDataSet}{DsATAC}(.object, regionType,
  binarize = TRUE)
}
\arguments{
\item{.object}{\code{\linkS4class{DsATAC}} object}

\item{regionType}{name of the region type to be exported}

\item{binarize}{should the counts be binarized}
}
\value{
a \code{cell_data_set} object containing the counts for the specified region type
}
\description{
Obtain \code{cell_data_set} object for analysis using the \code{monocle3} package
}
\author{
Fabian Mueller
}

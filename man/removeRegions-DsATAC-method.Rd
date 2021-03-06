% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DsATAC-class.R
\docType{methods}
\name{removeRegions,DsATAC-method}
\alias{removeRegions,DsATAC-method}
\title{removeRegions-methods}
\usage{
\S4method{removeRegions}{DsATAC}(.object, indices, type)
}
\arguments{
\item{.object}{\code{\linkS4class{DsATAC}} object}

\item{indices}{a vector of indices of sites/regions to be removed. Can be numeric, integer or logical.}

\item{type}{character string specifying a name for the region type (sefault: sites)}
}
\value{
a new \code{\linkS4class{DsATAC}} object with sites/regions removed
}
\description{
Remove the specified sites or regions from an object
}
\author{
Fabian Mueller
}

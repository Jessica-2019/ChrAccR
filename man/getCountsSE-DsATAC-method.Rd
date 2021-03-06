% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DsATAC-class.R
\docType{methods}
\name{getCountsSE,DsATAC-method}
\alias{getCountsSE,DsATAC-method}
\alias{getCountsSE}
\title{getCountsSE-methods}
\usage{
\S4method{getCountsSE}{DsATAC}(.object, type, naIsZero = TRUE)
}
\arguments{
\item{.object}{\code{\linkS4class{DsATAC}} object}

\item{type}{character string specifying the region type}

\item{naIsZero}{should \code{NA}s in the count matrix be considered 0 value (instead of unknown/missing)}
}
\value{
\code{SummarizedExperiment} containing counts for each region and sample
}
\description{
Return a \code{SummarizedExperiment} object of count values
}
\examples{
\dontrun{
dsa <- ChrAccRex::loadExample("dsAtac_ia_example")
se <- getCountsSE(dsa, "IA_prog_peaks")
se
}
}
\author{
Fabian Mueller
}

% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DsATAC-class.R
\docType{methods}
\name{getDESeq2Dataset,DsATAC-method}
\alias{getDESeq2Dataset,DsATAC-method}
\alias{getDESeq2Dataset}
\title{getDESeq2Dataset-methods}
\usage{
\S4method{getDESeq2Dataset}{DsATAC}(.object, regionType, designCols, ...)
}
\arguments{
\item{.object}{\code{\linkS4class{DsATAC}} object}

\item{regionType}{character string specifying the region type}

\item{designCols}{column names in the sample annotation potentially used to create the design matrix}

\item{...}{parameters passed on to \code{DESeq2::DESeq}}
}
\value{
\code{DESeqDataSet} as returned by \code{DESeq2::DESeq}
}
\description{
Retrieve a differential expression dataset computed with DESeq2
}
\examples{
\dontrun{
dsa <- ChrAccRex::loadExample("dsAtac_ia_example")
dds <- getDESeq2Dataset(dsa, "IA_prog_peaks", designCols=c("donor", "stimulus", "cellType"))
dds
}
}
\author{
Fabian Mueller
}

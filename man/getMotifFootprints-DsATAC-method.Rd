% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DsATAC-class.R
\docType{methods}
\name{getMotifFootprints,DsATAC-method}
\alias{getMotifFootprints,DsATAC-method}
\alias{getMotifFootprints}
\title{getMotifFootprints-methods}
\usage{
\S4method{getMotifFootprints}{DsATAC}(.object, motifNames,
  samples = getSamples(.object), motifFlank = 250L, type = ".genome",
  motifDb = "jaspar")
}
\arguments{
\item{.object}{\code{\linkS4class{DsATAC}} object}

\item{motifNames}{character vector of motif names}

\item{samples}{sample identifiers}

\item{motifFlank}{number of base pairs flanking the motif on each side}

\item{type}{(PLACEHOLDER ARGUMENT: NOT IMPLEMENTED YET) character string specifying the region type or \code{".genome"} (default) for genome-wide profiling}

\item{motifDb}{either a character string (currently only "jaspar" and sets contained in \code{chromVARmotifs} ("homer", "encode", "cisbp") are supported) or an object containing PWMs
that can be used by \code{motifmatchr::matchMotifs} (such as an \code{PFMatrixList} or \code{PWMatrixList} object)}
}
\value{
a \code{list} of footprinting results with one element for each motif. Each motif's results contain summary data frames with aggregated counts
        across all motif occurrences and a \code{ggplot} object for plotting footprints
}
\description{
Perform enrichment analysis for (TF) motif footprinting
}
\examples{
\dontrun{
dsa <- ChrAccRex::loadExample("dsAtac_ia_example")
motifNames <- c("MA1419.1_IRF4", "MA0139.1_CTCF", "MA0037.3_GATA3")
# motifNames <- grep("(IRF4|CTCF|GATA3)$", names(prepareMotifmatchr("hg38", "jaspar")$motifs), value=TRUE, ignore.case=TRUE) # alternative by searching
samples <- c("TeffNaive_U_1001", "TeffNaive_U_1002", "TeffMem_U_1001", "TeffMem_U_1002")
fps <- getMotifFootprints(dsa, motifNames, samples)
fps[["MA1419.1_IRF4"]]$plot
}
}
\author{
Fabian Mueller
}

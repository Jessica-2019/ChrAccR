% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils_motifs.R
\name{getMotifClustering}
\alias{getMotifClustering}
\title{getMotifClustering}
\usage{
getMotifClustering(k = 0, distM = NULL, assembly = "hg38",
  motifs = "jaspar", clusterMethod = "pam")
}
\arguments{
\item{k}{number of clusters. \code{k<1} will result in an automatically selected clustering which is precomputed and stored in \code{ChrAccR}.
For \code{distMethod=="jaspar"} and \code{clusterMethod=="pam"} this corresponds to the k corresponding to the best silhouette value before a drop (in the silhouette elbow-curve) occurs}

\item{distM}{distance matrix (\code{dist} object) containing motif dissimilarities/distances. Only required if \code{k>0}.}

\item{assembly}{genome assembly for which the motifs dissimilarity should be retrieved. Only the species information
of the assembly is really relevant. Can be \code{"vert"} for all vertebrate motifs. Only required if for automatic mode (i.e. \code{k<1}).}

\item{motifs}{either a character string (currently only "jaspar" is supported) or an object containing PWMs
that can be used by \code{motifmatchr::matchMotifs} (\code{PWMatrixList} object)}

\item{clusterMethod}{method to be used for motif clustering (currently only \code{'pam'} (PAM - partitioning around medoids) is supported)}
}
\value{
a list structure containing the clustering result
}
\description{
Retrieve motif clustering of TF motifs
}
\author{
Fabian Mueller
}

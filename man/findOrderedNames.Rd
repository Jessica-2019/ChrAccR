% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{findOrderedNames}
\alias{findOrderedNames}
\title{findOrderedNames}
\usage{
findOrderedNames(x, orderedNames, exact = TRUE, ignore.case = FALSE)
}
\arguments{
\item{x}{character vector in which the name should be found}

\item{orderedNames}{vector of names that will be queried. This method will go through them one by one and find the first occurrence
in the order of the orderedNames provided}

\item{exact}{should only be exact matches be reported}

\item{ignore.case}{should casing be ignored}
}
\value{
the string that matches the first occurrence in the order of \code{orderedNames}. Returns \code{NA} if no match is found.
}
\description{
find the first occurrence of a name in a vector of strings
}
\author{
Fabian Mueller
}

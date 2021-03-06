################################################################################
# Methods for differential chromatin accessibility analysis - NOMe data
################################################################################

#-------------------------------------------------------------------------------
### computeDiffAcc.rnb.nome.bin.region
###
### computes a differential accessibitity (methylation in NOMe datasets) in the binary case (2 groups) on the region level.
### @author Fabian Mueller
### @aliases computeDiffAcc.rnb.nome
### @param dsn \code{\linkS4class{DsNOMe}} object
### @param dmtp differential methylation table on the site level (as obtained from \code{\link{RnBeads:::computeDiffMeth.bin.site}})
### @param inds.g1 column indices in \code{b} of group 1 members
### @param inds.g2 column indices in \code{b} of group 2 members
### @details
### Analogous to \code{RnBeads}' \code{computeDiffMeth.bin.region} function
### @return list of differential methylation tables
computeDiffAcc.rnb.nome.bin.region <- function(dsn, dmtp, inds.g1, inds.g2, regionTypes=getRegionTypes(dsn), ...){
	#sanity checks
	if (length(union(inds.g1,inds.g2)) != (length(inds.g1)+length(inds.g2))){
		logger.error("Overlapping sample sets in differential methylation analysis")
	}
	logger.start('Computing Differential Methylation Tables (Region Level)')
	skipSites <- FALSE
	if (is.null(dmtp)){
		logger.info("Computing differential methylation for regions directly (NOT using site-specific differential methylation)")
		skipSites <- TRUE
	}
	diffTabs <- list()
	for (rt in regionTypes){
		if (skipSites){
			covMat <- getCovg(dsn, rt, asMatrix=TRUE)
			dmtr <- RnBeads:::computeDiffMeth.bin.site(getMeth(dsn,rt, asMatrix=TRUE), inds.g1, inds.g2, covg=covMat, ...)
		} else {
			inclCov <- !is.null(getCovg(dsn, "sites", asMatrix=TRUE))
			regions2sites <- getRegionMapping(dsn, rt)
			dmtr <- RnBeads:::computeDiffTab.default.region(dmtp, regions2sites, includeCovg=inclCov)
			dmtr4ranks <- RnBeads:::extractRankingCols.region(dmtr)
			combRank <- RnBeads:::combinedRanking.tab(dmtr4ranks, rerank=FALSE)
			dmtr$combinedRank <- combRank
		}
		diffTabs <- c(diffTabs,list(dmtr))
		logger.status(c("Computed table for", rt))
	}
	names(diffTabs) <- regionTypes
	logger.completed()
	return(diffTabs)
}

#' computeDiffAcc.rnb.nome
#'
#' computes differential accessibility for NOMe datasets using \code{RnBeads} functionality
#' @author Fabian Mueller
#' @aliases rnb.execute.computeDiffMeth
#' @param dsn         \code{\linkS4class{DsNOMe}} object
#' @param cmpCols     column names of the sample annotation of the dataset that will be used for comparison
#' @param regionTypes which region types should be processed for differential analysis.
#' @param covgThres   coverage threshold for computing the summary statistics. See \code{RnBeads::computeDiffTab.extended.site} for details.
#' @param allPairs    Logical indicating whether all pairwise comparisons should be conducted, when more than 2 groups are present
#' @param adjPairCols argument passed on to \code{rnb.sample.groups}. See its documentation for details.
#' @param adjCols     not used yet
#' @param skipSites   flag indicating whether differential methylation in regions should be computed directly and not from sites. This leads to skipping of site-specific differential methylation
#' @param disk.dump Flag indicating whether the resulting differential methylation object should be file backed, ie.e the matrices dumped to disk
#' @param disk.dump.dir disk location for file backing of the resulting differential methylation object. Only meaningful if \code{disk.dump=TRUE}.
#' 						must be a character specifying an NON-EXISTING valid directory.
#' @param ... arguments passed on to binary differential methylation calling. See \code{RnBeads::computeDiffTab.extended.site} for details.
#' @return an \code{RnBDiffMeth} object. See class description for details.
#' @author Fabian Mueller
#' @export
computeDiffAcc.rnb.nome <- function(dsn, cmpCols, regionTypes=getRegionTypes(dsn), covgThres=5L,
		allPairs=TRUE, adjPairCols=NULL,
		adjCols=NULL,
		skipSites=FALSE,
		disk.dump=rnb.getOption("disk.dump.big.matrices"),disk.dump.dir=tempfile(pattern="diffMethTables_"),
		...){

	logger.start("Retrieving comparison info")
	cmpInfo <- getComparisonInfo(dsn, cmpNames=cmpCols, regionTypes=regionTypes, allPairs=allPairs, adjPairCols=adjPairCols, minGrpSize=1L, maxGrpCount=NULL)
	logger.completed()
	if (is.null(cmpInfo)) {
		return(NULL)
	}

	diff.method <- "limma"
	logger.start("Computing differential methylation tables")

	diffmeth <- new("RnBDiffMeth",site.test.method=diff.method,disk.dump=disk.dump,disk.path=disk.dump.dir)
	
	for (i in 1:length(cmpInfo)){
		cmpInfo.cur <- cmpInfo[[i]]
		logger.start(c("Comparing:",cmpInfo.cur$comparison))
		if (cmpInfo.cur$paired){
			logger.status("Conducting PAIRED analysis")
		}

		if (skipSites){
			logger.info("Skipping site-specific differential methylation calling")
			dm <- NULL
		} else {
			dm <- RnBeads:::computeDiffMeth.bin.site(
					getMeth(dsn, asMatrix=TRUE), inds.g1=cmpInfo.cur$group.inds$group1, inds.g2=cmpInfo.cur$group.inds$group2,
					covg=getCovg(dsn, asMatrix=TRUE), covg.thres=covgThres,
					paired=cmpInfo.cur$paired, adjustment.table=cmpInfo.cur$adjustment.table,
					...
			)
			diffmeth <- addDiffMethTable(diffmeth,dm,cmpInfo.cur$comparison,"sites",cmpInfo.cur$group.names)
		}
		cleanMem()
		if (length(cmpInfo.cur$region.types)>0){
			if (skipSites){
				dmr <- computeDiffAcc.rnb.nome.bin.region(dsn, NULL,
					cmpInfo.cur$group.inds$group1, cmpInfo.cur$group.inds$group2,
					regionTypes=cmpInfo.cur$region.types,
					covg.thres=covgThres,
					paired=cmpInfo.cur$paired, adjustment.table=cmpInfo.cur$adjustment.table,
					...
				)
			} else {
				dmr <- computeDiffAcc.rnb.nome.bin.region(dsn,dm,
					cmpInfo.cur$group.inds$group1,cmpInfo.cur$group.inds$group2,
					regionTypes=cmpInfo.cur$region.types
				)	
			}		
			for (rt in cmpInfo.cur$region.types){
				diffmeth <- addDiffMethTable(diffmeth,dmr[[rt]],cmpInfo.cur$comparison, 
					rt, cmpInfo.cur$group.names
				)
			}
		}
		logger.completed()
	}

	diffmeth <- RnBeads:::addComparisonInfo(diffmeth,cmpInfo)
	logger.completed()
	return(diffmeth)
}

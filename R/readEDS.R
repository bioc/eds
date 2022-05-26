#' A low-level utility function for quickly reading in
#' Alevin EDS format
#'
#' This provides a simple utility for reading in EDS format.
#' Note that most users will prefer to use tximport or tximeta.
#' This function and package exist in order
#' to simplify the dependency graph for other packages.
#' 
#' @param numOfGenes number of genes
#' @param numOfOriginalCells number of cells
#' @param countMatFilename pointer to the EDS file,
#' \code{quants_mat.gz}
#' @param tierImport whether the \code{countMatFilename}
#' refers to a quants tier file
#'
#' @return a genes x cells sparse matrix,
#' of the class \code{dgCMatrix}
#'
#' @import Rcpp Matrix
#' 
#' @useDynLib eds
#'
#' @examples
#'
#' # point to files
#' dir0 <- system.file("extdata",package="tximportData")
#' samps <- list.files(file.path(dir0, "alevin"))
#' dir <- file.path(dir0,"alevin",samps[3],"alevin")
#' quant.mat.file <- file.path(dir, "quants_mat.gz")
#' barcode.file <- file.path(dir, "quants_mat_rows.txt")
#' gene.file <- file.path(dir, "quants_mat_cols.txt")
#'
#' # readEDS() requires knowing the number of cells and genes
#' cell.names <- readLines(barcode.file)
#' gene.names <- readLines(gene.file)
#' num.cells <- length(cell.names)
#' num.genes <- length(gene.names)
#'
#' # reading in the sparse matrix
#' mat <- readEDS(
#'     numOfGenes=num.genes,
#'     numOfOriginalCells=num.cells,
#'     countMatFilename=quant.mat.file)
#' 
#' @export
readEDS <- function(numOfGenes,
                    numOfOriginalCells,
                    countMatFilename,
                    tierImport=FALSE) {
    getSparseMatrix(numOfGenes, numOfOriginalCells,
                    path.expand(countMatFilename), tierImport)
}

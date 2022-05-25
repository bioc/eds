context("readEDS")
library(fishpond)
test_that("Reading in Alevin EDS format works", {

  dir0 <- system.file("extdata",package="tximportData")
  samps <- list.files(file.path(dir0, "alevin"))
  dir <- file.path(dir0,"alevin",samps[3],"alevin")
  quant.mat.file <- file.path(dir, "quants_mat.gz")
  file.exists(quant.mat.file)
  
  barcode.file <- file.path(dir, "quants_mat_rows.txt")
  gene.file <- file.path(dir, "quants_mat_cols.txt")
  tier.file <- file.path(dir,"quants_tier_mat.gz")
  cell.names <- readLines(barcode.file)
  gene.names <- readLines(gene.file)
  num.cells <- length(cell.names)
  num.genes <- length(gene.names)

  # reading in quants
  files <- quant.mat.file
  mat <- readEDS(numOfGenes=num.genes,
                 numOfOriginalCells=num.cells,
                 countMatFilename=files)

  expect_equal(nrow(mat), num.genes)
  expect_equal(ncol(mat), num.cells)
  cts <- mat@x

  # max count is < 10,000 for this dataset
  expect_lte(max(cts), 1e4)
  expect_gte(min(cts), 0)

  # attempt reading in tier file
  files <- tier.file
  tier <- readEDS(numOfGenes=num.genes,
                  numOfOriginalCells=num.cells,
                  countMatFilename=files,
                  tierImport=TRUE)

  # tiers 1-3
  expect_true(all(tier@x %in% 1:3))
  
})

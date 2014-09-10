# GEDDES WRIGHT FRANTZ AUTHORITARIAN REGIMES (aut)
# 2014-09-06

# Source: http://dictators.la.psu.edu/

# Clear workspace
rm(list=ls(all=TRUE))

# Get working directory
wd <- getwd()

# Load required packages and functions
library(foreign)
library(DataCombine)
source(paste0(wd, "/r/f.pitfcodeit.r"))

# Ingest the data
aut <- read.dta(paste0(wd, "/data.in/gwftscs.dta"), convert.factors = FALSE, convert.underscore = TRUE)

# Change names to get right prefix
names(aut) <- c(names(aut)[1:2], "country", gsub("gwf", "aut", x = names(aut)[4:length(names(aut))], fixed = TRUE) )

# Add PITF country codes and cut extra ids
aut <- pitfcodeit(aut, "country")
aut$cowcode <- aut$country <- NULL

# Get the IDs at the start of the row
aut <- MoveFront(aut, c("sftgcode", "year"))

# Write it out
write.csv(aut, paste0(wd, "/data.out/aut.csv"), row.names = FALSE)

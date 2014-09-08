# DEMOCRACY DICTATORSHIP REVISITED DATA SET
# 2014-09-03

Source: https://sites.google.com/site/joseantoniocheibub/datasets/democracy-and-dictatorship-revisited

# Clear workspace
rm(list=ls(all=TRUE))

# Load required packages and functions
library(foreign)
source("c:/users/jay/documents/ushmm/statrisk.replication/r/f.pitfcodeit.r")
source("c:/users/jay/documents/ushmm/statrisk.replication/r/f.countryyearrackit.r")

# Ingest the data
ddr <- read.dta("c:/users/jay/documents/ushmm/statrisk.replication/data.in/ddrevisited_data_v1.dta",
  convert.underscore = TRUE)

# Add PITF codes
ddr <- pitfcodeit(ddr, "ctryname")

# Trim to main ID vars and substantive vars
ddr <- subset(ddr, select = c(79,3,46:78))

# add prefix to names
names(ddr) <- c("sftgcode", "year", paste0("ddr.", names(ddr)[3:length(names(ddr))]))

# Write it out
write.csv(ddr, "c:/users/jay/documents/ushmm/statrisk.replication/data.out/ddr.csv", row.names = FALSE)
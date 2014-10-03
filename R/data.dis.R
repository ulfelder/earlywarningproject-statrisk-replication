# DISCRIMINATION
# 2014-09-05

# Source: Center for Systemic Peace via PITF

# Clear workspace
rm(list=ls(all=TRUE))

#set working directory
setwd(commandArgs(TRUE)[1])

# Get working directory
wd <- getwd()

# Load required packages and functions
library(XLConnect)

require(methods)

source(paste0(wd, "/r/f.pitfcodeit.r"))
source(paste0(wd, "/r/f.countryyearrackit.r"))

# Load the data
dis <- readWorksheetFromFile(paste0(wd, commandArgs(TRUE)[2]), sheet=1)

# Append prefix to names
names(dis) <- c("sftgcode", "year", paste0("dis.", names(dis)[3:length(names(dis))]))

# Merge with complete rack of country-years to get complete set (original doesn't include countries w/all 0s)
rack <- merge(subset(pitfcodeit(countryyearrackit(min(dis$year), max(dis$year)), "country"),
  select = c(sftgcode, year)), dis, all.x = TRUE)

# Fill in NAs with 0s so variables don't get wiped out in transformation process
rack <- replace(rack, is.na(rack)==TRUE, 0)

# Write it out
write.csv(dis, file = paste0(wd, commandArgs(TRUE)[3]), row.names=FALSE)

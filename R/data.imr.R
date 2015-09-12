# INFANT MORTALITY ESTIMATES
# 2015-03-20

# Source: U.S. Census Bureau International Division, via PITF

# Clear workspace
rm(list=ls(all=TRUE))

# Get working directory
wd <- getwd()

# Load required packages and functions
library(DataCombine)
source(paste0(wd, "/r/f.countryyearrackit.r"))
source(paste0(wd, "/r/f.pitfcodeit.r"))

# Load file
imrates <- read.csv(paste0(wd, "/data.in/imr.csv"), stringsAsFactors = FALSE)

# Drop country name to avoid screwing up merging
imrates <- VarDrop(imrates, "SFTGNAME")

# Rename variables
names(imrates) <- c("sftgcode", "year", "imr.raw", "imr.normed")

# Fix UK country code to match main files
imrates$sftgcode[imrates$sftgcode=="UK"] <- "UKG"

# Merge with country-year rack to add USA, which source doesn't cover & reorder
rack <- merge(subset(pitfcodeit(countryyearrackit(1955, 2014), "country"), select=c(sftgcode, year)),
  imrates, all.x = TRUE)
rack <- rack[order(rack$sftgcode, rack$year),]

# Hard code values for USA, which source doesn't cover, to values for Canada
rack$imr.raw[rack$sftgcode=="USA"] <- rack$imr.raw[rack$sftgcode=="CAN"]
rack$imr.normed[rack$sftgcode=="USA"] <- rack$imr.normed[rack$sftgcode=="CAN"]

# Write it out
write.csv(rack, file = paste0(wd, "/data.out/imr.csv"), row.names = FALSE)
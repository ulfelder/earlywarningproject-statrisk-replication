# ELITE CHARACTERISTICS (elc)
# 2014-09-08

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

# Load raw data
elc <- readWorksheetFromFile(paste0(wd, commandArgs(TRUE)[2]), sheet=1)
names(elc) <- c("sftgcode", "year", "elceleth", "elceliti")
elc$sftgcode <- as.character(elc$sftgcode)

# Change some codes for merging
elc$sftgcode[elc$sftgcode=="SER"] <- "SRB"
elc$sftgcode[elc$sftgcode=="MNT"] <- "MNE"
elc$sftgcode[elc$sftgcode=="SSU"] <- "SSD"
elc$sftgcode[elc$sftgcode=="SDN"] <- "SUD"
elc$sftgcode[elc$sftgcode=="GMY"] <- "GER"

# Fix names to match prefixing scheme
names(elc) <- c("sftgcode", "year", "elc.eleth", "elc.eliti")

# Add rows and then hard code values for USA, which source doesn't cover
USA <- data.frame(rep("USA", times = max(elc$year) - min(elc$year) + 1), seq(min(elc$year), max(elc$year)),
  rep(0, times = max(elc$year) - min(elc$year) + 1), rep(0, times = max(elc$year) - min(elc$year) + 1))
names(USA) <- names(elc)
elc <- rbind(elc, USA)

write.csv(elc, file = paste0(wd, commandArgs(TRUE)[3]), row.names=FALSE)

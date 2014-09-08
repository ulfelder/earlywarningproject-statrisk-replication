# ELITE CHARACTERISTICS (elc)
# 2014-09-08

# Source: Center for Systemic Peace via PITF

# Clear workspace
rm(list=ls(all=TRUE))

# Load required packages and functions
library(XLConnect)

# Load raw data
elc <- readWorksheetFromFile("c:/users/jay/documents/ushmm/statrisk.replication/data.in/elc2013.xls", sheet=1)
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

# Hard code values for United States, which source doesn't cover
USA <- data.frame(rep("USA", times = max(elc$year) - min(elc$year) + 1), seq(min(elc$year), max(elc$year)),
  rep(0, times = max(elc$year) - min(elc$year) + 1), rep(0, times = max(elc$year) - min(elc$year) + 1))
names(USA) <- names(elc)
elc <- rbind(elc, USA)

write.csv(elc, "c:/users/jay/documents/ushmm/statrisk.replication/data.out/elc.csv", row.names=FALSE)

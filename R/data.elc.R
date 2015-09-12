# ELITE CHARACTERISTICS (elc)
# 2015-04-29

# Source: Center for Systemic Peace via PITF

# Clear workspace
rm(list=ls(all=TRUE))

# Get working directory
wd <- getwd()

# Load required packages and functions
library(XLConnect)

# Load raw data
ELC <- readWorksheetFromFile(paste0(wd, "/data.in/elc2014.xls"), sheet=1)

# Fix names to match prefixing scheme
names(ELC) <- c("sftgcode", "year", "elc.eleth", "elc.eliti")

# Change some codes for merging
ELC$sftgcode[ELC$sftgcode=="SER"] <- "SRB"
ELC$sftgcode[ELC$sftgcode=="MNT"] <- "MNE"
ELC$sftgcode[ELC$sftgcode=="SSU"] <- "SSD"
ELC$sftgcode[ELC$sftgcode=="SDN"] <- "SUD"
ELC$sftgcode[ELC$sftgcode=="GMY"] <- "GER"

# Add rows and then hard code values for USA, which source doesn't cover
USA <- data.frame(rep("USA", times = max(ELC$year) - min(ELC$year) + 1), seq(min(ELC$year), max(ELC$year)),
  rep(0, times = max(ELC$year) - min(ELC$year) + 1), rep(0, times = max(ELC$year) - min(ELC$year) + 1))
names(USA) <- names(ELC)
ELC <- rbind(ELC, USA)

write.csv(ELC, file = paste0(wd, "/data.out/elc.csv"), row.names = FALSE)

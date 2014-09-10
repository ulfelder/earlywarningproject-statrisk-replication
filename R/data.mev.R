# MAJOR EPISODES OF POLITICAL VIOLENCE DATA
# 2014-09-08

# Source: Center for Systemic Peace (http://www.systemicpeace.org/inscrdata.html)

# Clear the workspace
rm(list=ls(all=TRUE))

# Get working directory
wd <- getwd()

# Load required packages and functions
library(XLConnect)
library(reshape)

# Load the MEPV data set
mepv <- readWorksheetFromFile(paste0(wd, "/data.in/mepv2013.xls"), sheet=1)
mepv$ccode <- mepv$country <- NULL
mepv <- rename(mepv, c(scode="sftgcode"))

# Modify some country codes to match for merging
mepv$sftgcode[mepv$sftgcode=="GMY"] <- "GER"
mepv$sftgcode[mepv$sftgcode=="MNT"] <- "MNE"
mepv$sftgcode[mepv$sftgcode=="SER"] <- "SRB"
mepv$sftgcode[mepv$sftgcode=="SSU"] <- "SSD"
mepv$sftgcode[mepv$sftgcode=="SDN"] <- "SUD"

# Append prefix to names
names(mepv) <- c("sftgcode", "year", paste0("mev.", names(mepv)[3:length(names(mepv))]))

# Write it out
write.csv(mepv, file = paste0(wd, "/data.out/mev.csv"), row.names = FALSE)

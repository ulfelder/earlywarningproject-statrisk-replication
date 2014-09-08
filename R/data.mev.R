# MAJOR EPISODES OF POLITICAL VIOLENCE DATA
# 2014-09-08

# Source: Center for Systemic Peace (http://www.systemicpeace.org/inscrdata.html)

# Clear the workspace
rm(list=ls(all=TRUE))

# Load required packages and functions
library(XLConnect)
library(reshape)

# Load the MPEV data set
mepv <- readWorksheetFromFile("c:/users/jay/documents/ushmm/statrisk2014v2/indata/mepv2013.xls", sheet=1)
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
write.csv(mepv, "c:/users/jay/documents/ushmm/statrisk.replication/data.out/mev.csv", row.names=FALSE)

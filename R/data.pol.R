# POLITY IV
# 2014-09-08

# Source: Center for Systemic Peace (http://www.systemicpeace.org/inscrdata.html)

# Clear workspace
rm(list=ls(all=TRUE))

# Load required packages and functions
library(XLConnect)
library(reshape)

# Load data
polity <- readWorksheetFromFile("c:/users/jay/documents/ushmm/statrisk.replication/data.in/p4v2013.xls", sheet=1)

# Change country code variable name and correct a few codes to match PITF standard
polity <- rename(polity, c(scode = "sftgcode"))
polity$sftgcode[polity$sftgcode=="SER"] <- "SRB"
polity$sftgcode[polity$sftgcode=="MNT"] <- "MNE"
polity$sftgcode[polity$sftgcode=="GMY"] <- "GER"
polity$sftgcode[polity$sftgcode=="SSU"] <- "SSD"
polity$sftgcode[polity$sftgcode=="SDN"] <- "SUD"
polity$sftgcode[polity$sftgcode=="USR"] <- "USS"

# Drop extra ID variables and "regime transitions" variables (which don't really fit country-year format) and lop off
# years before 1945
polity <- subset(polity, year >= 1945, select = c(3,5,8:21))

# Append prefix to Polity variable names
names(polity) <- c(names(polity)[1:2], paste0("pol.", names(polity)[3:length(names(polity))]))

# Write it out
write.csv(polity, "c:/users/jay/documents/ushmm/statrisk.replication/data.out/pol.csv", row.names = FALSE)

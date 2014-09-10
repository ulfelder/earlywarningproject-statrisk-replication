# POLITY IV (pol)
# 2014-09-08

# Source: Center for Systemic Peace (http://www.systemicpeace.org/inscrdata.html)

# Clear workspace
rm(list=ls(all=TRUE))

# Get working directory
wd <- getwd()

# Load required packages and functions
library(XLConnect)
library(reshape)

# Load data
polity <- readWorksheetFromFile(paste0(wd, "/data.in/p4v2013.xls"), sheet = 1)

# Change country code variable name and correct a few codes to match PITF standard
polity <- rename(polity, c(scode = "sftgcode"))
polity$sftgcode[polity$sftgcode=="SER"] <- "SRB"
polity$sftgcode[polity$sftgcode=="MNT"] <- "MNE"
polity$sftgcode[polity$sftgcode=="GMY"] <- "GER"
polity$sftgcode[polity$sftgcode=="SSU"] <- "SSD"
polity$sftgcode[polity$sftgcode=="SDN"] <- "SUD"
polity$sftgcode[polity$sftgcode=="USR"] <- "USS"

# Drop extra ID vars & "regime transitions" vars (which don't fit country-year format) and cut to 1945+
polity <- subset(polity, year >= 1945, select = c(3,5,8:21))

# Append prefix to Polity variable names
names(polity) <- c(names(polity)[1:2], paste0("pol.", names(polity)[3:length(names(polity))]))

# Write it out
write.csv(polity, file = paste0(wd, "/data.out/pol.csv"), row.names = FALSE)

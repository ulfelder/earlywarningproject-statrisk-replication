# POLITY IV
# 2015-05-10

# Source: Center for Systemic Peace (http://www.systemicpeace.org/inscrdata.html)

# Clear workspace
rm(list=ls(all=TRUE))

# Get working directory
wd <- getwd()

# Load required packages and functions
library(XLConnect)
library(reshape)

# Load data
Polity <- readWorksheetFromFile(paste0(wd, "/data.in/p4v2014.xls"), sheet=1)

# Change country code variable name and correct a few codes to match PITF standard
Polity <- rename(Polity, c(scode = "sftgcode"))
Polity$sftgcode[Polity$sftgcode=="SER"] <- "SRB"
Polity$sftgcode[Polity$sftgcode=="MNT"] <- "MNE"
Polity$sftgcode[Polity$sftgcode=="GMY"] <- "GER"
Polity$sftgcode[Polity$sftgcode=="SSU"] <- "SSD"
Polity$sftgcode[Polity$sftgcode=="SDN"] <- "SUD"
Polity$sftgcode[Polity$sftgcode=="USR"] <- "USS"

# Drop extra ID vars & "regime transitions" vars (which don't fit country-year format) and cut to 1945+
Polity <- subset(Polity, year >= 1945, select = c(3,5,8:21))

# Append prefix to Polity variable names
names(Polity) <- c(names(Polity)[1:2], paste0("pol.", names(Polity)[3:length(names(Polity))]))

# Write it out
write.csv(Polity, file = paste0(wd, "/data.out/pol.csv"), row.names = FALSE)

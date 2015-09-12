# MAJOR EPISODES OF POLITICAL VIOLENCE
# 2015-05-16

# Source: Center for Systemic Peace (http://www.systemicpeace.org/inscrdata.html)

# Clear the workspace
rm(list=ls(all=TRUE))

# Get working directory
wd <- getwd()

# Load required packages and functions
library(XLConnect)
library(plyr) # Order of this and next apparently matters
library(dplyr)

# Load the updated MEPV data set
mepv <- readWorksheetFromFile(paste0(wd, "/data.in/mepv2014.xls"), sheet=1)
names(mepv) <- tolower(names(mepv))
mepv$ccode <- mepv$country <- NULL
mepv <- rename(mepv, sftgcode = scode)

# Modify some country codes to match for merging
mepv$sftgcode[mepv$sftgcode=="GMY"] <- "GER"
mepv$sftgcode[mepv$sftgcode=="MNT"] <- "MNE"
mepv$sftgcode[mepv$sftgcode=="SER"] <- "SRB"
mepv$sftgcode[mepv$sftgcode=="SSU"] <- "SSD"
mepv$sftgcode[mepv$sftgcode=="SDN"] <- "SUD"

# Append prefix to names
names(mepv) <- c(names(mepv)[1:2], paste0("mev.", names(mepv)[3:length(names(mepv))]))

# Load 2012 Full Set that includes regional designations and do same stuff to it.
mepv2012 <- readWorksheetFromFile(paste0(wd, "/data.in/mepv2012n.xls"), sheet=1)
names(mepv2012) <- tolower(names(mepv2012))
mepv2012 <- rename(mepv2012, sftgcode = scode)
mepv2012$sftgcode[mepv2012$sftgcode=="GMY"] <- "GER"
mepv2012$sftgcode[mepv2012$sftgcode=="MNT"] <- "MNE"
mepv2012$sftgcode[mepv2012$sftgcode=="SER"] <- "SRB"
mepv2012$sftgcode[mepv2012$sftgcode=="SSU"] <- "SSD"
mepv2012$sftgcode[mepv2012$sftgcode=="SDN"] <- "SUD"

# Get table of country codes and regions
regions <- ddply(mepv2012, .(sftgcode), summarise, mev.region = max(region, na.rm=TRUE))

# Append row for Montenegro, which is getting dropped or isn't there, and fix type
regions <- rbind(regions, c("MNE", 0))
regions$mev.region <- as.numeric(regions$mev.region)

# Merge that table with the updated data set, using all.x=TRUE to expand merging across all relevant
# rows for each country code.
mepv <- merge(mepv, regions, all.x=TRUE)

# Order the data by country name and year
mepv <- mepv[order(mepv$sftgcode, mepv$year),]

# Write it out
write.csv(mepv, file = paste0(wd, "/data.out/mev.csv"), row.names = FALSE)

# POWELL AND THYNE COUP DATA
# 2014-09-03

# Source: Powell & Thyne http://www.uky.edu/~clthyn2/coup_data/powell_thyne_coups_final.txt 

# Clear workspace
rm(list=ls(all=TRUE))

#set working directory
setwd(commandArgs(TRUE)[1])

# Get working directory
wd <- getwd()

# Load required packages and functions
library(reshape)
source(paste0(wd, "/r/f.pitfcodeit.r"))
source(paste0(wd, "/r/f.countryyearrackit.r"))

# Ingest raw data, which is event file (one row per event), not country-year, from URL
cpt <- read.delim(commandArgs(TRUE)[2])
cpt <- subset(cpt, select=c("country", "year", "coup"))

# Create binary variables for success & failure of attempts from categorical variable in original
cpt$cpt.succ <- ifelse(cpt$coup==2, 1, 0)
cpt$cpt.fail <- ifelse(cpt$coup==1, 1, 0)

# Add PITF Codes
cpt <- pitfcodeit(cpt, "country")

# Generate country-year counts with tapply
ptsum.s <- tapply(cpt$cpt.succ, list(cpt$sftgcode, cpt$year), sum)
ptsum.f <- tapply(cpt$cpt.fail, list(cpt$sftgcode, cpt$year), sum)

# Reshape the country-year counts into long data frames
pt.s <- melt(ptsum.s)
pt.f <- melt(ptsum.f)
names(pt.s) <- c("sftgcode", "year", "cpt.succ")
names(pt.f) <- c("sftgcode", "year", "cpt.fail")

# Generate a complete country-year rectangular file for P&T period of observation (1950-2013+)
rack <- subset(pitfcodeit(countryyearrackit(1950,2013), "country"), select=c(sftgcode, year))

# Merge the counts with the larger file
pt.tscs <- merge(rack, pt.s, all.x = TRUE)
pt.tscs <- merge(pt.tscs, pt.f, all.x = TRUE)
pt.tscs <- pt.tscs[order(pt.tscs$sftgcode, pt.tscs$year),]

# Fill in missing values with 0s; rack only includes all valid country-years, but tapply of event list
# leaves missing values for country-years that have no events.
pt.tscs[is.na(pt.tscs)] <- 0

# Write it out
write.csv(pt.tscs, file = paste0(wd, commandArgs(TRUE)[3]), row.names = FALSE)
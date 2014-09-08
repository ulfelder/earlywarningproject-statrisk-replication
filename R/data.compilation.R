# DATA COMPILATION
# 2014-09-06

# Clear workspace
rm(list=ls(all=TRUE))

# Load required packages and functions
source("c:/users/jay/documents/ushmm/statrisk.replication/r/f.countryyearrackit.r")
source("c:/users/jay/documents/ushmm/statrisk.replication/r/f.pitfcodeit.r")

# Set working directory
setwd("c:/users/jay/documents/ushmm/statrisk.replication/data.out/")

# Load the raw data sets
mkl <- read.csv("mkl.csv")
wdi <- read.csv("wdi.csv")
cpt <- read.csv("cpt.csv")
cmm <- read.csv("cmm.csv")
pol <- read.csv("pol.csv")
pit <- read.csv("pit.csv")
mev <- read.csv("mev.csv")
ios <- read.csv("ios.csv")
imr <- read.csv("imr.csv")
elc <- read.csv("elc.csv")
dis <- read.csv("dis.csv")
elf <- read.csv("elf.csv")
imf <- read.csv("imf.csv")
hum <- read.csv("hum.csv")
fiw <- read.csv("fiw.csv")
aut <- read.csv("aut.csv")

# Create a country-year rack covering the requisite years
rack <- countryyearrackit(1945,2013)
rack <- pitfcodeit(rack, "country")

# Merge the data sets with the rack
dat <- merge(rack, mkl, all.x = TRUE)
dat <- merge(dat, wdi, all.x = TRUE)
dat <- merge(dat, cmm, all.x = TRUE)
dat <- merge(dat, cpt, all.x = TRUE)
dat <- merge(dat, pol, all.x = TRUE) # Adds one row, & I can't figure out why/where. Always something...
dat <- merge(dat, pit, all.x = TRUE)
dat <- merge(dat, mev, all.x = TRUE)
dat <- merge(dat, ios, all.x = TRUE)
dat <- merge(dat, imr, all.x = TRUE)
dat <- merge(dat, elc, all.x = TRUE)
dat <- merge(dat, dis, all.x = TRUE)
dat <- merge(dat, elf, all.x = TRUE)
dat <- merge(dat, imf, all.x = TRUE)
dat <- merge(dat, fiw, all.x = TRUE)
dat <- merge(dat, aut, all.x = TRUE)
dat <- merge(dat, hum, all.x = TRUE)

# Order the file by country name and year for easier review
dat <- dat[order(dat$country, dat$year),]

# Write that data frame to .csv.
write.csv(dat, file = "ewp.statrisk.data.raw.csv", row.names = FALSE)

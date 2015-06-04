# PITF PROBLEM SET (pit)
# 2014-09-02

# Source: Center for Systemic Peace
# http://www.systemicpeace.org/inscr/inscr.htm

# This script takes the spreadsheets with information on political instability episodes identified for PITF
# and turns them into country-year data with new variables indicating onsets and duration of instability
# episodes by type and overall.

# Clear workspace
rm(list=ls(all=TRUE))

#set working directory
setwd(commandArgs(TRUE)[1])

# Get working directory
wd <- getwd()

# Load required packages and functions
library(XLConnect)
library(reshape)

require(methods)

source(paste0(wd, "/R/f.countryyearrackit.R"))
source(paste0(wd, "/R/f.pitfcodeit.R"))

# Adverse regime change
reg <- readWorksheetFromFile(paste0(wd, commandArgs(TRUE)[2]),
  sheet=1, startCol=1, endCol=13)
reg <- subset(reg, select=c("SCODE", "YEAR", "YRBEGIN", "YREND", "MAGFAIL", "MAGCOL", "MAGVIOL", "MAGAVE"))
reg$pit.reg.ongoing <- 1
reg$pit.reg.onset <- ifelse(reg$YEAR == reg$YRBEGIN, 1, 0)
reg$pit.reg.end <- ifelse(reg$YEAR == reg$YREND, 1, 0)
reg$pit.reg.dur <- reg$YEAR - reg$YRBEGIN + 1
reg$YRBEGIN <- reg$YREND <- NULL
names(reg) <- c("sftgcode", "year", "pit.reg.magfail", "pit.reg.magcol", "pit.reg.magviol", "pit.reg.magave",
    "pit.reg.ongoing", "pit.reg.onset", "pit.reg.end", "pit.reg.dur")

eth <- readWorksheetFromFile(paste0(wd, commandArgs(TRUE)[3]),
  sheet=1, startCol=1, endCol=13)
eth <- subset(eth, select=c("SCODE", "YEAR", "YRBEGIN", "YREND", "MAGFIGHT", "MAGFATAL", "MAGAREA", "AVEMAG"))
eth$pit.eth.ongoing <- 1
eth$pit.eth.onset <- ifelse(eth$YEAR == eth$YRBEGIN, 1, 0)
eth$pit.eth.end <- ifelse(eth$YEAR == eth$YREND, 1, 0)
eth$pit.eth.dur <- eth$YEAR - eth$YRBEGIN + 1
eth$YRBEGIN <- eth$YREND <- NULL
names(eth) <- c("sftgcode", "year", "pit.eth.magfight", "pit.eth.magfatal", "pit.eth.magarea",
  "pit.eth.magave", "pit.eth.ongoing", "pit.eth.onset", "pit.eth.end", "pit.eth.dur")
ethmagfight <- tapply(eth$pit.eth.magfight, list(eth$sftgcode, eth$year), max, na.rm=TRUE)
ethmagfight <- melt(ethmagfight)
names(ethmagfight) <- c("sftgcode", "year", "pit.eth.magfight")
ethmagfatal <- tapply(eth$pit.eth.magfatal, list(eth$sftgcode, eth$year), max, na.rm=TRUE)
ethmagfatal <- melt(ethmagfatal)
names(ethmagfatal) <- c("sftgcode", "year", "pit.eth.magfatal")
ethmagarea <- tapply(eth$pit.eth.magarea, list(eth$sftgcode, eth$year), max, na.rm=TRUE)
ethmagarea <- melt(ethmagarea)
names(ethmagarea) <- c("sftgcode", "year", "pit.eth.magarea")
ethmagave <- tapply(eth$pit.eth.magave, list(eth$sftgcode, eth$year), max, na.rm=TRUE)
ethmagave <- melt(ethmagave)
names(ethmagave) <- c("sftgcode", "year", "pit.eth.magave")
ethongoing <- tapply(eth$pit.eth.ongoing, list(eth$sftgcode, eth$year), max, na.rm=TRUE)
ethongoing <- melt(ethongoing)
names(ethongoing) <- c("sftgcode", "year", "pit.eth.ongoing")
ethonset <- tapply(eth$pit.eth.onset, list(eth$sftgcode, eth$year), max, na.rm=TRUE)
ethonset <- melt(ethonset)
names(ethonset) <- c("sftgcode", "year", "pit.eth.onset")
ethend <- tapply(eth$pit.eth.end, list(eth$sftgcode, eth$year), max, na.rm=TRUE)
ethend <- melt(ethend)
names(ethend) <- c("sftgcode", "year", "pit.eth.end")
ethdur <- tapply(eth$pit.eth.dur, list(eth$sftgcode, eth$year), min, na.rm=TRUE)
ethdur <- melt(ethdur)
names(ethdur) <- c("sftgcode", "year", "pit.eth.dur")
ethc <- merge(ethmagfight, ethmagfatal)
ethc <- merge(ethc, ethmagarea)
ethc <- merge(ethc, ethmagave)
ethc <- merge(ethc, ethongoing)
ethc <- merge(ethc, ethonset)
ethc <- merge(ethc, ethend)
ethc <- merge(ethc, ethdur)
ethc$sftgcode <- as.character(ethc$sftgcode)
eth <- na.omit(ethc)

rev <- readWorksheetFromFile(paste0(wd, commandArgs(TRUE)[4]),
  sheet=1, startCol=1, endCol=13)
rev <- subset(rev, select=c("SCODE", "YEAR", "YRBEGIN", "YREND", "MAGFIGHT", "MAGFATAL", "MAGAREA", "AVEMAG"))
rev$pit.rev.ongoing <- 1
rev$pit.rev.onset <- ifelse(rev$YEAR == rev$YRBEGIN, 1, 0)
rev$pit.rev.end <- ifelse(rev$YEAR == rev$YREND, 1, 0)
rev$pit.rev.dur <- rev$YEAR - rev$YRBEGIN + 1
rev$YRBEGIN <- rev$YREND <- NULL
names(rev) <- c("sftgcode", "year", "pit.rev.magfight", "pit.rev.magfatal", "pit.rev.magarea",
  "pit.rev.magave", "pit.rev.ongoing", "pit.rev.onset", "pit.rev.end", "pit.rev.dur")
# Next block of code deals with years w/more than 1 rev episode ongoing
revmagfight <- tapply(rev$pit.rev.magfight, list(rev$sftgcode, rev$year), max, na.rm=TRUE)
revmagfight <- melt(revmagfight)
names(revmagfight) <- c("sftgcode", "year", "pit.rev.magfight")
revmagfatal <- tapply(rev$pit.rev.magfatal, list(rev$sftgcode, rev$year), max, na.rm=TRUE)
revmagfatal <- melt(revmagfatal)
names(revmagfatal) <- c("sftgcode", "year", "pit.rev.magfatal")
revmagarea <- tapply(rev$pit.rev.magarea, list(rev$sftgcode, rev$year), max, na.rm=TRUE)
revmagarea <- melt(revmagarea)
names(revmagarea) <- c("sftgcode", "year", "pit.rev.magarea")
revmagave <- tapply(rev$pit.rev.magave, list(rev$sftgcode, rev$year), max, na.rm=TRUE)
revmagave <- melt(revmagave)
names(revmagave) <- c("sftgcode", "year", "pit.rev.magave")
revongoing <- tapply(rev$pit.rev.ongoing, list(rev$sftgcode, rev$year), max, na.rm=TRUE)
revongoing <- melt(revongoing)
names(revongoing) <- c("sftgcode", "year", "pit.rev.ongoing")
revonset <- tapply(rev$pit.rev.onset, list(rev$sftgcode, rev$year), max, na.rm=TRUE)
revonset <- melt(revonset)
names(revonset) <- c("sftgcode", "year", "pit.rev.onset")
revend <- tapply(rev$pit.rev.end, list(rev$sftgcode, rev$year), max, na.rm=TRUE)
revend <- melt(revend)
names(revend) <- c("sftgcode", "year", "pit.rev.end")
revdur <- tapply(rev$pit.rev.dur, list(rev$sftgcode, rev$year), min, na.rm=TRUE)
revdur <- melt(revdur)
names(revdur) <- c("sftgcode", "year", "pit.rev.dur")
revc <- merge(revmagfight, revmagfatal)
revc <- merge(revc, revmagarea)
revc <- merge(revc, revmagave)
revc <- merge(revc, revongoing)
revc <- merge(revc, revonset)
revc <- merge(revc, revend)
revc <- merge(revc, revdur)
revc$sftgcode <- as.character(revc$sftgcode)
rev <- na.omit(revc)

gen <- readWorksheetFromFile(paste0(wd, commandArgs(TRUE)[5]),
  sheet = 1, startCol = 1, endCol = 10)
gen <- subset(gen, select=c("SCODE", "YEAR", "YRBEGIN", "YREND", "DEATHMAG"))
gen$pit.gen.ongoing <- 1
gen$pit.gen.onset <- ifelse(gen$YEAR == gen$YRBEGIN, 1, 0)
gen$pit.gen.end <- ifelse(gen$YEAR == gen$YREND, 1, 0)
gen$pit.gen.dur <- gen$YEAR - gen$YRBEGIN + 1
gen$YRBEGIN <- gen$YREND <- NULL
names(gen) <- c("sftgcode", "year", "pit.gen.deathmag", "pit.gen.ongoing", "pit.gen.onset",
  "pit.gen.end", "pit.gen.dur")

# Merge those files with a full country-year rack for PITF observations
pitfps <- merge(subset(pitfcodeit(countryyearrackit(1955,2013), "country"), select = c(sftgcode, year)),
  reg, all.x = TRUE)
pitfps <- merge(pitfps, rev, all.x = TRUE)
pitfps <- merge(pitfps, eth, all.x = TRUE)
pitfps <- merge(pitfps, gen, all.x = TRUE)
pitfps[is.na(pitfps)] <- 0
pitfps <- pitfps[order(pitfps$sftgcode, pitfps$year),]

write.csv(pitfps, paste0(wd, commandArgs(TRUE)[6]), row.names = FALSE)

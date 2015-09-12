# PITF PROBLEM SET (pit)
# 2015-04-30

# Source: Center for Systemic Peace
# http://www.systemicpeace.org/inscr/inscr.htm

# This script takes the spreadsheets with information on political instability episodes identified for PITF
# and turns them into country-year data with new variables indicating onsets and duration of instability
# episodes by type and overall.

# Clear workspace
rm(list=ls(all=TRUE))

# Get working directory
wd <- getwd()

# Load required packages and functions
library(XLConnect)
library(reshape)
library(plyr)
source(paste0(wd, "/r/f.countryyearrackit.r"))
source(paste0(wd, "/r/f.pitfcodeit.r"))

# Adverse regime change
reg <- readWorksheetFromFile(paste0(wd, "/data.in/pitf adverse regime change 2014.xls"),
  sheet=1, startCol=1, endCol=13)
reg <- subset(reg, select=c("SCODE", "YEAR", "YRBEGIN", "YREND", "MAGFAIL", "MAGCOL", "MAGVIOL", "MAGAVE"))
reg$pit.reg.ongoing <- 1
reg$pit.reg.onset <- ifelse(reg$YEAR == reg$YRBEGIN, 1, 0)
reg$pit.reg.end <- ifelse(reg$YEAR == reg$YREND, 1, 0)
reg$pit.reg.dur <- reg$YEAR - reg$YRBEGIN + 1
reg$YRBEGIN <- reg$YREND <- NULL
names(reg) <- c("sftgcode", "year", "pit.reg.magfail", "pit.reg.magcol", "pit.reg.magviol", "pit.reg.magave",
    "pit.reg.ongoing", "pit.reg.onset", "pit.reg.end", "pit.reg.dur")

# Ethnic war
eth <- readWorksheetFromFile(paste0(wd, "/data.in/pitf ethnic war 2014.xls"),
  sheet=1, startCol=1, endCol=13)
eth <- subset(eth, select=c("SCODE", "YEAR", "YRBEGIN", "YREND", "MAGFIGHT", "MAGFATAL", "MAGAREA", "AVEMAG"))
eth$pit.eth.ongoing <- 1
eth$pit.eth.onset <- ifelse(eth$YEAR == eth$YRBEGIN, 1, 0)
eth$pit.eth.end <- ifelse(eth$YEAR == eth$YREND, 1, 0)
eth$pit.eth.dur <- eth$YEAR - eth$YRBEGIN + 1
eth$YRBEGIN <- eth$YREND <- NULL
names(eth) <- c("sftgcode", "year", "pit.eth.magfight", "pit.eth.magfatal", "pit.eth.magarea",
  "pit.eth.magave", "pit.eth.ongoing", "pit.eth.onset", "pit.eth.end", "pit.eth.dur")
# Some countries have more than one at a time. This bit reduces from list to country-year panel, using
# the maximum intensity and minimum duration.
ETH <- ddply(eth, .(sftgcode, year), summarize,
     pit.eth.magfight = max(pit.eth.magfight),
     pit.eth.magfatal = max(pit.eth.magfatal),
     pit.eth.magarea = max(pit.eth.magarea),
     pit.eth.magave = max(pit.eth.magave),
     pit.eth.ongoing = max(pit.eth.ongoing),
     pit.eth.onset = max(pit.eth.onset),
     pit.eth.end = max(pit.eth.end),
     pit.eth.dur = min(pit.eth.dur))

# Revolutionary war
rev <- readWorksheetFromFile(paste0(wd, "/data.in/pitf revolutionary war 2014.xls"),
  sheet=1, startCol=1, endCol=13)
rev <- subset(rev, select=c("SCODE", "YEAR", "YRBEGIN", "YREND", "MAGFIGHT", "MAGFATAL", "MAGAREA", "AVEMAG"))
rev$pit.rev.ongoing <- 1
rev$pit.rev.onset <- ifelse(rev$YEAR == rev$YRBEGIN, 1, 0)
rev$pit.rev.end <- ifelse(rev$YEAR == rev$YREND, 1, 0)
rev$pit.rev.dur <- rev$YEAR - rev$YRBEGIN + 1
rev$YRBEGIN <- rev$YREND <- NULL
names(rev) <- c("sftgcode", "year", "pit.rev.magfight", "pit.rev.magfatal", "pit.rev.magarea",
  "pit.rev.magave", "pit.rev.ongoing", "pit.rev.onset", "pit.rev.end", "pit.rev.dur")
# Some countries have more than one at a time. This bit reduces from list to country-year panel, using
# the maximum intensity and minimum duration.
REV <- ddply(rev, .(sftgcode, year), summarize,
     pit.rev.magfight = max(pit.rev.magfight),
     pit.rev.magfatal = max(pit.rev.magfatal),
     pit.rev.magarea = max(pit.rev.magarea),
     pit.rev.magave = max(pit.rev.magave),
     pit.rev.ongoing = max(pit.rev.ongoing),
     pit.rev.onset = max(pit.rev.onset),
     pit.rev.end = max(pit.rev.end),
     pit.rev.dur = min(pit.rev.dur))

gen <- readWorksheetFromFile(paste0(wd, "/data.in/pitf genopoliticide 2014.xls"),
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
pitfps <- merge(subset(pitfcodeit(countryyearrackit(1955,2014), "country"), select = c(sftgcode, year)),
  reg, all.x = TRUE)
pitfps <- merge(pitfps, REV, all.x = TRUE)
pitfps <- merge(pitfps, ETH, all.x = TRUE)
pitfps <- merge(pitfps, gen, all.x = TRUE)
pitfps[is.na(pitfps)] <- 0
pitfps <- pitfps[order(pitfps$sftgcode, pitfps$year),]

write.csv(pitfps, paste0(wd, "/data.out/pit.csv"), row.names = FALSE)
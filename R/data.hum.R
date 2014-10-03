# LATENT HUMAN RIGHTS PROTECTION SCORES (hum)
# 2014-09-06

# Source: http://thedata.harvard.edu/dvn/dv/HumanRightsScores/faces/study/StudyPage.xhtml?globalId=doi:10.7910/DVN/24872

# Clear workspace
rm(list=ls(all=TRUE))

#set working directory
setwd(commandArgs(TRUE)[1])

# Get working directory
wd <- getwd()

# Load requisite packages and functions
library(DataCombine)
source(paste0(wd, "/r/f.pitfcodeit.r"))

# Ingest data
hum <- read.csv(paste0(wd, commandArgs(TRUE)[2]))

# Add PITF country codes
hum$country <- as.character(hum$NAME)
hum <- pitfcodeit(hum, "country")

# Drop set of observations for subset of Israel (pre-1967 borders only); keep whole-country numbers
hum <- subset(hum, country!="Israel, pre-1967 borders")

# Get rid of extraneous ID variables
hum$country <- hum$COW <- hum$NAME <- NULL

# Rename variables
names(hum) <- c("year", "hum.ciri", "hum.disap", "hum.kill", "hum.polpris", "hum.tort", "hum.amnesty",
  "hum.state", "hum.hathaway", "hum.itt", "hum.genocide", "hum.rummel", "hum.mass.repress", "hum.executions",
  "hum.killing", "hum.additive", "hum.latentmean", "hum.latentsd", "sftgcode")

# Get IDs at front
hum <- MoveFront(hum, c("sftgcode", "year"))

# Round the latent estimates to nearest .01
hum$hum.latentmean <- round(hum$hum.latentmean, 2)
hum$hum.latentsd <- round(hum$hum.latentsd, 2)

# Write out
write.csv(hum, file = paste0(wd, commandArgs(TRUE)[3]), row.names = FALSE)

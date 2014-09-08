# LATENT HUMAN RIGHTS PROTECTION SCORES (hum)
# 2014-09-06

# Source: http://thedata.harvard.edu/dvn/dv/HumanRightsScores/faces/study/StudyPage.xhtml?globalId=doi:10.7910/DVN/24872

# Clear workspace
rm(list=ls(all=TRUE))

# Load requisite packages and functions
source("c:/users/jay/documents/ushmm/statrisk.replication/r/f.pitfcodeit.r")

# Ingest data
hum <- read.csv("c:/users/jay/documents/ushmm/statrisk.replication/data.in/HumanRightsProtectionScores_v2.03.csv")

# Add PITF country codes
hum$country <- as.character(hum$NAME)
hum <- pitfcodeit(hum, "country")

# Drop set of observations for subset of Israel (pre-1967 borders only)
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
write.csv(hum, "c:/users/jay/documents/ushmm/statrisk.replication/data.out/hum.csv", row.names = FALSE)

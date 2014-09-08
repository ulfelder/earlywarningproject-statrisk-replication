# CINGRANELLI AND RICHARDS HUMAN RIGHTS DATA (cir)
# 2014-09-03

# Source: http://www.humanrightsdata.com/p/data-documentation.html
# "Complete CIRI Data, 1981-2001 (.csv format)", save as "ciri2013.csv"

# Clear workspace
rm(list=ls(all=TRUE))

# Load requisite packages and functions
source("c:/users/jay/documents/ushmm/statrisk.replication/r/f.pitfcodeit.r")
source("c:/users/jay/documents/ushmm/statrisk.replication/r/f.countryyearrackit.r")

ciri <- read.csv("c:/users/jay/documents/chenoweth project/indata/ciri2013.csv")
ciri$CIRI <- ciri$COW <- ciri$POLITY <- ciri$UNCTRY <- ciri$UNREG <- ciri$UNSUBREG <- NULL
ciri$OLD_EMPINX <- ciri$OLD_MOVE <- ciri$OLD_RELFRE <- ciri$X <- NULL
names(ciri) <- c("name", "year", "cir.physint", "cir.disap", "cir.kill", "cir.polpris", "cir.tort", "cir.newempinx", 
                 "cir.assn", "cir.formov", "cir.dommov", "cir.speech", "cir.elecsd", "cir.newrelfre", "cir.worker",
                 "cir.wecon", "cir.wopol", "cir.wosoc", "cir.injud")
ciri$name <- as.character(ciri$name)
ciri$name[ciri$name=="Yugoslavia, Federal Republic of" & (ciri$year < 2000 | ciri$year > 2002)] <- "LaLaLand"
ciri$name[ciri$name=="Serbia and Montenegro" & ciri$year < 2000] <- "Yugoslavia, Federal Republic of"
ciri$name[ciri$name=="Serbia and Montenegro" & ciri$year > 1999 & ciri$year < 2003] <- "LaLaLand"
ciri$name[ciri$name=="Serbia and Montenegro" & ciri$year > 2005] <- "LaLaLand"
ciri$name[ciri$name=="Yugoslavia" & ciri$year > 1991] <- "LaLaLand"
ciri <- subset(ciri, name!="LaLaLand")

ciri <- pitfcodeit(ciri, "name")
ciri$name <- NULL

ciri <- subset(ciri, is.na(sftgcode)==FALSE)

write.csv(ciri, "c:/users/jay/documents/ushmm/statrisk.replication/data.out/cir.csv", row.names = FALSE)
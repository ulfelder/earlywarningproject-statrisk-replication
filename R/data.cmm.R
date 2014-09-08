# MARSHALL (CENTER FOR SYSTEMIC PEACE) COUP DATA
# 2014-09-03

# Source: Center for Systemic Peace http://www.systemicpeace.org/inscr/CSPCoupsList2012.xls

# Clear workspace
rm(list=ls(all=TRUE))

# Load required packages and functions
library(XLConnect)
library(reshape)
source("c:/users/jay/documents/ushmm/statrisk.replication/r/f.pitfcodeit.r")
source("c:/users/jay/documents/ushmm/statrisk.replication/r/f.countryyearrackit.r")

# Get the data, which is an event file (one row per event), not country-year
csp <- readWorksheetFromFile("c:/users/jay/documents/ushmm/statrisk.replication/data.in/cspcoupslist2013.xls", sheet=1)

# Cut down to the essentials
csp <- subset(csp, is.na(scode)==FALSE, select=c(scode, year, success))
names(csp) <- c("sftgcode", "year", "success")

# Generate binary versions for each event type
csp$successful <- ifelse(csp$success==1, 1, 0)
csp$failed <- ifelse(csp$success==2, 1, 0)
csp$plot <- ifelse(csp$success==3, 1, 0)
csp$rumor <- ifelse(csp$success==4, 1, 0)

# Generate country-year counts from event list
coupsum.s <- tapply(csp$successful, list(csp$sftgcode, csp$year), sum)
coupsum.f <- tapply(csp$failed, list(csp$sftgcode, csp$year), sum)
coupsum.p <- tapply(csp$plot, list(csp$sftgcode, csp$year), sum)
coupsum.r <- tapply(csp$rumor, list(csp$sftgcode, csp$year), sum)
coup.s <- melt(coupsum.s)
coup.f <- melt(coupsum.f)
coup.p <- melt(coupsum.p)
coup.r <- melt(coupsum.r)
names(coup.s) <- c("sftgcode", "year", "cmm.succ")
names(coup.f) <- c("sftgcode", "year", "cmm.fail")
names(coup.p) <- c("sftgcode", "year", "cmm.plot")
names(coup.r) <- c("sftgcode", "year", "cmm.rumr")

# Generate a complete country-year rectangular file for CSP period of observation (1946-2013)
rack <- countryyearrackit(1946,2013)  # Need to end at last fully observed year
rack <- pitfcodeit(rack, "country")  # Add PITF codes
rack <- subset(rack, select=c(sftgcode, year))

# Merge the CSP country-year sums with that larger file
csp.tscs <- merge(rack, coup.s, all.x = TRUE)
csp.tscs <- merge(csp.tscs, coup.f, all.x = TRUE)
csp.tscs <- merge(csp.tscs, coup.p, all.x = TRUE)
csp.tscs <- merge(csp.tscs, coup.r, all.x = TRUE)

# Fill in missing values with 0s; rack only includes all valid country-years, & tapply of event list
# leaves missing values for country-years that have no events.
csp.tscs[is.na(csp.tscs)] <- 0

# Order by country and year
csp.tscs <- csp.tscs[order(csp.tscs$sftgcode, csp.tscs$year),]

# Write it out
write.csv(csp.tscs, "c:/users/jay/documents/ushmm/statrisk.replication/data.out/cmm.csv", row.names = FALSE)

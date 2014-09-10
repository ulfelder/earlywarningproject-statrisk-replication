# DATA TRANSFORMATION
# 2014-09-08

# Clear workspace
rm(list=ls(all=TRUE))

# Get working directory
wd <- getwd()

# Load required packages and functions
library(DataCombine)
library(plyr)
library(plm)
library(Hmisc)
source(paste0(wd, "/r/f.countryyearrackit.r"))
source(paste0(wd, "/r/f.pitfcodeit.r"))

# Load the raw data sets
mkl <- read.csv(paste0(wd, "/data.out/mkl.csv"))
wdi <- read.csv(paste0(wd, "/data.out/wdi.csv"))
cpt <- read.csv(paste0(wd, "/data.out/cpt.csv"))
cmm <- read.csv(paste0(wd, "/data.out/cmm.csv"))
pol <- read.csv(paste0(wd, "/data.out/pol.csv"))
pit <- read.csv(paste0(wd, "/data.out/pit.csv"))
mev <- read.csv(paste0(wd, "/data.out/mev.csv"))
ios <- read.csv(paste0(wd, "/data.out/ios.csv"))
imr <- read.csv(paste0(wd, "/data.out/imr.csv"))
elc <- read.csv(paste0(wd, "/data.out/elc.csv"))
dis <- read.csv(paste0(wd, "/data.out/dis.csv"))
elf <- read.csv(paste0(wd, "/data.out/elf.csv"))
imf <- read.csv(paste0(wd, "/data.out/imf.csv"))
hum <- read.csv(paste0(wd, "/data.out/hum.csv"))
fiw <- read.csv(paste0(wd, "/data.out/fiw.csv"))
aut <- read.csv(paste0(wd, "/data.out/aut.csv"))

# Create a country-year rack covering the requisite years
rack <- pitfcodeit(countryyearrackit(1945,2013), "country")

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
write.csv(dat, file = paste0(wd,"/data.out/ewp.statrisk.data.raw.csv"), row.names = FALSE)

# Remove all objects except dat from the workspace
rm(list=setdiff(ls(), "dat"))

### Mass Killing Episodes (mkl)
# Onset of state-led mass killing in following year (***TARGET/DEP VAR FOR RISK ASSESSMENTS***)
ld1 <- function(x)c(x[2:(length(x))], NA) # Function for 1-year lead; gets 2nd thru last obs, appends NA at end
dat <- ddply(dat, ~country, transform, mkl.start.1 = ld1(mkl.start))

### Country age
dat$countryage <- dat$year - dat$yrborn
dat$countryage.ln <- log1p(dat$countryage)

### Post-Cold War indicator
dat$postcw <- ifelse(dat$year >= 1991, 1, 0)

### World Development Indicators (wdi)
dat$wdi.popsize.ln <- log(dat$wdi.popsize)  # Log of population size
dat$wdi.trade.ln <- log(dat$wdi.trade)  # Log of trade openness

### Polity IV (pol)
# Fearon & Laitin regime type (autocracy, anocracy, democracy)
dat$pol.cat.fl[dat$pol.polity >= -10 & dat$pol.polity < -5] <- 1  # Autocracy
dat$pol.cat.fl[dat$pol.polity >= -5 & dat$pol.polity <= 5] <- 2  # Anocracy
dat$pol.cat.fl[dat$pol.polity > 5] <- 3  # Democracy
dat$pol.cat.fl[dat$pol.polity == -66 | dat$pol.polity == -77 | dat$pol.polity == -88 ] <- 7  # Other
# PITF AJPS regime types
dat$pol.cat.pitf[dat$pol.polity==-66 | dat$pol.polity==-77 | dat$pol.polity==-88] <- "other"
dat$pol.cat.pitf[(dat$pol.exrec >= 1 & dat$pol.exrec <= 6) & (dat$pol.parcomp == 1 | dat$pol.parcomp == 2)] <- "A/F"
dat$pol.cat.pitf[(dat$pol.exrec >= 1 & dat$pol.exrec <= 6) & (dat$pol.parcomp == 0 | dat$pol.parcomp == 3 |
  dat$pol.parcomp == 4 | dat$pol.parcomp == 5)] <- "A/P"
dat$pol.cat.pitf[(dat$pol.exrec == 7 | dat$pol.exrec == 8) & (dat$pol.parcomp == 1 | dat$pol.parcomp == 2)] <- "A/P"
dat$pol.cat.pitf[dat$pol.parcomp == 3 & (dat$pol.exrec == 7 | dat$pol.exrec==8)] <- "D/fact"
dat$pol.cat.pitf[dat$pol.exrec == 8 & (dat$pol.parcomp == 0 | dat$pol.parcomp == 4 )] <- "D/P"
dat$pol.cat.pitf[dat$pol.exrec == 7 & (dat$pol.parcomp == 0 | dat$pol.parcomp == 4 | dat$pol.parcomp == 5)] <- "D/P"
dat$pol.cat.pitf[dat$pol.exrec == 8 & dat$pol.parcomp == 5] <- "D/F"
# Harff autocracy indicator
dat$pol.autoc <- ifelse(dat$pol.polity <= 0 & dat$pol.polity >= -10, 1, ifelse(is.na(dat$pol.polity)==FALSE, 0, NA) )
# Dummied version of polcat for RF
dat$pol.cat.fl1 <- ifelse(dat$pol.cat.fl==1, 1, ifelse(is.na(dat$pol.cat.fl)==TRUE, NA, 0))
dat$pol.cat.fl2 <- ifelse(dat$pol.cat.fl==2, 1, ifelse(is.na(dat$pol.cat.fl)==TRUE, NA, 0))
dat$pol.cat.fl3 <- ifelse(dat$pol.cat.fl==3, 1, ifelse(is.na(dat$pol.cat.fl)==TRUE, NA, 0))
dat$pol.cat.fl7 <- ifelse(dat$pol.cat.fl==7, 1, ifelse(is.na(dat$pol.cat.fl)==TRUE, NA, 0))
# Dummied version of PITF regime type for RF
dat$pol.cat.pitf1 <- ifelse(dat$pol.cat.pitf=="A/F", 1, ifelse(is.na(dat$pol.cat.pitf)==TRUE, NA, 0) )
dat$pol.cat.pitf2 <- ifelse(dat$pol.cat.pitf=="A/P", 1, ifelse(is.na(dat$pol.cat.pitf)==TRUE, NA, 0) )
dat$pol.cat.pitf3 <- ifelse(dat$pol.cat.pitf=="D/fact", 1, ifelse(is.na(dat$pol.cat.pitf)==TRUE, NA, 0) )
dat$pol.cat.pitf4 <- ifelse(dat$pol.cat.pitf=="D/P", 1, ifelse(is.na(dat$pol.cat.pitf)==TRUE, NA, 0) )
dat$pol.cat.pitf5 <- ifelse(dat$pol.cat.pitf=="D/F", 1, ifelse(is.na(dat$pol.cat.pitf)==TRUE, NA, 0) )
dat$pol.cat.pitf6 <- ifelse(dat$pol.cat.pitf=="other", 1, ifelse(is.na(dat$pol.cat.pitf)==TRUE, NA, 0) )
# Regime stability, logged
dat$pol.durable.ln <- log1p(dat$pol.durable)

### Elite Characteristics (elc)
# Indicator for politically salient elite ethnicity: either, minority, majority
dat$elc.elethc <- ifelse(dat$elc.eleth==1 | dat$elc.eleth==2, 1, ifelse(is.na(dat$elc.eleth)==FALSE, 0, NA) )
dat$elc.eleth2 <- ifelse(dat$elc.eleth==2, 1, ifelse(is.na(dat$elc.eleth)==FALSE, 0, NA) )
dat$elc.eleth1 <- ifelse(dat$elc.eleth==1, 1, ifelse(is.na(dat$elc.eleth)==FALSE, 0, NA) )

### Coups (cou), a combination of Powell & Thyne (cpt) and Marshall (cmm)
dat$cou.s.d <- ifelse(is.na(dat$cpt.succ)==TRUE, ifelse(dat$cmm.succ > 0, 1, 0),
    ifelse(is.na(dat$cmm.succ)==TRUE, ifelse(dat$cpt.succ > 0, 1, 0),
      ifelse(dat$cmm.succ > 0 | dat$cpt.succ > 0, 1, 0) ) )
dat$cou.f.d <- ifelse(is.na(dat$cpt.fail)==TRUE, ifelse(dat$cmm.fail > 0, 1, 0),
    ifelse(is.na(dat$cmm.fail)==TRUE, ifelse(dat$cpt.fail > 0, 1, 0),
      ifelse(dat$cmm.fail > 0 | dat$cpt.fail > 0, 1, 0) ) )
dat$cou.a.d <- ifelse(dat$cou.f.d==1 | dat$cou.s.d==1, 1, ifelse(is.na(dat$cou.s.d)==TRUE, NA, 0) )

# Create indicator for any attempts in previous five years (depends on package 'plm')
dat <- dat[order(dat$country,dat$year),]
lags <- pdata.frame(dat, index = c("country", "year"))
lags$cou.s.d.1 <- lag(lags$cou.s.d, 1)
lags$cou.s.d.2 <- lag(lags$cou.s.d, 2)
lags$cou.s.d.3 <- lag(lags$cou.s.d, 3)
lags$cou.s.d.4 <- lag(lags$cou.s.d, 4)
lags$cou.f.d.1 <- lag(lags$cou.f.d, 1)
lags$cou.f.d.2 <- lag(lags$cou.f.d, 2)
lags$cou.f.d.3 <- lag(lags$cou.f.d, 3)
lags$cou.f.d.4 <- lag(lags$cou.f.d, 4)
meld <- as.data.frame(lags)
meld$year <- as.numeric(as.character(meld$year))
# Workaround for list to df
temp <- tempfile()
write.csv(meld, temp, row.names = FALSE)
dat <- read.csv(temp)
dat$cou.tries5d <-
  ifelse(is.na(dat$cou.s.d.1)==TRUE, ifelse(dat$cou.s.d>0 | dat$cou.f.d>0, 1, 0),
    ifelse(is.na(dat$cou.s.d.2)==TRUE, ifelse(dat$cou.s.d>0 | dat$cou.f.d>0 | dat$cou.s.d.1>0 | dat$cou.f.d.1>0, 1, 0),
      ifelse(is.na(dat$cou.s.d.3)==TRUE, ifelse(dat$cou.s.d>0 | dat$cou.f.d>0 | dat$cou.s.d.1>0 | dat$cou.f.d.1>0 | dat$cou.s.d.2>0 | dat$cou.f.d.2>0, 1, 0),  
        ifelse(is.na(dat$cou.s.d.4)==TRUE, ifelse(dat$cou.s.d>0 | dat$cou.s.d.1>0 | dat$cou.s.d.2>0 | dat$cou.s.d.3>0 | dat$cou.f.d>0 | dat$cou.f.d.1>0 | dat$cou.f.d.2>0 | dat$cou.f.d.3>0, 1, 0),
          ifelse(dat$cou.s.d>0 | dat$cou.s.d.1>0 | dat$cou.s.d.2>0 | dat$cou.s.d.3>0 | dat$cou.s.d.4>0 | dat$cou.f.d>0 | dat$cou.f.d.1>0 | dat$cou.f.d.2>0 | dat$cou.f.d.3>0 | dat$cou.f.d.4>0, 1, 0)))))
dat$cou.tries5d[dat$year < 1950] <- NA
dat$cou.s.d.1 <- dat$cou.s.d.2 <- dat$cou.s.d.3 <- dat$cou.s.d.4 <- NULL 
dat$cou.f.d.1 <- dat$cou.f.d.2 <- dat$cou.f.d.3 <- dat$cou.f.d.4 <- NULL
# Any coup attempts in the next year (### TARGET/DEP VAR FOR COUP RISK MODEL ###)
dat <- slide(dat[order(dat$country, dat$year),], "cou.a.d", GroupVar = "country", NewVar = "cou.a.d.1", slideBy = 1)

### Ethnic fractionalization (elf)
# Create categorical variable used in modeling
dat$elf.ethnicc[dat$elf.ethnic < quantile(dat$elf.ethnic, 1/3, na.rm=TRUE)] <- 1
dat$elf.ethnicc[dat$elf.ethnic >= quantile(dat$elf.ethnic, 1/3, na.rm=TRUE) & dat$elf.ethnic <= quantile(dat$elf.ethnic, 2/3, na.rm=TRUE)] <- 2
dat$elf.ethnicc[dat$elf.ethnic > quantile(dat$elf.ethnic, 2/3, na.rm=TRUE)] <- 3
dat$elf.ethnicc[is.na(dat$elf.ethnic)==TRUE] <- 9
# Dummied version of categorical variable
dat$elf.ethnicc1 <- ifelse(dat$elf.ethnicc==1, 1, ifelse(is.na(dat$elf.ethnicc)==TRUE, NA, 0) )
dat$elf.ethnicc2 <- ifelse(dat$elf.ethnicc==2, 1, ifelse(is.na(dat$elf.ethnicc)==TRUE, NA, 0) )
dat$elf.ethnicc3 <- ifelse(dat$elf.ethnicc==3, 1, ifelse(is.na(dat$elf.ethnicc)==TRUE, NA, 0) )
dat$elf.ethnicc9 <- ifelse(dat$elf.ethnicc==9, 1, ifelse(is.na(dat$elf.ethnicc)==TRUE, NA, 0) )

### PITF Problem Set (pit)
# Onset of any kind of instability episode
dat$pit.any.onset <- ifelse(dat$pit.reg.onset==1 | dat$pit.eth.onset==1 | dat$pit.rev.onset==1, 1, 0)
# Onset of any PITF instability episodes in following year
dat <- slide(dat[order(dat$country, dat$year),], "pit.any.onset", GroupVar = "country", NewVar = "pit.any.onset.1", slideBy = 1)
# Any ongoing political instability
dat$pit.any.ongoing <- ifelse(dat$pit.reg.ongoing==1 | dat$pit.eth.ongoing==1 | dat$pit.rev.ongoing==1, 1, 0)
# Civil-war onset for civil-war risk model
dat$pit.cwar.onset <- ifelse(dat$pit.rev.onset==1 | dat$pit.eth.onset==1, 1, ifelse(is.na(dat$pit.rev.onset)==TRUE, NA, 0) )
# Any civil-war onset in following year
dat <- slide(dat[order(dat$country, dat$year),], "pit.cwar.onset", GroupVar = "country", NewVar = "pit.cwar.onset.1", slideBy = 1)
# Minimum duration
for (i in 1:dim(dat)[1]) dat$pit.dur.min[i] <-
  ifelse(dat$pit.reg.dur[i] > 0 & dat$pit.eth.dur[i] > 0 & dat$pit.rev.dur[i] > 0, min(dat$pit.reg.dur[i], dat$pit.eth.dur[i], dat$pit.rev.dur[i]),
    ifelse(dat$pit.reg.dur[i] > 0 & dat$pit.eth.dur[i] > 0 & dat$pit.rev.dur[i] == 0, min(dat$pit.reg.dur[i], dat$pit.eth.dur[i]),
      ifelse(dat$pit.reg.dur[i] > 0 & dat$pit.eth.dur[i] == 0 & dat$pit.rev.dur[i] > 0, min(dat$pit.reg.dur[i], dat$pit.rev.dur[i]),
        ifelse(dat$pit.reg.dur[i] == 0 & dat$pit.eth.dur[i] > 0 & dat$pit.rev.dur[i] > 0, min(dat$pit.eth.dur[i], dat$pit.rev.dur[i]),
          ifelse(dat$pit.reg.dur[i] > 0, dat$pit.reg.dur[i],
            ifelse(dat$pit.eth.dur[i] > 0, dat$pit.eth.dur[i],
              ifelse(dat$pit.rev.dur[i] > 0, dat$pit.rev.dur[i], 0  )))))))
for (i in 1:dim(dat)[1]) dat$pit.dur.max[i] <- max(dat$pit.reg.dur[i], dat$pit.eth.dur[i], dat$pit.rev.dur[i])
# Upheaval scores for PITF/Harff geno-politicide model
# (a) Identify maximum annual magnitude score for each type of instability
for (i in 1:dim(dat)[1]) dat$pit.reg.max[i] <- max(dat$pit.reg.magfail[i], dat$pit.reg.magcol[i], dat$pit.reg.magviol[i])
for (i in 1:dim(dat)[1]) dat$pit.eth.max[i] <- max(dat$pit.eth.magfight[i], dat$pit.eth.magfatal[i], dat$pit.eth.magarea[i])
for (i in 1:dim(dat)[1]) dat$pit.rev.max[i] <- max(dat$pit.rev.magfight[i], dat$pit.rev.magfatal[i], dat$pit.rev.magarea[i])
# (b) Identify overall maximum annual magnitude score w/o genocides (SFTPUHVL2 in PITF)
for (i in 1:dim(dat)[1]) dat$pit.mag.max[i] <- max(dat$pit.reg.max[i], dat$pit.eth.max[i], dat$pit.rev.max[i])
# (c) Sum those annual maxima across 10 years w/o genocides. Note: B/c target will be led 1 yr, this window spans
#     current year (t) to 9 years earlier (t-9), not 10.
dat <- dat[order(dat$country,dat$year),]
lags <- pdata.frame(dat, index = c("country", "year"))
lags$pit.mag.max.1 <- lag(lags$pit.mag.max, 1)
lags$pit.mag.max.2 <- lag(lags$pit.mag.max, 2)
lags$pit.mag.max.3 <- lag(lags$pit.mag.max, 3)
lags$pit.mag.max.4 <- lag(lags$pit.mag.max, 4)
lags$pit.mag.max.5 <- lag(lags$pit.mag.max, 5)
lags$pit.mag.max.6 <- lag(lags$pit.mag.max, 6)
lags$pit.mag.max.7 <- lag(lags$pit.mag.max, 7)
lags$pit.mag.max.8 <- lag(lags$pit.mag.max, 8)
lags$pit.mag.max.9 <- lag(lags$pit.mag.max, 9)
meld <- as.data.frame(lags)
meld$year <- as.numeric(as.character(meld$year))
# Workaround for list to df
temp <- tempfile()
write.csv(meld, temp, row.names = FALSE)
dat <- read.csv(temp)
#       ii. Sum those values by row and replace values before 1964 with NAs because PITF data start in 1955
for (i in 1:dim(dat)[1]) dat$pit.sftpuhvl2.10[i] <- sum(dat$pit.mag.max[i], dat$pit.mag.max.1[i], dat$pit.mag.max.2[i],
  dat$pit.mag.max.3[i], dat$pit.mag.max.4[i], dat$pit.mag.max.5[i], dat$pit.mag.max.6[i], dat$pit.mag.max.7[i],
  dat$pit.mag.max.8[i], dat$pit.mag.max.9[i], na.rm = TRUE)
dat$pit.sftpuhvl2.10 <- replace(dat$pit.sftpuhvl2.10, which(dat$year < 1964 & dat$yrborn < 1955), NA)
#       iii. Remove the annual slices from the data frame.
dat <- VarDrop(dat, c(c(paste0("pit.mag.max.", seq(1,9,1)))))
#       iv. Log the result, too.
dat$pit.sftpuhvl2.10.ln <- log1p(dat$pit.sftpuhvl2.10)
# Logged duration measures
dat$pit.reg.dur.ln <- log1p(dat$pit.reg.dur)
dat$pit.eth.dur.ln <- log1p(dat$pit.eth.dur)
dat$pit.rev.dur.ln <- log1p(dat$pit.rev.dur)
dat$pit.dur.min.ln <- log1p(dat$pit.dur.min)

### Discrimination (dis)
# Sum of pop shares of groups subjected to level 4 (state-led) discrimination
# a) ID groups subject to level-4 discrimination and capture their pop shares as vars.
dat$dis.d4p1 <- ifelse(dat$dis.pdis1==4 | dat$dis.edis1==4, dat$dis.gprop1, 0)
dat$dis.d4p2 <- ifelse(dat$dis.pdis2==4 | dat$dis.edis2==4, dat$dis.gprop2, 0)
dat$dis.d4p3 <- ifelse(dat$dis.pdis3==4 | dat$dis.edis3==4, dat$dis.gprop3, 0)
dat$dis.d4p4 <- ifelse(dat$dis.pdis4==4 | dat$dis.edis4==4, dat$dis.gprop4, 0)
dat$dis.d4p5 <- ifelse(dat$dis.pdis5==4 | dat$dis.edis5==4, dat$dis.gprop5, 0)
dat$dis.d4p6 <- ifelse(dat$dis.pdis6==4 | dat$dis.edis6==4, dat$dis.gprop6, 0)
dat$dis.d4p7 <- ifelse(dat$dis.pdis7==4 | dat$dis.edis7==4, dat$dis.gprop7, 0)
dat$dis.d4p8 <- ifelse(dat$dis.pdis8==4 | dat$dis.edis8==4, dat$dis.gprop8, 0)
dat$dis.d4p9 <- ifelse(dat$dis.pdis9==4 | dat$dis.edis9==4, dat$dis.gprop9, 0)
dat$dis.d4p10 <- ifelse(dat$dis.pdis10==4 | dat$dis.edis10==4, dat$dis.gprop10, 0)
# b) Sum across those variables by row.
dat$dis.l4pop <- rowSums(subset(dat, select = c(c(paste0("dis.d4p", seq(1,10,1))))), na.rm = TRUE)
# c) Remove the group-level components from the data frame.
dat <- VarDrop(dat, c(c(paste0("dis.d4p", seq(1,10,1)))))
# d) Get the natural log of that sum.
dat$dis.l4pop.ln <- log1p(100 * dat$dis.l4pop)

### Infant Mortality (imr)
# Log of rate relative to annual global median
dat$imr.normed.ln <- log(dat$imr.normed)

### Major Episodes of Political Violence (mev)
# Index of armed conflict in proximate geographic region
# a) Get annual sums by region as defined by MEPV and 
regyrsum <- as.data.frame( cbind( seq(min(dat$year), max(dat$year), 1),
  tapply(dat$mev.actotal, list(dat$year, dat$mev.region), sum, na.rm=TRUE) ) )
mevregs <- c("year", "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7", "r8", "r9",           # regions
             "r12", "r14", "r23", "r25", "r41", "r50", "r53", "r56", "r67", "r89", "r90",  # straddle states
             "r99")                                                                        # isolated states
names(regyrsum) <- mevregs                                                                      
dat <- merge(dat, regyrsum, all.x = TRUE)
dat <- dat[order(dat$country, dat$year),]
# Create sum of armed conflict intensity for other countries in same subregion
dat$mev.regac <- NA
for (i in 1:dim(dat)[1]) dat$mev.regac[i] <- ifelse(dat$mev.region[i]==0,
  sum(dat$r0[i], dat$r50[i], dat$r90[i], na.rm=TRUE) - dat$mev.actotal[i], dat$mev.regac[i] )
for (i in 1:dim(dat)[1]) dat$mev.regac[i] <- ifelse(dat$mev.region[i]==1,
  sum(dat$r1[i], dat$r12[i], dat$r14[i], dat$r41[i], na.rm=TRUE) - dat$mev.actotal[i], dat$mev.regac[i] )
for (i in 1:dim(dat)[1]) dat$mev.regac[i] <- ifelse(dat$mev.region[i]==2,
  sum(dat$r2[i], dat$r12[i], dat$r23[i], dat$r25[i], dat$r53[i], na.rm=TRUE) - dat$mev.actotal[i], dat$mev.regac[i] )
for (i in 1:dim(dat)[1]) dat$mev.regac[i] <- ifelse(dat$mev.region[i]==3,
  sum(dat$r3[i], dat$r23[i], dat$r41[i], dat$r53[i], na.rm=TRUE) - dat$mev.actotal[i], dat$mev.regac[i] )
for (i in 1:dim(dat)[1]) dat$mev.regac[i] <- ifelse(dat$mev.region[i]==4,
  sum(dat$r4[i], dat$r14[i], dat$r41[i], na.rm=TRUE) - dat$mev.actotal[i], dat$mev.regac[i] )
for (i in 1:dim(dat)[1]) dat$mev.regac[i] <- ifelse(dat$mev.region[i]==5,
  sum(dat$r5[i], dat$r25[i], dat$r50[i], dat$r53[i], dat$r56[i], na.rm=TRUE) - dat$mev.actotal[i], dat$mev.regac[i] )
for (i in 1:dim(dat)[1]) dat$mev.regac[i] <- ifelse(dat$mev.region[i]==6,
  sum(dat$r6[i], dat$r56[i], dat$r67[i], na.rm=TRUE) - dat$mev.actotal[i], dat$mev.regac[i] )
for (i in 1:dim(dat)[1]) dat$mev.regac[i] <- ifelse(dat$mev.region[i]==7,
  sum(dat$r7[i], dat$r67[i], na.rm=TRUE) - dat$mev.actotal[i], dat$mev.regac[i] )
for (i in 1:dim(dat)[1]) dat$mev.regac[i] <- ifelse(dat$mev.region[i]==8,
  sum(dat$r8[i], dat$r89[i], na.rm=TRUE) - dat$mev.actotal[i], dat$mev.regac[i] )
for (i in 1:dim(dat)[1]) dat$mev.regac[i] <- ifelse(dat$mev.region[i]==9,
  sum(dat$r9[i], dat$r89[i], dat$r90[i], na.rm=TRUE) - dat$mev.actotal[i], dat$mev.regac[i] )
for (i in 1:dim(dat)[1]) dat$mev.regac[i] <- ifelse(dat$mev.region[i]==12,
  sum(dat$r1[i], dat$r2[i], na.rm=TRUE), dat$mev.regac[i] )
for (i in 1:dim(dat)[1]) dat$mev.regac[i] <- ifelse(dat$mev.region[i]==14,
  sum(dat$r1[i], dat$r4[i], na.rm=TRUE), dat$mev.regac[i] )
for (i in 1:dim(dat)[1]) dat$mev.regac[i] <- ifelse(dat$mev.region[i]==23,
  sum(dat$r2[i], dat$r3[i], na.rm=TRUE), dat$mev.regac[i] )
for (i in 1:dim(dat)[1]) dat$mev.regac[i] <- ifelse(dat$mev.region[i]==25,
  sum(dat$r2[i], dat$r5[i], na.rm=TRUE), dat$mev.regac[i] )
for (i in 1:dim(dat)[1]) dat$mev.regac[i] <- ifelse(dat$mev.region[i]==41,  # DRC only
  sum(dat$r1[i], dat$r3[i], dat$r4[i], na.rm=TRUE), dat$mev.regac[i] )  
for (i in 1:dim(dat)[1]) dat$mev.regac[i] <- ifelse(dat$mev.region[i]==50,
  sum(dat$r5[i], dat$r0[i], na.rm=TRUE), dat$mev.regac[i] )
for (i in 1:dim(dat)[1]) dat$mev.regac[i] <- ifelse(dat$mev.region[i]==53,  # Sudan only
  sum(dat$r2[i], dat$r3[i], dat$r5[i], na.rm=TRUE), dat$mev.regac[i] )
for (i in 1:dim(dat)[1]) dat$mev.regac[i] <- ifelse(dat$mev.region[i]==56,
  sum(dat$r5[i], dat$r6[i], na.rm=TRUE), dat$mev.regac[i] )
for (i in 1:dim(dat)[1]) dat$mev.regac[i] <- ifelse(dat$mev.region[i]==67,
  sum(dat$r6[i], dat$r7[i], na.rm=TRUE), dat$mev.regac[i] )
for (i in 1:dim(dat)[1]) dat$mev.regac[i] <- ifelse(dat$mev.region[i]==89,
  sum(dat$r8[i], dat$r9[i], na.rm=TRUE), dat$mev.regac[i] )
for (i in 1:dim(dat)[1]) dat$mev.regac[i] <- ifelse(dat$mev.region[i]==90,
  sum(dat$r9[i], dat$r0[i], na.rm=TRUE), dat$mev.regac[i] )
dat$mev.regac[dat$mev.region==99] <- 0
# c) Delete those regional sums from the data frame.
dat <- VarDrop(dat, c(mevregs[2:length(mevregs)]))
# Logged version of regional conflict measure
dat$mev.regac.ln <- log1p(dat$mev.regac)
# Create a binary indicator for any civil conflict
dat$mev.civtotc <- ifelse(dat$mev.civtot > 0 & is.na(dat$mev.civtot)==FALSE, 1, ifelse(dat$mev.civtot==0, 0, NA) )
# Create log of civil conflict score
dat$mev.civtot.ln <- log1p(dat$mev.civtot)

### IMF Economic Stats (imf)
# Annual percent change in GDP per capita per IMF
dat <- PercChange(dat[order(dat$country, dat$year),], Var = "imf.gdppc", GroupVar = "country",
  NewVar = "imf.gdppcgrow", slideBy = -1, type = "percent")
# Create meld of IMF and World Bank growth measures
dat$gdppcgrow <- NA
dat$gdppcgrow <- replace(dat$gdppcgrow, which(is.na(dat$imf.gdppcgrow)==FALSE),
  dat$imf.gdppcgrow[is.na(dat$imf.gdppcgrow)==FALSE] )
dat$gdppcgrow <- replace(dat$gdppcgrow, which(is.na(dat$imf.gdppcgrow)==TRUE & is.na(dat$wdi.gdppcgrow)==FALSE),
  dat$wdi.gdppcgrow[is.na(dat$imf.gdppcgrow)==TRUE & is.na(dat$wdi.gdppcgrow)==FALSE] )
# Square root of blended series
dat$gdppcgrow.sr <- ifelse( dat$gdppcgrow <= 0, -1 * sqrt(abs(dat$gdppcgrow)), sqrt(dat$gdppcgrow) )
# Create slow growth dummy using WDI first, IMF if that's not available
dat$slowgrowth <- ifelse(dat$gdppcgrow < 2, 1, ifelse(is.na(dat$gdppcgrow)==FALSE, 0, NA) )
dat$slowgrowth[is.na(dat$wdi.gdppcgrow)==FALSE] <- ifelse(dat$wdi.gdppcgrow[is.na(dat$wdi.gdppcgrow)==FALSE] < 2, 1, 0)
dat$slowgrowth[is.na(dat$wdi.gdppcgrow)==TRUE & is.na(dat$imf.gdppcgrow)==FALSE] <-
  ifelse(dat$imf.gdppcgrow[is.na(dat$wdi.gdppcgrow)==TRUE & is.na(dat$imf.gdppcgrow)==FALSE] < 2, 1, 0)

############################################
# Output Results
############################################

# Put index variables at the front
dat <- MoveFront(dat, Var = c("country", "sftgcode", "year"))

# Write .csv
write.csv(dat, file = paste0(wd, "/data.out/ewp.statrisk.data.transformed.csv"), row.names = FALSE)

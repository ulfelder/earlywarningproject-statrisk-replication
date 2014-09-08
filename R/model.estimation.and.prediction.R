# CPG STATISTICAL RISK ASSESSMENT MODEL ESTIMATION AND APPLICATION
# Jay Ulfelder
# 2014-09-02

# Clear workspace
rm(list=ls(all=TRUE))

# Load all required packages
library(randomForest)

# Set working directory
setwd("c:/users/jay/documents/ushmm/statrisk.replication/data.out/")

# Load the merged data
merge <- read.csv("ewp.statrisk.data.csv")

# Get model formulae
source("c:/users/jay/documents/ushmm/statrisk.replication/r/models.r")

####################################
# Model Estimation
####################################

# Remove most recent two years to avoid treating in-sample estimates as forecasts in cases with missing recent data
subdat <- subset(merge, year < as.numeric(substr(as.Date(Sys.Date()),1,4)) - 2)

coup <- glm(f.coup, family = binomial, data = subdat, na.action = na.exclude)
merge$coup.p <- predict(coup, newdata = merge, type = "response")
subdat$coup.p <- predict(coup, newdata = subdat, type = "response")

cwar <- glm(f.cwar, family = binomial, data = subdat, na.action = na.exclude)
merge$cwar.p <- predict(cwar, newdata = merge, type = "response")
subdat$cwar.p <- predict(cwar, newdata = subdat, type = "response")

threat <- glm(f.threat, family = binomial, data = subdat, na.action = na.exclude)
merge$threat.p <- predict(threat, newdata = merge, type = "response")

pitf <- glm(f.pitf, family = binomial, data = subset(subdat, pitf.any.ongoing==0), na.action = na.exclude)
merge$pitf.p <- predict(pitf, newdata = merge, type = "response")
subdat$pitf.p <- predict(pitf, newdata = subdat, type = "response")

harff <- glm(f.harff, family = binomial, data = subdat, na.action = na.exclude)
merge$harff.p <- predict(harff, newdata = merge, type = "response")

rf <- randomForest(f.rf, data = subdat, na.action = na.exclude, ntree = 1000,
  mtry = 3, cutoff = c(0.2,0.8)) # Params selected thru gridded search in validation stage
merge$rf.p <- predict(rf, type = "prob", newdata = merge, na.action = na.exclude)[,2]

###############################################
# Predictions Using Last Valid Observations
###############################################

id <- c("country", "sftgcode", "iso3code", "year")
dv <- c("mkl.start", "mkl.ongoing")
modvars <- c("ageln",
             "postcw",
             "reg.afr", "reg.eap", "reg.eur", "reg.mna", "reg.sca", "reg.amr",
             "wdi.popsizeln",
             "wdi.tradeln",
             "xxxcimrln",
             "polcat1", "polcat2", "polcat3", "polcat7",
             "pitfcat1", "pitfcat2", "pitfcat3", "pitfcat4", "pitfcat5", "pitfcat6",     
             "durableln",
             "autocracy",
             "efcat1", "efcat2", "efcat3", "efcat9",
             "ever",
             "ongoing",
             "cou.tries5d", 
             "regacln",
             "civconln",
             "io.iccpr1",
             "mix.gdppcgrowsr",
             "dispota4ln",
             "elceliti",
             "elcelethc",
             "elceleth1",
             "elceleth2",
             "sftpuhvl2.10ln")

varlist <- c(id, dv, modvars)

pull <- function(i) {
  d <- subset(merge, sftgcode==i, select = varlist)
  snip <- function(x) { rev( na.omit(x) )[1] }
  xi <- lapply(d, snip)
  xi <- as.data.frame(xi)
  return(xi)
}

# Do each so you can inspect for missing
AFG <- pull("AFG")
ALB <- pull("ALB")
ALG <- pull("ALG")
ANG <- pull("ANG")
ARG <- pull("ARG")
ARM <- pull("ARM")
AUL <- pull("AUL")
AUS <- pull("AUS")
AZE <- pull("AZE")
BAH <- pull("BAH")
BNG <- pull("BNG")
BLR <- pull("BLR")
BEL <- pull("BEL")
BEN <- pull("BEN")
BHU <- pull("BHU")
BOL <- pull("BOL")
BOS <- pull("BOS")
BOT <- pull("BOT")
BRA <- pull("BRA")
BFO <- pull("BFO")
BUL <- pull("BUL")
BUI <- pull("BUI")
CAM <- pull("CAM")
CAO <- pull("CAO")
CAN <- pull("CAN")
CEN <- pull("CEN")
CHA <- pull("CHA")
CHL <- pull("CHL")
CHN <- pull("CHN")
COL <- pull("COL")
COM <- pull("COM")
CON <- pull("CON")
ZAI <- pull("ZAI")
COS <- pull("COS")
CRO <- pull("CRO")
CUB <- pull("CUB")
CYP <- pull("CYP")
CZR <- pull("CZR")
DEN <- pull("DEN")
DJI <- pull("DJI")
DOM <- pull("DOM")
ECU <- pull("ECU")
EGY <- pull("EGY")
SAL <- pull("SAL")
EQG <- pull("EQG")
ERI <- pull("ERI")
EST <- pull("EST")
ETI <- pull("ETI")
FJI <- pull("FJI")
FIN <- pull("FIN")
FRN <- pull("FRN")
GAB <- pull("GAB")
GAM <- pull("GAM")
GRG <- pull("GRG")
GER <- pull("GER")
GHA <- pull("GHA")
GRC <- pull("GRC")
GUA <- pull("GUA")
GUI <- pull("GUI")
GNB <- pull("GNB")
GUY <- pull("GUY")
HAI <- pull("HAI")
HON <- pull("HON")
HUN <- pull("HUN")
IND <- pull("IND")
INS <- pull("INS")
IRN <- pull("IRN")
IRQ <- pull("IRQ")
IRE <- pull("IRE")
ISR <- pull("ISR")
ITA <- pull("ITA")
IVO <- pull("IVO")
JAM <- pull("JAM")
JPN <- pull("JPN")
JOR <- pull("JOR")
KZK <- pull("KZK")
KEN <- pull("KEN")
KUW <- pull("KUW")
KYR <- pull("KYR")
LAO <- pull("LAO")
LAT <- pull("LAT")
LEB <- pull("LEB")
LES <- pull("LES")
LBR <- pull("LBR")
LIB <- pull("LIB")
LIT <- pull("LIT")
MAC <- pull("MAC")
MAG <- pull("MAG")
MAW <- pull("MAW")
MAL <- pull("MAL")
MLI <- pull("MLI")
MAA <- pull("MAA")
MAS <- pull("MAS")
MEX <- pull("MEX")
MLD <- pull("MLD")
MON <- pull("MON")
MNE <- pull("MNE")
MOR <- pull("MOR")
MZM <- pull("MZM")
MYA <- pull("MYA")
NAM <- pull("NAM")
NEP <- pull("NEP")
NTH <- pull("NTH")
NEW <- pull("NEW")
NIC <- pull("NIC")
NIR <- pull("NIR")
NIG <- pull("NIG")
PRK <- pull("PRK")
NOR <- pull("NOR")
OMA <- pull("OMA")
PAK <- pull("PAK")
PAN <- pull("PAN")
PNG <- pull("PNG")
PAR <- pull("PAR")
PER <- pull("PER")
PHI <- pull("PHI")
POL <- pull("POL")
POR <- pull("POR")
QAT <- pull("QAT")
RUM <- pull("RUM")
RUS <- pull("RUS")
RWA <- pull("RWA")
SAU <- pull("SAU")
SEN <- pull("SEN")
SRB <- pull("SRB")
SIE <- pull("SIE")
SIN <- pull("SIN")
SLO <- pull("SLO")
SLV <- pull("SLV")
SOL <- pull("SOL")
SOM <- pull("SOM")
SAF <- pull("SAF")
ROK <- pull("ROK")
SSD <- pull("SSD")
SPN <- pull("SPN")
SRI <- pull("SRI")
SUD <- pull("SUD")
SWA <- pull("SWA")
SWD <- pull("SWD")
SWZ <- pull("SWZ")
SYR <- pull("SYR")
TAJ <- pull("TAJ")
TAZ <- pull("TAZ")
THI <- pull("THI")
ETM <- pull("ETM")
TOG <- pull("TOG")
TRI <- pull("TRI")
TUN <- pull("TUN")
TUR <- pull("TUR")
TKM <- pull("TKM")
UGA <- pull("UGA")
UKR <- pull("UKR")
UAE <- pull("UAE")
UKG <- pull("UK ")
USA <- pull("USA")
URU <- pull("URU")
UZB <- pull("UZB")
VEN <- pull("VEN")
VIE <- pull("VIE")
YEM <- pull("YEM")
ZAM <- pull("ZAM")
ZIM <- pull("ZIM")

# Hard code trade openness for IRQ and PRK from CIA World Factbook
IRQ$wdi.tradeln <- log( 100 * ( (92.0 + 66.6) / 248.0 ))
PRK$wdi.tradeln <- log( 100 * ( (4.0 + 4.8) / 40.0 ))

# Hard code growth for PRK from CIA World Factbook
PRK$mix.gdppcgrowsr <- sqrt(abs(1.3))

latest <- rbind(AFG, ALB, ALG, ANG, ARG, ARM, AUL, AUS, AZE, BAH,
                BNG, BLR, BEL, BEN, BHU, BOL, BOS, BOT, BRA, BUL,
                BFO, BUI, CAM, CAO, CAN, CEN, CHA, CHL, CHN, COL,
                COM, CON, ZAI, COS, CRO, CUB, CYP, CZR, DEN, DJI,
                DOM, ECU, EGY, SAL, EQG, ERI, EST, ETI, FJI, FIN,
                FRN, GAB, GAM, GRG, GER, GHA, GRC, GUA, GUI, GNB,
                GUY, HAI, HON, HUN, IND, INS, IRN, IRQ, IRE, ISR,
                ITA, IVO, JAM, JPN, JOR, KZK, KEN, KUW, KYR, LAO,
                LAT, LEB, LES, LBR, LIB, LIT, MAC, MAG, MAW, MAL,
                MLI, MAA, MAS, MEX, MLD, MON, MNE, MOR, MZM, MYA,
                NAM, NEP, NTH, NEW, NIC, NIR, NIG, PRK, NOR, OMA,
                PAK, PAN, PNG, PAR, PER, PHI, POL, POR, QAT, RUM,
                RUS, RWA, SAU, SEN, SRB, SIE, SIN, SLO, SLV, SOL,
                SOM, SAF, ROK, SSD, SPN, SRI, SUD, SWA, SWD, SWZ,
                SYR, TAJ, TAZ, THI, ETM, TOG, TRI, TUN, TUR, TKM,
                UGA, UKR, UAE, UKG, USA, URU, UZB, VEN, VIE, YEM,
                ZAM, ZIM)

# Function to get predictions from data frame
forecast <- function(df) {
  df$coup.p <- predict(coup, newdata = df, type = "response", na.action = na.exclude)
  df$cwar.p <- predict(cwar, newdata = df, type = "response", na.action = na.exclude)
  df$pitf.p <- predict(pitf, newdata = df, type = "response", na.action = na.exclude)
  df$threat.p <- predict(threat, newdata = df, type = "response", na.action = na.exclude)
  df$harff.p <- predict(harff, newdata = df, type = "response", na.action = na.exclude)
  df$rf.p <- predict(rf, type = "prob", newdata = df, na.action = na.exclude)[,2]
  df$mean.p <- (df$harff.p + df$threat.p + df$rf.p)/3
  df$date <- as.Date(Sys.Date())
  return(df)
}

newcast <- forecast(latest)

write.csv(newcast, "ewp.forecasts.csv", row.names = FALSE)

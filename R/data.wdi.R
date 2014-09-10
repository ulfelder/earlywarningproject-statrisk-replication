# WORLD DEVELOPMENT INDICATORS
# 2014-09-03

# This script uses the 'WDI' package in R to download selected data from the
# latest version of the World Bank's World Development Indicators and formats 
# them for merging with other country-year data using PITF country codes as
# the case IDs. To modify the variables selected, you need to make changes to
# 'wdilist' and the commands that follow "Subset" and "Rename variables". 

# Clear workspace
rm(list=ls(all=TRUE))

# Get working directory
wd <- getwd()

# Load required packages and functions
library(WDI)
source(paste0(wd, "/r/f.countryyearrackit.r"))
source(paste0(wd, "/r/f.pitfcodeit.r"))

wdilist <- c("NE.TRD.GNFS.ZS",     # Trade (% of GDP)
             "NY.GDP.PCAP.PP.KD",  # GDP per capita, PPP (constant 2005 intl $)
             "NY.GDP.PCAP.KD",     # GDP per capita (constant 2000 US$)
             "NY.GDP.MKTP.KD.ZG",  # GDP growth (annual %)
             "FP.CPI.TOTL.ZG",     # Inflation, consumer prices (annual %)
             "FP.CPI.TOTL",        # Consumer price index (2005 = 100) 
             "NV.AGR.TOTL.ZS",     # Agriculture, value added (% of GDP)
             "NV.IND.MANF.ZS",     # Manufacturing, value added (% of GDP)
             "NV.IND.TOTL.ZS",     # Industry, value added (% of GDP)
             "NV.SRV.TETC.ZS",     # Services, etc., value added (% of GDP)
             "GC.TAX.TOTL.GD.ZS",  # Tax revenue (% of GDP)
             "GC.DOD.TOTL.GD.ZS",  # Central government debt, total (% of GDP)
             "SP.POP.TOTL",        # Population, total
             "SP.URB.TOTL.IN.ZS",  # Urban population (% of total)
             "SP.POP.GROW",        # Population growth (annual %)
             "EN.POP.DNST",        # Population density (people per sq. km of land area)
             "SP.POP.0014.TO.ZS",  # Population ages 0-14 (% of total)
             "MS.MIL.TOTL.P1",     # Armed forces personnel, total
             "MS.MIL.TOTL.TF.ZS",  # Armed forces personnel (% of total labor force)
             "NY.ADJ.DFOR.GN.ZS",  # Adjusted savings: forest depletion (% of GNI)
             "NY.ADJ.DMIN.GN.ZS",  # Adjusted savings: mineral depletion (% of GNI)
             "NY.ADJ.DNGY.GN.ZS",  # Adjusted savings: energy depletion (% of GNI)
             "IT.CEL.SETS.P2",     # Mobile cellular subscriptions (per 100 people)                                        
             "IT.NET.USER.P2",     # Internet users (per 100 people)                                              
             "SP.DYN.IMRT.IN" )    # Infant mortality rate

# Extract latest version of desired variables from WDI from 1960
wdi <- WDI(country="all", indicator = wdilist, extra = FALSE,
  start = 1960, end = as.numeric(substr(Sys.Date(),1,4)))

# Add PITF country codes for merging
wdi <- pitfcodeit(wdi, "country")

# Subset to drop cases with missing PITF codes, cut extra id vars
wdi <- subset(wdi, is.na(sftgcode)==FALSE, select = c(length(names(wdi)), 3:(length(names(wdi)) - 1)))

# Rename variables.
names(wdi) <- c("sftgcode", "year",
  "wdi.trade",
  "wdi.gdppcppp",
  "wdi.gdppc",
  "wdi.gdppcgrow",
  "wdi.inflation",
  "wdi.cpi",
  "wdi.agric",
  "wdi.manuf",
  "wdi.indus",
  "wdi.servc",
  "wdi.taxrev",
  "wdi.govdebt",
  "wdi.popsize",
  "wdi.popurb",
  "wdi.popgrow",
  "wdi.popdens",
  "wdi.pop014",
  "wdi.miltot",
  "wdi.milpct",
  "wdi.forest",
  "wdi.minerals", 
  "wdi.energy",
  "wdi.mobiles",
  "wdi.netusers",
  "wdi.imrate")

# Reorder for easier review
wdi <- wdi[order(wdi$sftgcode, wdi$year),]

# Write it out
write.csv(wdi, file = paste0(wd, "/data.out/wdi.csv"), row.names = FALSE)

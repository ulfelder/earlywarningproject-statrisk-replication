# IMF GDP PER CAPITA IN CONSTANT LOCAL CURRENCY
# Jay Ulfelder
# 2014-09-03

# Clear workspace
rm(list=ls(all=TRUE))

#set working directory
setwd(commandArgs(TRUE)[1])

# Get working directory
wd <- getwd()

# Load required packages and functions
library(reshape)
source(paste0(wd, "/R/f.pitfcodeit.R"))

# 2013 updates from IMF
# Source: http://www.imf.org/external/pubs/ft/weo/2014/01/weodata/index.aspx
# Download "By countries" > All countries > Continue > 
# [check] Gross domestic product per capita, constant prices (national currency) > 
# [start year -> 1980] [end year -> 2013] [uncheck] Append country/series-specific notes > Prepare report
weo2013 <- read.delim(paste0(wd, commandArgs(TRUE)[2]))
weo2013$g2013 <- as.numeric(gsub(",", "", as.character(weo2013$X2013)))
weo2013$g2012 <- as.numeric(gsub(",", "", as.character(weo2013$X2012)))
weo2013$g2011 <- as.numeric(gsub(",", "", as.character(weo2013$X2011)))
weo2013$g2010 <- as.numeric(gsub(",", "", as.character(weo2013$X2010)))
weo2013$g2009 <- as.numeric(gsub(",", "", as.character(weo2013$X2009)))
weo2013$g2008 <- as.numeric(gsub(",", "", as.character(weo2013$X2008)))
weo2013$g2007 <- as.numeric(gsub(",", "", as.character(weo2013$X2007)))
weo2013$g2006 <- as.numeric(gsub(",", "", as.character(weo2013$X2006)))
weo2013$g2005 <- as.numeric(gsub(",", "", as.character(weo2013$X2005)))
weo2013$g2004 <- as.numeric(gsub(",", "", as.character(weo2013$X2004)))
weo2013$g2003 <- as.numeric(gsub(",", "", as.character(weo2013$X2003)))
weo2013$g2002 <- as.numeric(gsub(",", "", as.character(weo2013$X2002)))
weo2013$g2001 <- as.numeric(gsub(",", "", as.character(weo2013$X2001)))
weo2013$g2000 <- as.numeric(gsub(",", "", as.character(weo2013$X2000)))
weo2013$g1999 <- as.numeric(gsub(",", "", as.character(weo2013$X1999)))
weo2013$g1998 <- as.numeric(gsub(",", "", as.character(weo2013$X1998)))
weo2013$g1997 <- as.numeric(gsub(",", "", as.character(weo2013$X1997)))
weo2013$g1996 <- as.numeric(gsub(",", "", as.character(weo2013$X1996)))
weo2013$g1995 <- as.numeric(gsub(",", "", as.character(weo2013$X1995)))
weo2013$g1994 <- as.numeric(gsub(",", "", as.character(weo2013$X1994)))
weo2013$g1993 <- as.numeric(gsub(",", "", as.character(weo2013$X1993)))
weo2013$g1992 <- as.numeric(gsub(",", "", as.character(weo2013$X1992)))
weo2013$g1991 <- as.numeric(gsub(",", "", as.character(weo2013$X1991)))
weo2013$g1990 <- as.numeric(gsub(",", "", as.character(weo2013$X1990)))
weo2013$g1989 <- as.numeric(gsub(",", "", as.character(weo2013$X1989)))
weo2013$g1988 <- as.numeric(gsub(",", "", as.character(weo2013$X1988)))
weo2013$g1987 <- as.numeric(gsub(",", "", as.character(weo2013$X1987)))
weo2013$g1986 <- as.numeric(gsub(",", "", as.character(weo2013$X1986)))
weo2013$g1985 <- as.numeric(gsub(",", "", as.character(weo2013$X1985)))
weo2013$g1984 <- as.numeric(gsub(",", "", as.character(weo2013$X1984)))
weo2013$g1983 <- as.numeric(gsub(",", "", as.character(weo2013$X1983)))
weo2013$g1982 <- as.numeric(gsub(",", "", as.character(weo2013$X1982)))
weo2013$g1981 <- as.numeric(gsub(",", "", as.character(weo2013$X1981)))
weo2013$g1980 <- as.numeric(gsub(",", "", as.character(weo2013$X1980)))
weo2013 <- subset(weo2013, select=c(1,40:73))
weomelt <- melt(weo2013)
names(weomelt) <- c("country", "gyear", "imf.gdppc")
weomelt$year <- as.numeric(substr(as.character(weomelt$gyear),2,5))
weomelt$gyear <- NULL
weomelt$country <- as.character(weomelt$country)
weomelt <- pitfcodeit(weomelt, "country")

# Pare it down and reorder
weomelt <- subset(weomelt, select=c(sftgcode, year, imf.gdppc))
weomelt <- weomelt[order(weomelt$sftgcode, weomelt$year),]

# Write it out
write.csv(weomelt, file = paste0(wd, commandArgs(TRUE)[3]), row.names = FALSE)

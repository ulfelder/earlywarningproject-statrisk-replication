# IMF GDP PER CAPITA IN CONSTANT LOCAL CURRENCY
# Jay Ulfelder
# 2015-04-14

# Clear workspace
rm(list=ls(all=TRUE))

# Get working directory
wd <- getwd()

# Load required packages and functions
library(reshape)
source(paste0(wd, "/r/f.pitfcodeit.r"))

# World Economic Outlook April 2015 data from IMF
# Source: http://www.imf.org/external/pubs/ft/weo/2015/01/weodata/index.aspx
# Download "By countries" > All countries > Continue > 
# [check] Gross domestic product per capita, constant prices (national currency) > 
# [start year -> 1980] [end year -> 2014] [uncheck] Append country/series-specific notes > Prepare report

weo2014v2 <- read.delim(paste0(wd, "/data.in/weoreptc.xlw"), stringsAsFactors = FALSE)

weo2014v2$g2014 <- as.numeric(gsub(",", "", as.character(weo2014v2$X2014)))
weo2014v2$g2013 <- as.numeric(gsub(",", "", as.character(weo2014v2$X2013)))
weo2014v2$g2012 <- as.numeric(gsub(",", "", as.character(weo2014v2$X2012)))
weo2014v2$g2011 <- as.numeric(gsub(",", "", as.character(weo2014v2$X2011)))
weo2014v2$g2010 <- as.numeric(gsub(",", "", as.character(weo2014v2$X2010)))
weo2014v2$g2009 <- as.numeric(gsub(",", "", as.character(weo2014v2$X2009)))
weo2014v2$g2008 <- as.numeric(gsub(",", "", as.character(weo2014v2$X2008)))
weo2014v2$g2007 <- as.numeric(gsub(",", "", as.character(weo2014v2$X2007)))
weo2014v2$g2006 <- as.numeric(gsub(",", "", as.character(weo2014v2$X2006)))
weo2014v2$g2005 <- as.numeric(gsub(",", "", as.character(weo2014v2$X2005)))
weo2014v2$g2004 <- as.numeric(gsub(",", "", as.character(weo2014v2$X2004)))
weo2014v2$g2003 <- as.numeric(gsub(",", "", as.character(weo2014v2$X2003)))
weo2014v2$g2002 <- as.numeric(gsub(",", "", as.character(weo2014v2$X2002)))
weo2014v2$g2001 <- as.numeric(gsub(",", "", as.character(weo2014v2$X2001)))
weo2014v2$g2000 <- as.numeric(gsub(",", "", as.character(weo2014v2$X2000)))
weo2014v2$g1999 <- as.numeric(gsub(",", "", as.character(weo2014v2$X1999)))
weo2014v2$g1998 <- as.numeric(gsub(",", "", as.character(weo2014v2$X1998)))
weo2014v2$g1997 <- as.numeric(gsub(",", "", as.character(weo2014v2$X1997)))
weo2014v2$g1996 <- as.numeric(gsub(",", "", as.character(weo2014v2$X1996)))
weo2014v2$g1995 <- as.numeric(gsub(",", "", as.character(weo2014v2$X1995)))
weo2014v2$g1994 <- as.numeric(gsub(",", "", as.character(weo2014v2$X1994)))
weo2014v2$g1993 <- as.numeric(gsub(",", "", as.character(weo2014v2$X1993)))
weo2014v2$g1992 <- as.numeric(gsub(",", "", as.character(weo2014v2$X1992)))
weo2014v2$g1991 <- as.numeric(gsub(",", "", as.character(weo2014v2$X1991)))
weo2014v2$g1990 <- as.numeric(gsub(",", "", as.character(weo2014v2$X1990)))
weo2014v2$g1989 <- as.numeric(gsub(",", "", as.character(weo2014v2$X1989)))
weo2014v2$g1988 <- as.numeric(gsub(",", "", as.character(weo2014v2$X1988)))
weo2014v2$g1987 <- as.numeric(gsub(",", "", as.character(weo2014v2$X1987)))
weo2014v2$g1986 <- as.numeric(gsub(",", "", as.character(weo2014v2$X1986)))
weo2014v2$g1985 <- as.numeric(gsub(",", "", as.character(weo2014v2$X1985)))
weo2014v2$g1984 <- as.numeric(gsub(",", "", as.character(weo2014v2$X1984)))
weo2014v2$g1983 <- as.numeric(gsub(",", "", as.character(weo2014v2$X1983)))
weo2014v2$g1982 <- as.numeric(gsub(",", "", as.character(weo2014v2$X1982)))
weo2014v2$g1981 <- as.numeric(gsub(",", "", as.character(weo2014v2$X1981)))
weo2014v2$g1980 <- as.numeric(gsub(",", "", as.character(weo2014v2$X1980)))
weo2014v2 <- subset(weo2014v2, select=c(1,41:75))
weomelt <- melt(weo2014v2)
names(weomelt) <- c("country", "gyear", "imf.gdppc")
weomelt$year <- as.numeric(substr(as.character(weomelt$gyear),2,5))
weomelt$gyear <- NULL
weomelt$country <- as.character(weomelt$country)
weomelt <- pitfcodeit(weomelt, "country")

# Pare it down and reorder
weomelt <- subset(weomelt, select=c(sftgcode, year, imf.gdppc))
weomelt <- weomelt[order(weomelt$sftgcode, weomelt$year),]

# Write it out
write.csv(weomelt, file = paste0(wd, "/data.out/imf.csv"), row.names = FALSE)

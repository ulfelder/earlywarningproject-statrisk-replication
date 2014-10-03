# FREEDOM HOUSE FREEDOM IN THE WORLD (fiw)
# 2014-09-03

# Source: http://www.freedomhouse.org/report-types/freedom-world#.VAdNqPk7u-M
# Click "Country ratings and status, FIW 1973-2014 (EXCEL)" to download

# Clear workspace
rm(list=ls(all=TRUE))

#set working directory
setwd(commandArgs(TRUE)[1])

# Get working directory
wd <- getwd()

# Load requisite packages and functions
require(xlsx)
require(reshape)
source(paste0(wd, "/r/f.pitfcodeit.r"))
source(paste0(wd, "/r/f.countryyearrackit.r"))

# Ingest and reshape data into desired country-year format
fiw <- read.xlsx2(paste0(wd, commandArgs(TRUE)[2]),
  sheetIndex = 1, startRow = 7, endRow = 212)
fhyrs <- c(1972:1980,1982:2013)
var_years <- expand.grid( x=c('PR', 'CL', 'Status'), y = fhyrs)
names(fiw) <- c('country', paste(var_years$x, var_years$y, sep = "_"))
fiw_m <- melt(fiw, id = 'country')
fiw_m <- cbind(fiw_m, colsplit(fiw_m$variable, "_", names = c('indicator', 'year')))
fiw_m$variable <- NULL
fiw.pr <- subset(fiw_m, indicator=="PR")
fiw.pr$indicator <- NULL
names(fiw.pr) <- c("country", "fiw.pr", "year")
fiw.cl <- subset(fiw_m, indicator=="CL")
fiw.cl$indicator <- NULL
names(fiw.cl) <- c("country", "fiw.cl", "year")
fiw.status <- subset(fiw_m, indicator=="Status")
fiw.status$indicator <- NULL
names(fiw.status) <- c("country", "fiw.status", "year")
fiw <- merge(fiw.pr, fiw.cl)
fiw <- merge(fiw, fiw.status)
fiw$country <- as.character(fiw$country)
fiw$fiw.pr <- as.numeric(as.character(fiw$fiw.pr))
fiw$fiw.cl <- as.numeric(as.character(fiw$fiw.cl))
fiw$fiw.status <- as.character(fiw$fiw.status)
fiw$fiw.status[fiw$fiw.status==".."] <- fiw$fiw.status[fiw$fiw.status=="F (NF)"] <- NA

# Add PITF country codes for merging and get rid of country names
fiw <- pitfcodeit(fiw, "country")
fiw$country <- NULL

# Delete missing values
fiw <- na.omit(fiw)

write.csv(fiw, file = paste0(wd, commandArgs(TRUE)[3]), row.names = FALSE)

# FREEDOM HOUSE FREEDOM IN THE WORLD (fiw)
# 2014-09-03

# Source: http://www.freedomhouse.org/report-types/freedom-world#.VAdNqPk7u-M
# Click "Country ratings and status, FIW 1973-2014 (EXCEL)" to download

# Clear workspace
rm(list=ls(all=TRUE))

# Load requisite packages and functions
require(xlsx)
require(reshape)
source("c:/users/jay/documents/ushmm/statrisk.replication/r/f.pitfcodeit.r")
source("c:/users/jay/documents/ushmm/statrisk.replication/r/f.countryyearrackit.r")

# Ingest and reshape data into desired country-year format
fiw <- read.xlsx2("c:/users/jay/documents/ushmm/statrisk.replication/data.in/Country Ratings and Status, 1973-2014 (FINAL).xls",
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

fiw <- pitfcodeit(fiw, "country")
fiw$country <- NULL

fiw <- na.omit(fiw)

write.csv(fiw, "c:/users/jay/documents/ushmm/statrisk.replication/data.out/fiw.csv", row.names = FALSE)
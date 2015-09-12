# EWP RISK ASSESSMENT AGGREGATION, SCORING, AND COMPARISON
# 2015-06-17

rm(list=ls(all=TRUE))

library(gplots)

setwd("c:/users/jay/documents/ushmm")

# Ingest, trim, and aggregate all available ex ante forecasts, then save that table as .csv
EWP.2015 <- read.csv("statrisk-2015-sandbox/data.out/ewp.forecasts.2015.csv", stringsAsFactors=FALSE)
EWP.2015 <- subset(EWP.2015, select=c(sftgcode, country, forecast.year, mean.p, rf.p, threat.p, harff.p))
EWP.2014 <- read.csv("earlywarningproject-statrisk-replication/data.out/ewp.forecasts.csv", stringsAsFactors=FALSE)
EWP.2014 <- subset(EWP.2014, select=c(sftgcode, country, forecast.year, mean.p, rf.p, threat.p, harff.p))
EWP.2013 <- read.csv("statrisk/outdata/cpg.stat.risk.2013.20130815.csv", stringsAsFactors=FALSE)
EWP.2013$forecast.year <- 2013
EWP.2013 <- subset(EWP.2013, select=c(sftgcode, country, forecast.year, mean.p, rf.p, threat.p, harff.p))
EWPHist <- data.frame(rbind(EWP.2015, EWP.2014, EWP.2013))
write.csv(EWPHist, "c:/users/jay/documents/ushmm/statrisk-2015-sandbox/data.out/ewp.exante.forecast.history.2015.csv",
     row.names=FALSE)

# Plot of changes in rank from 2014 to 2015
# See: http://stackoverflow.com/questions/25781284/simplest-way-to-plot-changes-in-ranking-between-two-ordered-lists-in-r
# NOTE: Function assumes that vectors are already in ascending order by predicted probability, so do that now.
EWP.2014 <- EWP.2014[order(EWP.2014$mean.p),]
EWP.2015 <- EWP.2015[order(EWP.2015$mean.p),]
# Function for plotting
plotRanks <- function(a, b, labels.offset=0.05, arrow.len=0.1)
  {
  old.par <- par(mar=c(1,1,1,1))

  # Find the length of the vectors
  len.1 <- length(a)
  len.2 <- length(b)

  # Plot two columns of equidistant points
  plot(rep(1, len.1), 1:len.1, pch=20, cex=0.8, 
       xlim=c(0, 3), ylim=c(0, max(len.1, len.2)),
       axes=FALSE, xlab="", ylab="") # Remove axes and labels
  points(rep(2, len.2), 1:len.2, pch=20, cex=0.8)

  # Put labels and rankings next to each observation
  text(rep(1-labels.offset, len.1), 1:len.1,
    paste(a, rev(seq(length(a))), sep=" "), cex = 0.5, pos = 2)
  text(rep(2+labels.offset, len.2), 1:len.2,
    paste(rev(seq(length(b))), b, sep=" "), cex = 0.5, pos = 4)

  # Now we need to map where the elements of a are in b
  # We use the match function for this job
  a.to.b <- match(a, b)

  # Make drawing of arrow conditional on size of diff, here 10
  rank <- seq(length(a)) 
  diff <- rank - a.to.b
  condcol <- ifelse(diff >= 10, "blue",
    ifelse(diff <= -10, "red", "gray90"))

  # Now we can draw arrows from the first column to the second
  arrows(rep(1.02, len.1), 1:len.1, rep(1.98, len.2), a.to.b, 
         length=arrow.len, angle=20, col = condcol)
  par(old.par)
  }

png("c:/users/jay/documents/ushmm/statrisk-2015-sandbox/figs/masskilling.stats.changerank.2015.png",
    width=15, height=50, unit="cm", bg="white", res=150)
plotRanks(EWP.2014$country, EWP.2015$country)
title(main=list("Change in Statistical Risk Assessment Rankings from 2014 to 2015", cex=0.9))
dev.off()

# Make ordered table of cases by change in rank with new rank shown
EWP.2014 <- EWP.2014[order(-EWP.2014$mean.p),]
EWP.2015 <- EWP.2015[order(-EWP.2015$mean.p),]
a.to.b <- match(EWP.2014$country, EWP.2015$country)
rank <- seq(1, length(EWP.2014$country))
diff <- rank - a.to.b
chg <- data.frame(EWP.2014$country, diff, stringsAsFactors = FALSE)
names(chg) <- c("country", "diff")
newrank <- data.frame(EWP.2015$country, row.names(EWP.2015), stringsAsFactors = FALSE)
names(newrank) <- c("country", "new.rank")
chg <- merge(chg, newrank)
chg$new.rank <- as.numeric(chg$new.rank)
chg <- chg[order(-chg$diff),]
row.names(chg) <- NULL

# Use 'textplot' from 'gplots' to print tables of top & bottom 20 to PNG files
png("c:/users/jay/documents/ushmm/statrisk-2015-sandbox/figs/changelist.top20.png",
     width=4, height=4, units='in', bg='white', res=150)
par(cex.main = 0.9)
textplot(chg[1:20,], show.rownames = FALSE, mar = c(1,1,3,1))
title(main = "20 Biggest Increases")
dev.off()
png("c:/users/jay/documents/ushmm/statrisk-2015-sandbox/figs/changelist.bottom20.png",
     width=4, height=4, units='in', bg='white', res=150)
par(cex.main = 0.9)
textplot(chg[(dim(chg)[1]-20):dim(chg)[1],], show.rownames = FALSE, mar = c(1,1,3,1))
title(main = "20 Biggest Declines")
dev.off()
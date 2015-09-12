# PLOTS AND MAPS OF FORECASTS
# 2015-05-15

# Clear the workspace
rm(list=ls(all=TRUE))

# Get working directory
wd <- getwd()

# Load required packages
library(rworldmap)
library(Hmisc)

# Get the data and fix any formatting of country name to character
newcast <- read.csv(paste0(wd, "/data.out/ewp.forecasts.csv"), stringsAsFactors=FALSE)

### MAPS ###

# Change a few country names to match ones used in rworldmap
newcast$country[newcast$country=="Timor Leste"] <- "Timor-Leste"
newcast$country[newcast$country=="Congo-Brazzaville"] <- "Congo"
newcast$country[newcast$country=="Congo-Kinshasa"] <- "Democratic Republic of Congo"

# Join data to map
map2015 <- joinCountryData2Map(newcast, nameJoinColumn = "country", joinCode = "NAME", verbose = TRUE)

# Map the scores
date <- as.Date(Sys.Date())
datestring <- paste(substr(date,1,4), substr(date,6,7), substr(date,9,10), sep="")
mapname <- paste0(wd, "/figs/heatmap.", datestring, ".png")
png(mapname, width=800, height=450, bg="white")
par(mai=c(0,0,0.2,0),xaxs="i",yaxs="i")
map.score <- mapCountryData(map2015,
  nameColumnToPlot="mean.p",
  addLegend = FALSE,
  numCats = 5, catMethod="logFixedWidth",
  colourPalette = "heat", borderCol = "gray",
  mapTitle = "Risk of Onset of State-Led Mass Killing Episode")
do.call(addMapLegend, c(map.score, legendWidth=0.5, legendMar = 2))
mtext("map made using rworldmap             ", line=-4, side=1, adj=1, cex=0.8)
dev.off()

# Map with color scaled to distance
date <- as.Date(Sys.Date())
datestring <- paste(substr(date,1,4), substr(date,6,7), substr(date,9,10), sep="")
mapname <- paste0(wd, "/figs/scaledmap.", datestring, ".png")
grayscale <- c("gray95", "gray91", "gray83", "gray67", "gray35")
cats <- c(0,0.01,0.02,0.04,0.08,0.16)
cols <- c("lightgoldenrod", "yellow", "orange", "orangered", "orangered4")
png(mapname, width=800, height=450, bg="white")
par(mai=c(0,0,0.2,0), xaxs="i", yaxs="i")
map.score <- mapCountryData(map2015,
  nameColumnToPlot="mean.p",
  addLegend = FALSE,
  catMethod = cats,
  colourPalette = cols,
  borderCol = "white",
  oceanCol = "lightblue",
  mapTitle = "")
legend(x = -170, y = -85, xjust = 0, yjust = 0,
  legend = c("< 1%", "1-2%", "2-4%", "4-8%", "8-16%"),
  fill = cols, border = cols, bty = "n")
text(x = 170, y = -80, "made using rworldmap", adj = 1, cex = 0.8)
dev.off()

# Dot plot of scores for top 30
newcast <- newcast[order(-newcast$mean.p),]
subcast <- newcast[1:30,]
date <- as.Date(Sys.Date())
datestring <- paste(substr(date,1,4), substr(date,6,7), substr(date,9,10), sep="")
dotname <- paste0(wd, "/figs/dotplot.", datestring, ".png")
png(file = dotname, width=6, height=6, unit = "in", bg="white", res=150)
par(mai=c(0.5,0.25,0.25,0.25))
dotchart2(subcast$rf.p, labels=subcast$country, xlim = c(0,0.35),
    lines=TRUE, lwd=0.05, lty=3, sort=FALSE, dotsize=1, col="gray", pch=20, cex.labels=0.7 )
dotchart2(subcast$harff.p, sort=FALSE, lines=FALSE, dotsize=0.9, pch=20, col="gray",
     cex.labels=0.7, xlim=c(0,0.35), add=TRUE )
dotchart2(subcast$threat.p, sort=FALSE, lines=FALSE, dotsize=0.9, pch=20, col="gray",
     cex.labels=0.7, xlim=c(0,0.35), add=TRUE )
dotchart2(subcast$mean.p, sort=FALSE, lines=FALSE, dotsize=0.9, pch=20, col="red",
     cex.labels=0.7, xlim=c(0,0.35), add=TRUE )
title(main=list("Risk of Onset of State-Led Mass Killing Episode", cex=0.9))
dev.off()

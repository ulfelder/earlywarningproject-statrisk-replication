# INFANT MORTALITY ESTIMATES
# 2014-09-08

# Source: U.S. Census Bureau International Division, via PITF

# Clear workspace
rm(list=ls(all=TRUE))

# Get working directory
wd <- getwd()

# Load required packages and functions
source(paste0(wd, "/r/f.countryyearrackit.r"))
source(paste0(wd, "/r/f.pitfcodeit.r"))

# Load file
imrates <- read.csv(paste0(wd, "/data.in/pitf.csv"))

# Reduce file and clean it up
imrates <- imrates[,1:4]
names(imrates) <- c("sftgcode", "year", "imr.raw", "imr.normed")
imrates$sftgcode <- substr(as.character(imrates$sftgcode),1,3)
imrates$sftgcode[imrates$sftgcode=="UK "] <- "UKG"
imrates$imr.raw <- as.numeric(as.character(imrates$imr.raw))
imrates$imr.normed <- round(as.numeric(as.character(imrates$imr.normed)), 2)

# Merge with country-year rack to add USA, which source doesn't cover
rack <- merge(subset(pitfcodeit(countryyearrackit(1955, 2012), "country"), select=c(sftgcode, year)),
  imrates, all.x = TRUE)  # Latest stops in 2012
rack <- rack[order(rack$sftgcode, rack$year),]

# Hard code values for USA, which source doesn't cover, to values for Canada
rack$imr.raw[rack$sftgcode=="USA"] <- rack$imr.raw[rack$sftgcode=="CAN"]
rack$imr.normed[rack$sftgcode=="USA"] <- rack$imr.normed[rack$sftgcode=="CAN"]

# Write it out
write.csv(rack, file = paste0(wd, "/data.out/imr.csv"), row.names = FALSE)
# INTERNATIONAL ORGANIZATIONS AND TREATY REGIMES
# 2014-09-08

# Clear workspace
rm(list=ls(all=TRUE))

# Get working directory
wd <- getwd()

# Load required packages and functions
source(paste0(wd, "/r/f.countryyearrackit.r"))
source(paste0(wd, "/r/f.pitfcodeit.r"))

# Ingest and trim data
ios <- read.csv(paste0(wd, "/data.in/ulfelder io data 2010.csv"))
ios$sftgcode <- as.character(ios$pitfcode)
ios <- data.frame(cbind(ios[,dim(ios)[2]], ios[,4:29]))

# Get variable names fixed for merging
names(ios)[1] <- "sftgcode"
ios$sftgcode <- as.character(ios$sftgcode)
ios$sftgcode[ios$sftgcode=="UK"] <- "UKG"  # Fix country code for UK
names(ios) <- c(names(ios)[1:2], paste0("ios.", names(ios)[3:length(names(ios))]))

# Merge with wider rack to make room for selected updating that follows below  
rack <- merge(subset(pitfcodeit(countryyearrackit(1955,2013), "country"), select=c(sftgcode, year)), ios, all.x = TRUE)
rack <- rack[order(rack$sftgcode, rack$year),]

# Updates source: http://treaties.un.org/Pages/ViewDetails.aspx?src=TREATY&mtdsg_no=IV-5&chapter=4&lang=en
for (i in 1:dim(rack)[1]) rack$ios.iccpr1[i] <- ifelse(rack$year[i] > 2010, rack$ios.iccpr1[i-1], rack$ios.iccpr1[i])
rack$ios.iccpr1[rack$sftgcode=="TUN" & rack$year>=2011] <- 1 # acceded in 2011
rack$ios.iccpr1[rack$sftgcode=="USA"] <- 0 
rack$ios.iccpr1[rack$sftgcode=="SSD"] <- 0 
rack$ios.iccpr1[rack$sftgcode=="MNG"] <- 0 
rack$ios.iccpr1[rack$sftgcode=="SWA"] <- 0 
rack$ios.iccpr1[rack$sftgcode=="GNB" & rack$year>=2013] <- 1  # acceded in 2013

# Source: http://www.wto.org/english/thewto_e/whatis_e/tif_e/org6_e.htm
for (i in 1:dim(rack)[1]) rack$ios.gattwto[i] <- ifelse(rack$year[i] > 2010, rack$ios.gattwto[i-1], rack$ios.gattwto[i])
rack$ios.gattwto[rack$sftgcode=="MNG" & rack$year>=2012] <- 1  # acceded in 2012
rack$ios.gattwto[rack$sftgcode=="RUS" & rack$year>=2012] <- 1  # acceded in 2012
rack$ios.gattwto[rack$sftgcode=="SRB"] <- 0  # fill in missing
rack$ios.gattwto[rack$sftgcode=="SSD"] <- 0  # fill in missing
rack$ios.gattwto[rack$sftgcode=="USA"] <- 1  # fill in missing
rack$ios.gattwto[rack$sftgcode=="LAO" & rack$year>=2013] <- 1  # acceded in 2013
rack$ios.gattwto[rack$sftgcode=="TAJ" & rack$year>=2013] <- 1  # acceded in 2013

write.csv(rack, file = paste0(wd, "/data.out/ios.csv"), row.names = FALSE)

# CPG STATISTICAL RISK ASSESSMENT MODEL ESTIMATION AND APPLICATION
# 2015-05-16

# Clear workspace
rm(list=ls(all=TRUE))

# Get working directory
wd <- getwd()

# Load required packages
library(randomForest)
library(DataCombine)
library(dplyr)

# Set seed
set.seed(20912)

# Load the compiled and transformed data
dat <- read.csv(paste0(wd, "/data.out/ewp.statrisk.data.transformed.csv"))

# Get model formulae
source(paste0(wd, "/r/model.formulae.r"))

####################################
# Model Estimation
####################################

# Remove most recent 2 yrs to avoid treating in-sample ests as forecasts in cases with missing recent data
subdat <- subset(dat, year < as.numeric(substr(as.Date(Sys.Date()),1,4)) - 2)

coup <- glm(f.coup, family = binomial, data = subdat, na.action = na.exclude)
dat$coup.p <- predict(coup, newdata = dat, type = "response")
subdat$coup.p <- predict(coup, newdata = subdat, type = "response")

cwar <- glm(f.cwar, family = binomial, data = subdat, na.action = na.exclude)
dat$cwar.p <- predict(cwar, newdata = dat, type = "response")
subdat$cwar.p <- predict(cwar, newdata = subdat, type = "response")

threat <- glm(f.threat, family = binomial, data = subdat, na.action = na.exclude)
dat$threat.p <- predict(threat, newdata = dat, type = "response")

pitf <- glm(f.pitf, family = binomial, data = subset(subdat, pit.any.ongoing==0), na.action = na.exclude)
dat$pitf.p <- predict(pitf, newdata = dat, type = "response")
subdat$pitf.p <- predict(pitf, newdata = subdat, type = "response")

harff <- glm(f.harff, family = binomial, data = subdat, na.action = na.exclude)
dat$harff.p <- predict(harff, newdata = dat, type = "response")

rf <- randomForest(f.rf, data = subdat, na.action = na.exclude, ntree = 1000,
  mtry = 3, cutoff = c(0.2,0.8)) # Params selected thru gridded search in validation stage
dat$rf.p <- predict(rf, type = "prob", newdata = dat, na.action = na.exclude)[,2]

###############################################
# Predictions Using Last Valid Observations
###############################################

# Create vector of labels of all variables used in all model formulae with ID vars at the front. The 'unique'
# part eliminates duplicates, and the [[3]] part restricts the call to features/independent variables. If you
# want to include targets/dependent variables from all models, too, just delete the [[3]]s.
varlist <- c(c("country", "sftgcode", "year"), unique(c(all.vars(f.coup[[3]]), all.vars(f.cwar[[3]]),
  all.vars(f.threat[[3]]), all.vars(f.pitf[[3]]), all.vars(f.harff[[3]]), all.vars(f.rf[[3]]))))

# A function to get the last non-missing value from 'dat' for each model variable for a given country code
pull <- function(i) {
  d <- subset(dat, sftgcode==i, select = varlist)
  snip <- function(x) { rev( na.omit(x) )[1] }
  xi <- lapply(d, snip)
  xi <- as.data.frame(xi)
  return(xi)
}

# Apply that function to a list of country codes and rbind the resulting vectors
latest <- as.list(unique(as.character(dat$sftgcode))) %>%
    lapply(., pull) %>%
    Reduce(function(x, y) { rbind(x, y) }, .)

# Hard code a couple of missing values for North Korea
latest$wdi.trade.ln[latest$sftgcode=="PRK"] <- log(100 * ((4.0 + 4.8)/40.0)) # CIA World Factbook
latest$gdppcgrow.sr[latest$sftgcode=="PRK"] <- sqrt(abs(1.1)) # http://www.nkeconwatch.com/nk-uploads/GDP_of_North_Korea_in_2013_F.pdf

# A function to get predictions from a data frame with the variables in model.formulae.r
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

# Apply that function to latest available data to get country forecasts. NOTE: If this produced an error
# message about the number of rows not matching, it means there are still some missing values in 'latest'.
# The simplest way to spot those missing values is to call fix(latest) and scroll around the table in search
# of NAs. Every NA needs to be addressed for this function to work. In future updates, some missing values
# may best be addressed at the data ingestion stage (where the 'data.[prefix].r' scripts work, but the odd
# case can also be addressed by adding a line above to hard code the relevant input if need be.
newcast <- forecast(latest)

# Create variable identifying year to which forecasts apply (last year in original data plus 1)
newcast$forecast.year <- max(dat$year) + 1

# Move ID variables and forecasts to front of data frame
newcast <- MoveFront(newcast, c("country", "sftgcode", "forecast.year", "mean.p", "rf.p", "threat.p", "harff.p"))

# Put in descending order by mean.p
newcast <- newcast[order(-newcast$mean.p),]

# Write it out
write.csv(newcast, file = paste0(wd, "/data.out/ewp.forecasts.csv"), row.names = FALSE)

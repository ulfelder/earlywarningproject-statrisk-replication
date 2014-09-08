# CPG STATISTICAL RISK ASSESSMENT MODEL VALIDATION
# 2014-09-07

# Clear workspace
rm(list=ls(all=TRUE))

# Load all required packages
library(caret)
library(randomForest)
library(verification)
library(ROCR)

# Set working directory
setwd("c:/users/jay/documents/ushmm/statrisk.replication/data.out/")

# Load the merged data
dat <- read.csv("ewp.statrisk.data.transformed.csv")

# Load the model formulae
source("c:/users/jay/documents/ushmm/statrisk.replication/r/model.formulae.r")

#############################
# Model Validation
#############################

valdat <- subset(dat, year >= 1960 & year <= 2013 & dat$year >= dat$yrborn & dat$year <= dat$yrdied & is.na(mkl.start.1) == FALSE)
y <- valdat$mkl.start.1
valdat$k <- createFolds(y, k = 10, list = FALSE)

predit <- function(x) {
     train <- subset(valdat, k != x)
     test <- subset(valdat, k == x)
     test$cwar.p <- predict(glm(f.cwar, family = binomial, data = train, na.action = na.exclude), newdata = test, type = "response")
     test$coup.p <- predict(glm(f.coup, family = binomial, data = train, na.action = na.exclude), newdata = test, type = "response")
     train$cwar.p <- predict(glm(f.cwar, family = binomial, data = train, na.action = na.exclude), type = "response")
     train$coup.p <- predict(glm(f.coup, family = binomial, data = train, na.action = na.exclude), type = "response")
     test$threat.p <- predict(glm(f.threat, family = binomial, data = train, na.action = na.exclude), newdata = test, type = "response")
     test$pitf.p <- predict(glm(f.pitf, family = binomial, data = subset(train, pit.any.ongoing==0),
       na.action = na.exclude), newdata = test, type = "response")
     train$pitf.p <- predict(glm(f.pitf, family = binomial, data = train, na.action = na.exclude), type = "response")
     test$harff.p <- predict(glm(f.harff, family = binomial, data = train, na.action = na.exclude), newdata = test, type = "response")
     require(randomForest)
     test$rf.p <- predict(randomForest(f.rf, data = train, na.action="na.exclude", ntree = 1000, mtry = 3, cutoff=c(0.2,0.8)),
       newdata = test, type = "prob", na.action = "na.exclude")[,2]
     test$mean.p <- (test$threat.p + test$harff.p + test$rf.p)/3
     out <- subset(test, select = c(sftgcode, year, mkl.start.1, mean.p, threat.p, harff.p, rf.p, k))
     return(out)
}

out <- rbind(predit(1), predit(2), predit(3), predit(4), predit(5), predit(6), predit(7), predit(8), predit(9), predit(10))

# Distribution of AUC scores by fold
fun.auc <- function(df, x) {
  require(verification)
  mean <- roc.area(df$mkl.start.1[out$k==x], df$mean.p[out$k==x])
  harff <- roc.area(df$mkl.start.1[out$k==x], df$harff.p[out$k==x])
  threat <- roc.area(df$mkl.start.1[out$k==x], df$threat.p[out$k==x])
  rf <- roc.area(df$mkl.start.1[out$k==x], df$rf.p[out$k==x])
  all <- c(x, mean$A, harff$A, threat$A, rf$A )
  names(all) <- c("fold", "mean", "harff", "threat", "RF")
  return(all)
}

auctab <- as.data.frame(rbind(fun.auc(out, 1), fun.auc(out, 2), fun.auc(out, 3), fun.auc(out, 4), fun.auc(out, 5),
  fun.auc(out, 6), fun.auc(out, 7), fun.auc(out, 8), fun.auc(out, 9), fun.auc(out, 10)))

### PLOTS ###

# Set working directory
setwd("c:/users/jay/documents/ushmm/statrisk.replication/figs/")

png(file = "cpg.statrisk2014.replication.val.auc.by.fold.png",
     width=12, height=12, units='cm', bg='white', res=150)
par(mai=c(0.5,0.5,0.5,0.5))
plot(density(auctab$mean), xlim=c(0.5,1), ylim=c(0,8), lwd = 2.5, main = "", col = "black",
     bty = "n", mai = c(1.5, 0.5, 0.25, 0.25), xaxt = "n", yaxt = "n", xlab = "AUC", ylab = "" )
axis(1, tick = FALSE)
lines(density(auctab$harff), col = "red", xlim=c(0.5,1), ylim=c(0,8), lwd = 1.5)
lines(density(auctab$threat), col = "blue", xlim=c(0.5,1), ylim=c(0,8), lwd = 1.5)
lines(density(auctab$RF), col = "forestgreen", xlim=c(0.5,1), ylim=c(0,8), lwd = 1.5)
text(x = 1, y = 8, paste("average", substr(as.character(mean(auctab$mean)),1,5), sep = " = "),
  col = "black", pos = 2)
text(x = 1, y = 7.5, paste("PITF/Harff", substr(as.character(mean(auctab$harff)),1,5), sep = " = "),
  col = "red", pos = 2)
text(x = 1, y = 7, paste("elite threat", substr(as.character(mean(auctab$threat)),1,5), sep = " = "),
  col = "blue", pos = 2)
text(x = 1, y = 6.5, paste("RF", substr(as.character(mean(auctab$RF)),1,5), sep = " = "),
  col = "forestgreen", pos = 2)
dev.off()

# ROC curves by model
mean.pred <- prediction(out$mean.p, out$mkl.start.1)
mean.roc <- performance(mean.pred, "tpr", "fpr")
mean.auc <- performance(mean.pred, measure = "auc")
harff.pred <- prediction(out$harff.p, out$mkl.start.1)
harff.roc <- performance(harff.pred, "tpr", "fpr")
harff.auc <- performance(harff.pred, measure = "auc")
threat.pred <- prediction(out$threat.p, out$mkl.start.1)
threat.roc <- performance(threat.pred, "tpr", "fpr")
threat.auc <- performance(threat.pred, measure = "auc")
rf.pred <- prediction(out$rf.p, out$mkl.start.1)
rf.roc <- performance(rf.pred, "tpr", "fpr")
rf.auc <- performance(rf.pred, measure = "auc")

png(file = "cpg.statrisk.replication.val.roc.by.model.png",
     width=12, height=12, units='cm', bg='white', res=150)
plot(mean.roc, col = "black", lwd=2, add = FALSE)
plot(threat.roc, col = "blue", add = TRUE)
plot(harff.roc, col = "red", add = TRUE)
plot(rf.roc, col = "forestgreen", add = TRUE)
text(x=1,y=0.15,
     labels = paste("RF", substring(as.character(rf.auc@y.values),1,5), sep=' = '),
     pos=2, cex=0.75, col = "forestgreen")
text(x=1,y=0.10,
     labels = paste("PITF/Harff", substring(as.character(harff.auc@y.values),1,5), sep=' = '),
     pos=2, cex=0.75, col = "red")
text(x=1,y=0.05,
     labels = paste("elite threat", substring(as.character(threat.auc@y.values),1,5), sep=' = '),
     pos=2, cex=0.75, col = "blue")
text(x=1,y=0,
     labels = paste("average", substring(as.character(mean.auc@y.values),1,5), sep=' = '),
     pos=2, cex=0.75, col = "black")
dev.off()

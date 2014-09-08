# UCDP/PRIO CONFLICT DATA
# 2014-09-03

# Source: http://www.tlscherer.com/ucdptools/

install.packages("devtools")
library(devtools)
install_github("tlscherer/UCDPtools", dependencies=TRUE)
library(UCDPtools)
data(UCDPindex)

ucdp <- getUCDP("ArmedConflict")

head(ucdp)
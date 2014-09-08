earlywarningproject-statrisk-replication
========================================

This repository contains R scripts and links to the data required to reproduce---and, if desired, to modify or to extend---statistical risk assessments I generate for the Early Warning Project. Please direct questions or bug reports to me at ulfelder@gmail.com or to the larger project at ewp@ushmm.org. To learn more about the design of our statistical risk assessment process and the Early Warning Project more generally, see [this FAQ](http://cpgearlywarning.wordpress.com/about/frequently-asked-questions/).

The process of generating these risk assessments has two stages: 1) data ingestion, compilation, and transformation; and 2) modeling. The R scripts in this repository are prefixed accordingly (data or model). You can follow the process all the way from the raw source data to forecasts based on the most recent data available, or you can load the compiled and transformed data set and proceed directly to stage 2, modeling.

It is important to note at the start that replication of this modeling process will not precisely reproduce the risk assessments reported by the Early Warning Project. These assessments are an average of three forecasts, one of which is produced by Random Forests. As the name implies, each application of Random Forests to the same data will produce slightly different results. When the process is properly reproduced, the results should be quite similar but not exactly the same. 

__DIRECTORY STRUCTURE__
_______________________

The scripts listed below assume that the working directory in R is set to a target directory that has the same structure as this repository, i.e., contains the following subdirectories:

* \r
* \data.in
* \data.out
* \figs

All of the R scripts listed here, including the two functions listed under DEPENDENCIES, should be stored in the \r subdirectory or folder.

All of the source data files should be stored in the \data.in folder. (This does not need to be created if you plan to skip directly to stage 2, modeling.)

The \data.out folder is used to hold all of the files created in stage 1, including the compiled and transformed version of the data set, and the forecasts generated in the modeling stage by "model.prediction.r". *NOTE: If you plan to skip stage 1 and go right to modeling, you need to have the data set produced by "data.transformation.r" in this folder, NOT in the \data.in folder.*

The \figs folder is the destination for plots and maps created by "model.validation.r" and "model.prediction.r".

__ANALYSIS__
____________

### 1. Data

The scripts for stage 1 (data) are listed below. The root part of each script's name refers to a specific source file (e.g., pol refers to Polity IV). That root matches the prefix used to identify that source's data and transformations of it in the complete data set.

The order in which these scripts are run does not matter, with the important exception that "data.transformation.r" depends on all of the others and therefore must be run last. It ingests and merges the files created by all of the other scripts and then performs certain transformations before outputting the results to \data.out in a .csv called "ewp.statrisk.data.transformed.csv".

The "data.dictionary.r" script is optional. It creates a data dictionary for the merged and transformed data set in the form of a .tex file that is written to \data.out. You can also browse and search the script itself for information on specific variables and the sources.

* data.aut.r
* data.cmm.r
* data.cpt.r
* data.dis.r
* data.elc.r
* data.fiw.r
* data.hum.r
* data.imf.r
* data.imr.r
* data.ios.r
* data.mev.r
* data.mkl.r
* data.pol.r
* data.pit.r
* data.wdi.r
* data.transformation.r
* data.dictionary.r

Of course, these scripts also depend on access to files (or, in a few cases, URLs) with the raw source data stored in \data.in. 

### 2. Modeling

The scripts for stage 2 (modeling) are listed below. *Users wishing to replicate or extend the risk assessments used by EWP may simply start with the "ewp.statrisk.data.transformed.csv" data set produced by "data.transformation.r" in stage 1 and then use these scripts.*

* model.formulae.r
* model.prediction.r
* model.plots.r
* model.validation.r

The "model.formulae.r" script creates the formula objects used by both of the other scripts. It does not have to be run directly, but it does need to be in the appropriate directory so that "model.prediction.r" and "model.validation.r" can call it via the 'source' command.

The "model.prediction.r" script estimates models from the historical data and then applies them to the latest available observations of all of the features/independent variables involved for all countries to generate current risk assessments. *NOTE: Values for a few missing observations are hard-coded within this script because the source data sets include no valid observations for that variable for that country, or because the most recent observation available is from many years ago. When this script is used in future years to generate current risk assessments, you should check to see if that has changed or update the hard-coded values if possible.*

Additional hard-codes or related solutions may also be required if sources fail to update in general or for specific cases. See the notes at the top of the script for more information.

The "model.plot.r" script generates heat maps and a dot plot of the forecasts generated by "model.prediction.r".

The "model.validation.r" script uses 10-fold cross-validation with stratified random splitting to get a sense of the models' and the ensemble's predictive power of the past several decades. There is no feature selection involved. These models were specified a priori to represent existing theories on the causes of mass killings, so this script is only used to demonstrate that the resulting models and the average of forecasts from them do have real predictive power. For users looking to alter or improve on the risk-assessment process, it may also be used iteratively to compare the predictive power of various specifications.

DEPENDENCIES
____________

This work was originally done in R Version 3.1.1 for 64-bit Windows OS. In addition to base R, it depends on the following packages:

* caret
* DataCombine
* foreign
* Hmisc
* plm
* plyr
* randomForest
* reshape
* rworldmap
* WDI
* XLConnect
* xlsx

The process also depends on two custom functions, one that creates a time-series, cross-sectional data set of country-years with some relevant metadata (e.g., years of country birth and death, geographic region) and another that adds 3-letter PITF country codes to that data set (and any other data set with a column of country names). Those functions are given in the following scripts. See the tops of the scripts for an explanation of the syntax each requires. These scripts must be stored in the \r subdirectory so they can be called via the 'source' command by the other data-related scripts.

* f.countryyearrackit.r
* f.pitfcodeit.r

Users looking to add other country codes can load the 'countrycode' package and apply it to the "country" column in these data. For example, if you wanted to add numeric Correlates of War (COW) codes to the file, you could run the following (caveat emptor):

    library(countrycode)
    dat$cowcode <- countrycode(dat$country, origin = "country.name", destination = "cown", warn = TRUE)

Alternatively, you can apply the 'pitfcodeit' function to other data sets you wish you to merge with this one and then merge on "sftgcode" and "year" instead.

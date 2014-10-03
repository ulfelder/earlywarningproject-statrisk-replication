#!/usr/bin/env python

import ConfigParser
import os
import rpy2.robjects as robjects

config = ConfigParser.SafeConfigParser()

# traverse root configuration directory
for root, dirs, files in os.walk("../conf"):
    path = root.split('/')
    for file in files:
        print os.path.join(root, file)
        config.readfp(open(os.path.join(root, file)))

#get all configuration properties
working_directory = config.get('files_and_directories', 'working_directory')
r_library_dir = config.get('files_and_directories', 'r_library_directory')
country = config.get('headers_and_columns', 'country_header')
year = config.get('headers_and_columns', 'year_header')
sftgcode = config.get('headers_and_columns', 'sftgcode_header')

input_file = config.get('aut', 'input_file')
output_file = config.get('aut', 'output_file')

#get country file updates
country_file = config.get('files_and_directories', 'country_file')

robjects.r('setwd("' + working_directory + '")')

#debug
robjects.r('print(getwd())')

#run all necessary R code for dta file
robjects.r('require(foreign)')
robjects.r('require(DataCombine)')
robjects.r('source(paste0("' + working_directory + '", "' + r_library_dir + country_file + '"))')

robjects.r('aut <- read.dta(paste0(getwd(), "' + input_file + '"), convert.factors = FALSE, convert.underscore = TRUE)')

# Change names to get right prefix
robjects.r('names(aut) <- c(names(aut)[1:2], "' + country + '", gsub("gwf", "aut", x = names(aut)[4:length(names(aut))], fixed = TRUE) )')

# Add PITF country codes and cut extra ids
robjects.r('aut <- pitfcodeit(aut, "country")')
robjects.r('aut$cowcode <- aut$country <- NULL')

# Get the IDs at the start of the row
robjects.r('aut <- MoveFront(aut, c("' + sftgcode + '", "' + year + '"))')

# Write it out
robjects.r('write.csv(aut, paste0(getwd(), "' + output_file + '"), row.names = FALSE)')


# import pandas
# inputdata = pandas.read_stata('/Users/douglasgartner/Documents/USHMM/earlywarningproject-statrisk-replication/data.in/GWFtscs.dta')
# inputdata.to_csv('/Users/douglasgartner/Desktop/test.csv')




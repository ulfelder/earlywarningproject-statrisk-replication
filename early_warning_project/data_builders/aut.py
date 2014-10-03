#!/usr/bin/env python

import rpy2.robjects as robjects
import urllib2
import zipfile
from early_warning_project.dataset import Dataset


class Aut(Dataset):

    def __init__(self):
        super(Aut, self).__init__()
        self.name = self.config.get('aut', 'name')
        self.url = self.config.get('aut', 'url')

    def download_data(self):
        # Download latest file
        print('downloading - ' + self.url + ' ...')
        response = urllib2.urlopen(self.url)
        print('download completed successfully')

        download_directory = self.config.get('files_and_directories', 'download_directory')
        data_in_directory = self.config.get('files_and_directories', 'data_in_directory')
        zip_filename = self.config.get('aut', 'zip_file')
        file_in_zip = self.config.get('aut', 'individual_file_in_zip')
        filename = self.config.get('aut', 'filename')

        #extract file(s) from zip download
        input_zip = open(download_directory + "/" + zip_filename, 'wb+')
        input_zip.write(response.read())
        zf = zipfile.ZipFile(input_zip)
        data = zf.read(file_in_zip)
        data_file = open(data_in_directory + "/" + filename, 'wb')
        data_file.write(data)
        data_file.close()
        zf.close()

    def build_data(self):

        #get all self.configuration properties
        working_directory = self.config.get('files_and_directories', 'working_directory')
        r_library_dir = self.config.get('files_and_directories', 'r_library_directory')
        country = self.config.get('headers_and_columns', 'country_header')
        year = self.config.get('headers_and_columns', 'year_header')
        sftgcode = self.config.get('headers_and_columns', 'sftgcode_header')

        input_file = self.config.get('aut', 'input_file_for_R')
        output_file = self.config.get('aut', 'output_file_for_R')

        #get country file updates
        country_file = self.config.get('files_and_directories', 'country_file')

        robjects.r('setwd("' + working_directory + '")')

        #debug
        #robjects.r('print(getwd())')
        print('running R aut transformation ...')

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

        print('successfully completed R aut transformation')

        # This can also be done with the python library 'pandas'
        # Uncomment the code below to see what the output CSV looks like using pandas

        # import pandas
        # inputdata = pandas.read_stata('/Users/douglasgartner/Documents/USHMM/earlywarningproject-statrisk-replication/data.in/GWFtscs.dta')
        # inputdata.to_csv('/Users/douglasgartner/Desktop/test.csv')

def main():
    dataset = Aut()
    Aut.download_data(dataset)
    Aut.build_data(dataset)

if __name__ == '__main__':
    main()
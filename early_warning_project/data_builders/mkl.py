#!/usr/bin/env python

import urllib2
import shutil as shutil
from early_warning_project.dataset import Dataset
import subprocess


class Mkl(Dataset):

    def __init__(self):
        super(Mkl, self).__init__()
        self.name = self.config.get('mkl', 'name')
        self.url = self.config.get('mkl', 'url')

    def download_data(self):
        # Download latest file
        print('The mkl file does not need to downloaded. It is maintained in the R script')

    def build_data(self):

        print('running R mkl transformation ...')

        rscript = self.config.get('files_and_directories', 'r_script_install')
        working_directory = self.config.get('files_and_directories', 'working_directory')
        Mkl_r_file = working_directory + self.config.get('mkl', 'mkl_r_file')
        output_r_file = self.config.get('mkl', 'output_file_for_R')

        command = rscript, Mkl_r_file, working_directory, output_r_file

        print(command)
        print(subprocess.check_output(command))

        print('successfully completed R mkl transformation')



# All you are doing here is making it possible for this dataset to run on it's own
# You can simply change the name of the 'Template' class to the name of your dataset class
def main():
    dataset = Mkl()
    Mkl.download_data(dataset)
    Mkl.build_data(dataset)

if __name__ == '__main__':
    main()
#!/usr/bin/env python

import urllib2
import xlrd
import shutil as shutil
from early_warning_project.dataset import Dataset
import subprocess


class Cmm(Dataset):

    def __init__(self):
        super(Cmm, self).__init__()
        self.name = self.config.get('cmm', 'name')
        self.url = self.config.get('cmm', 'url')

    def download_data(self):
        # Download latest file
        print('downloading - ' + self.url + ' ...')
        response = urllib2.urlopen(self.url)
        print('download completed successfully')

        download_directory = self.config.get('files_and_directories', 'download_directory')
        data_in_directory = self.config.get('files_and_directories', 'data_in_directory')

        filename = self.config.get('cmm', 'filename')

        src_file = download_directory + "/" + filename

        input_file = open(src_file, 'wb+')
        input_file.write(response.read())
        input_file.close()

        shutil.copyfile(src_file, data_in_directory + "/" + filename)

    def build_data(self):

        print('running R cmm transformation ...')

        rscript = self.config.get('files_and_directories', 'r_script_install')
        working_directory = self.config.get('files_and_directories', 'working_directory')
        cmm_r_file = working_directory + self.config.get('cmm', 'cmm_r_file')
        input_r_file = self.config.get('cmm', 'input_file_for_R')
        output_r_file = self.config.get('cmm', 'output_file_for_R')

        command = rscript, cmm_r_file, working_directory, input_r_file, output_r_file

        print(command)
        print(subprocess.check_output(command))

        print('successfully completed R cmm transformation')



# All you are doing here is making it possible for this dataset to run on it's own
# You can simply change the name of the 'Template' class to the name of your dataset class
def main():
    dataset = Cmm()
    Cmm.download_data(dataset)
    Cmm.build_data(dataset)

if __name__ == '__main__':
    main()
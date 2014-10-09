#!/usr/bin/env python

import urllib2
import shutil as shutil
from early_warning_project.dataset import Dataset
import subprocess


class Fiw(Dataset):

    def __init__(self):
        super(Fiw, self).__init__()
        self.name = self.config.get('fiw', 'name')
        self.url = self.config.get('fiw', 'url')

    def download_data(self):
        # Download latest file
        print('downloading - ' + self.url + ' ...')
        response = urllib2.urlopen(self.url)
        print('download completed successfully')

        filename = self.config.get('fiw', 'filename')

        src_file = self.download_directory + "/" + filename

        input_file = open(src_file, 'wb+')
        input_file.write(response.read())
        input_file.close()

        shutil.copyfile(src_file, self.data_in_directory + "/" + filename)

    def build_data(self):

        print('running R fiw transformation ...')

        rscript = self.config.get('files_and_directories', 'r_script_install')
        working_directory = self.config.get('files_and_directories', 'working_directory')
        fiw_r_file = working_directory + self.config.get('fiw', 'fiw_r_file')
        input_r_file = self.config.get('fiw', 'input_file_for_R')
        output_r_file = self.config.get('fiw', 'output_file_for_R')

        command = rscript, fiw_r_file, working_directory, input_r_file, output_r_file

        print(command)
        print(subprocess.check_output(command))

        print('successfully completed R fiw transformation')



# All you are doing here is making it possible for this dataset to run on it's own
# You can simply change the name of the 'Template' class to the name of your dataset class
def main():
    dataset = Fiw()
    Fiw.download_data(dataset)
    Fiw.build_data(dataset)

if __name__ == '__main__':
    main()
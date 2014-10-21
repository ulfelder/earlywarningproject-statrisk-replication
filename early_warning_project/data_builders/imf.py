#!/usr/bin/env python

import urllib2
import shutil as shutil
from early_warning_project.dataset import Dataset
import subprocess


class Imf(Dataset):

    def __init__(self):
        super(Imf, self).__init__()
        self.name = self.config.get('imf', 'name')
        self.url = self.config.get('imf', 'url')

    def download_data(self):
        # Download latest file
        print('downloading - ' + self.url + ' ...')
        response = urllib2.urlopen(self.url)
        print('download completed successfully')

        filename = self.config.get('imf', 'filename')
        encoded_filename = self.config.get('imf', 'encoded_filename')

        src_file = self.download_directory + "/" + filename
        src_file2 = self.download_directory + "/" + encoded_filename

        input_file = open(src_file, 'wb+')
        input_file.write(response.read())
        input_file.close()

        sourceEncoding = "cp1252"
        targetEncoding = "utf-8"
        source = open(src_file)
        target = open(src_file2, "w")
        target.write(unicode(source.read(), sourceEncoding).encode(targetEncoding))
        target.close()

        shutil.copyfile(src_file2, self.data_in_directory + "/" + filename)

    def build_data(self):

        print('running R imf transformation ...')

        rscript = self.config.get('files_and_directories', 'r_script_install')
        working_directory = self.config.get('files_and_directories', 'working_directory')
        imf_r_file = working_directory + self.config.get('imf', 'imf_r_file')
        input_r_file = self.config.get('imf', 'input_file_for_R')
        output_r_file = self.config.get('imf', 'output_file_for_R')

        command = rscript, imf_r_file, working_directory, input_r_file, output_r_file

        print(command)
        print(subprocess.check_output(command))

        print('successfully completed R imf transformation')



# All you are doing here is making it possible for this dataset to run on it's own
# You can simply change the name of the 'Template' class to the name of your dataset class
def main():
    dataset = Imf()
    Imf.download_data(dataset)
    Imf.build_data(dataset)

if __name__ == '__main__':
    main()
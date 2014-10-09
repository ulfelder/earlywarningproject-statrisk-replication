#!/usr/bin/env python

import urllib2
import shutil as shutil
from early_warning_project.dataset import Dataset
import subprocess


class Pit(Dataset):

    def __init__(self):
        super(Pit, self).__init__()
        self.name = self.config.get('pit', 'name')
        self.url = self.config.get('pit', 'url')

    def download_data(self):
        # Download latest file
        print('downloading - ' + self.url + ' ...')
        response = urllib2.urlopen(self.url)
        print('download completed successfully')

        filename = self.config.get('pit', 'filename')

        src_file = self.download_directory + "/" + filename

        input_file = open(src_file, 'wb+')
        input_file.write(response.read())
        input_file.close()

        # filename = PITF Adverse Regime Change 2013.xls
        # filename_ethnic_war = PITF Ethnic War 2013.xls
        # filename_revolutionary_war = PITF Revolutionary War 2013.xls
        # filename_geno_politicide = PITF GenoPoliticide 2013.xls

        url_ethnic_war = self.config.get('pit', 'url_ethnic_war')
        print('downloading - ' + url_ethnic_war + ' ...')
        response = urllib2.urlopen(url_ethnic_war)
        print('download completed successfully')

        filename_ethnic_war = self.config.get('pit', 'filename_ethnic_war')

        src_file_ethnic_war = self.download_directory + "/" + filename_ethnic_war

        input_file_ethnic_war = open(src_file_ethnic_war, 'wb+')
        input_file_ethnic_war.write(response.read())
        input_file_ethnic_war.close()

        url_revolutionary_war = self.config.get('pit', 'url_revolutionary_war')
        print('downloading - ' + url_revolutionary_war + ' ...')
        response = urllib2.urlopen(url_revolutionary_war)
        print('download completed successfully')

        filename_revolutionary_war = self.config.get('pit', 'filename_revolutionary_war')

        src_file_revolutionary_war = self.download_directory + "/" + filename_revolutionary_war

        input_file_revolutionary_war = open(src_file_revolutionary_war, 'wb+')
        input_file_revolutionary_war.write(response.read())
        input_file_revolutionary_war.close()

        url_geno_politicide = self.config.get('pit', 'url_geno_politicide')
        print('downloading - ' + url_geno_politicide + ' ...')
        response = urllib2.urlopen(url_geno_politicide)
        print('download completed successfully')

        filename_geno_politicide = self.config.get('pit', 'filename_geno_politicide')

        src_file_geno_politicide = self.download_directory + "/" + filename_geno_politicide

        input_file_geno_politicide = open(src_file_geno_politicide, 'wb+')
        input_file_geno_politicide.write(response.read())
        input_file_geno_politicide.close()

        shutil.copyfile(src_file, self.data_in_directory + "/" + filename)
        shutil.copyfile(src_file_ethnic_war, self.data_in_directory + "/" + filename_ethnic_war)
        shutil.copyfile(src_file_revolutionary_war, self.data_in_directory + "/" + filename_revolutionary_war)
        shutil.copyfile(src_file_geno_politicide, self.data_in_directory + "/" + filename_geno_politicide)

    def build_data(self):

        print('running R pit transformation ...')

        rscript = self.config.get('files_and_directories', 'r_script_install')
        working_directory = self.config.get('files_and_directories', 'working_directory')
        Pit_r_file = working_directory + self.config.get('pit', 'pit_r_file')
        input_r_file = self.config.get('pit', 'input_file_for_R')
        input_r_file_ethnic_war = self.config.get('pit', 'input_file_for_R_ethnic_war')
        input_r_file_revolutionary_war = self.config.get('pit', 'input_file_for_R_revolutionary_war')
        input_r_file_geno_politicide = self.config.get('pit', 'input_file_for_R_geno_politicide')
        output_r_file = self.config.get('pit', 'output_file_for_R')

        command = rscript, Pit_r_file, working_directory, input_r_file, input_r_file_ethnic_war, input_r_file_revolutionary_war, input_r_file_geno_politicide, output_r_file

        print(command)
        print(subprocess.check_output(command))

        print('successfully completed R pit transformation')



# All you are doing here is making it possible for this dataset to run on it's own
# You can simply change the name of the 'Template' class to the name of your dataset class
def main():
    dataset = Pit()
    Pit.download_data(dataset)
    Pit.build_data(dataset)

if __name__ == '__main__':
    main()
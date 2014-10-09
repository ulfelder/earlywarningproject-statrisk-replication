#!/usr/bin/env python

import os
import ConfigParser


def cleanall():

    config = ConfigParser.SafeConfigParser()

    # traverse root configuration directory
    main_base = os.path.dirname(os.path.abspath(__file__))
    config_directory = main_base + "/../conf"

    for root, dirs, files in os.walk(config_directory):
        path = root.split('/')
        for file in files:
            config.readfp(open(os.path.join(root, file)))

    print('cleaning all working directories ...')
    # clean up all downloads, distributions, output csv files, etc.
    working_directory = config.get('files_and_directories', 'working_directory')
    download_directory = working_directory + "/" + config.get('files_and_directories', 'download_directory')
    data_in_directory = working_directory + "/" + config.get('files_and_directories', 'data_in_directory')
    data_out_directory = working_directory + "/" + config.get('files_and_directories', 'data_out_directory')
    distribution_directory = working_directory + "/" + config.get('files_and_directories', 'distribution_directory')

    folders = [download_directory, data_in_directory, data_out_directory, distribution_directory]

    for folder in folders:
        if not os.path.exists(folder):
            os.makedirs(folder)
        for the_file in os.listdir(folder):
            file_path = os.path.join(folder, the_file)
            try:
                os.unlink(file_path)
            except Exception, e:
                print(e)

    print('successfully cleaned working directories')


def main():
    cleanall()

if __name__ == '__main__':
    main()
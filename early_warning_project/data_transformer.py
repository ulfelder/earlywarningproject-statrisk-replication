#!/usr/bin/env python

import os
import ConfigParser
import subprocess

def transform_data():

    config = ConfigParser.SafeConfigParser()

    # traverse root configuration directory
    main_base = os.path.dirname(__file__)
    config_directory = main_base + "/../conf"

    for root, dirs, files in os.walk(config_directory):
        path = root.split('/')
        for file in files:
            config.readfp(open(os.path.join(root, file)))

    print('running complete data transformation ...')

    rscript = config.get('files_and_directories', 'r_script_install')
    working_directory = config.get('files_and_directories', 'working_directory')
    r_library_directory = config.get('files_and_directories', 'r_library_directory')
    r_transformer_script = working_directory + r_library_directory + "/" + config.get('files_and_directories', 'r_transformer_script')

    command = rscript, r_transformer_script, working_directory

    print(command)
    print(subprocess.check_output(command))

    print('successfully completed transformation')

def main():
    transform_data()

if __name__ == '__main__':
    main()
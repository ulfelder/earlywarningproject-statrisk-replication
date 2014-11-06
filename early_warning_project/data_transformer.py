#!/usr/bin/env python

import os
import ConfigParser
import subprocess
import shutil
import time

def transform_data():

    config = ConfigParser.SafeConfigParser()

    # traverse root configuration directory
    main_base = os.path.dirname(os.path.abspath(__file__))
    config_directory = main_base + "/../conf"

    for root, dirs, files in os.walk(config_directory):
        for file in files:
            config.readfp(open(os.path.join(root, file)))

    # Run the R transformation module to generate transformed dataset
    print('running complete data transformation ...')

    try:
        rscript = config.get('files_and_directories', 'r_script_install')
        working_directory = config.get('files_and_directories', 'working_directory')
        r_library_directory = config.get('files_and_directories', 'r_library_directory')
        r_transformer_script = working_directory + r_library_directory + "/" + config.get('files_and_directories', 'r_transformer_script')
        output_directory = config.get('transformation', 'output_directory')
        filename = config.get('transformation', 'filename')
        filetype = config.get('transformation', 'filetype')
        output_file = output_directory + "/" + filename + "." + filetype
        archive_directory = config.get('files_and_directories', 'archive_dir')

        command = rscript, r_transformer_script, working_directory, output_file

        print(command)
        print(subprocess.check_output(command))

        print('successfully completed transformation')

        # send a copy of the build to archives
        shutil.copyfile(working_directory + "/" + output_file, archive_directory + "/" + filename + "_" + time.strftime("%m_%d_%Y_%I_%M") + "." + filetype)
        with open(archive_directory + "/text.txt", "a") as myfile:
            filesize = sizeof_fmt(os.path.getsize(working_directory + "/" + output_file))
            myfile.write("Build Successful," + time.strftime("%m/%d/%Y %I:%M:%S %Z") + "," + filesize + "\n")
            myfile.close()

    except (IOError, ValueError, EnvironmentError):
        with open(archive_directory + "/text.txt", "a") as myfile:
            myfile.write("Build Failed," + time.strftime("%m/%d/%Y %I:%M:%S %Z") + ",Build Faild\n")
            myfile.close()


def sizeof_fmt(num, suffix='B'):
    for unit in ['','K','M','G','T','P','E','Z']:
        if abs(num) < 1024.0:
            return "%3.1f%s%s" % (num, unit, suffix)
        num /= 1024.0
    return "%.1f%s%s" % (num, 'Yi', suffix)

def main():
    transform_data()


if __name__ == '__main__':
    main()
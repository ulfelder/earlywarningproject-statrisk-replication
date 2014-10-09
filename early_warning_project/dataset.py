#!/usr/bin/env python

from abc import ABCMeta, abstractmethod
import ConfigParser
import os

class Dataset(object):


    # Dataset class is used for handling each dataset
    __metaclass__ = ABCMeta

    # Properties for the dataset
    name = ''
    url = ''
    config = ConfigParser.RawConfigParser()
    working_directory = ''
    download_directory = ''
    data_in_directory = ''
    data_out_directory = ''

    def __init__(self):
        main_base = os.path.dirname(os.path.abspath(__file__))
        config_directory = main_base + "/../conf"

        # traverse root configuration directory
        for root, dirs, files in os.walk(config_directory):
            path = root.split('/')
            for file in files:
                self.config.readfp(open(os.path.join(root, file)))

        self.working_directory = self.config.get('files_and_directories', 'working_directory')
        self.download_directory = self.working_directory + "/" + self.config.get('files_and_directories', 'download_directory')
        self.data_in_directory = self.working_directory + "/" + self.config.get('files_and_directories', 'data_in_directory')
        self.data_out_directory = self.working_directory + "/" + self.config.get('files_and_directories', 'data_out_directory')

    @abstractmethod
    def download_data(self):
        # Provide URL for and download the dataset
        pass

    @abstractmethod
    def build_data(self):
        # Provide URL for and download the dataset
        pass

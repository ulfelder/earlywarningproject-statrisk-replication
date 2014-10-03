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

    def __init__(self):
        main_base = os.path.dirname(__file__)
        config_directory = main_base + "/../conf"

        # traverse root configuration directory
        for root, dirs, files in os.walk(config_directory):
            path = root.split('/')
            for file in files:
                self.config.readfp(open(os.path.join(root, file)))

    @abstractmethod
    def download_data(self):
        # Provide URL for and download the dataset
        pass

    @abstractmethod
    def build_data(self):
        # Provide URL for and download the dataset
        pass

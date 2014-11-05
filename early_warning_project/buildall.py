#!/usr/bin/env python

import cleanall
import emailResults
import argparse
import os
import pkgutil
import importlib
import data_transformer

# parse command line arguments
# if -cleanall or -download all are specified, those actions are taken first
parser = argparse.ArgumentParser(description='Build the early_warning_project')
parser.add_argument('-cleanall', action="store_true", default=False, dest='clean',
                   help='remove old files before starting the build')
parser.add_argument('-downloadall', action="store_true", default=False, dest='download',
                   help='download new files before starting the build')
results = parser.parse_args()

if results.clean:
    cleanall.cleanall()
    # if clean all is true, download must be initiated to build
    results.download = True

# debug
print('clean = ' + str(results.clean))
print('download = ' + str(results.download))

def buildall():

    path = os.path.join(os.path.dirname(__file__), "data_builders")
    modules = pkgutil.iter_modules(path=[path])

    for importer, modname, ispkg in modules:
        module = importlib.import_module('data_builders.' + modname)
        print("Imported " + modname)

        # load class from imported module
        loaded_class = getattr(module, modname.title())

        # create an instance of the class
        instance = loaded_class()

        # download datasets if downloadall is specified
        if results.download:
            instance.download_data()

        instance.build_data()

    # build master ewp files
    data_transformer.transform_data()

    # send completed build email
    emailResults.emailResults()

def main():
    buildall()

if __name__ == '__main__':
    main()
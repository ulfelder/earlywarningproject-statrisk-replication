#!/usr/bin/env python

from distutils.core import setup

setup(
    name = "early_warning_project",
    packages = ["early_warning_project"],
    package_data = {"early_warning_project" : ["data_in/*"]},
    version = "0.1",
    description = "Data required to reproduce---and, if desired, to modify or to extend---statistical risk assessments I generate for the Early Warning Project",
    author = "Jay Ulfelder, Doug Gartner",
    author_email = "ulfelder@gmail.com",
    url = "",
    download_url = "",
    keywords = ["encoding", "i18n", "xml"],
    classifiers = [
        "License :: OSI Approved :: GNU Library or Lesser General Public License (LGPL)",
        "Operating System :: OS Independent",
        "Topic :: Software Development :: Libraries :: Python Modules",
        "Topic :: Text Processing :: Linguistic",
        ],
    long_description = "",
)

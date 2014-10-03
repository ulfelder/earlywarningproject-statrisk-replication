#!/usr/bin/python

# change above line to point to local 
# python executable

import urllib, urlparse, string, time

if __name__ == "__main__":
    config = {}
    execfile("data.cfg", config)
    # python 3: exec(open("data.cfg").read(), config)

    print config["value1"]
    print config["value5"]

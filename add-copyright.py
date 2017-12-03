#! /usr/bin/env python
# coding: utf-8

"""This script reads all .java files from a directory tree and determines if
it's necessary to write a Copyright Notice in the beginning of each Java file.
It checks that by searching for the word "copyright" in the first few lines.
Warning: use it at your own risk. Better have a source control to rollback if
         necessary.

Thanks to: https://gist.github.com/rodrigosetti/4734552
"""

import fnmatch
import sys
import os

#: The copyright message to be included in the beginning of files if the word
#: "copyright" is not present in the first lines
COPYRIGHT_MESSAGE = "/*\n * Copyright 2013 My Company inc.\n */\n"

#: Number of lines to look for the word "copyright" in the beginning of file,
#: to decide whether or not the copyright notice is presented
LINES_TO_LOOK = 10


def locate(pattern, root=os.curdir):
    '''Locate all files matching supplied filename pattern in and below
    supplied root directory.'''
    for path, dirs, files in os.walk(os.path.abspath(root)):
        for filename in fnmatch.filter(files, pattern):
            yield os.path.join(path, filename)

if __name__ == "__main__":

    # locate files in current directory or one specified in command line arg
    root_dir = sys.argv[1] if len(sys.argv) == 2 else os.curdir

    for filename in locate("*.java", root_dir):
        with open(filename) as f:
            all_lines = f.readlines()

        # check Copyright notice in the starting of file
        file_header = ''.join(all_lines[:LINES_TO_LOOK])

        if not 'copyright' in file_header.lower():
            print "Adding copyright notice:", filename
            with open(filename, 'w') as f:
                f.write(COPYRIGHT_MESSAGE)
                for line in all_lines:
                    f.write(line)

print "Please compile your project to make sure I haven't break anything."

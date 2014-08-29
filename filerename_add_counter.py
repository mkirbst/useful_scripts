#!/usr/bin/python
import os, os.path

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'

dir = "."
i = 0
filecount = 0
zeros = 1

#get filecount in directory for trailing zeros
files = os.listdir(dir)
for file in files:
	filecount += 1	

print "DEBUG: ",filecount, " files counted"
while filecount > 10:
	zeros += 1
	filecount /= 10

print "DEBUG: ",zeros," trailing zeros needed"


files = sorted(os.listdir(dir))
i = 0
for file in files:
	i+=1
	filenumbered = str(i).zfill(zeros)+"_"+file;
	print file," -> ",filenumbered

print bcolors.FAIL + "\n\nTHIS WAS THE DRY RUN - PRESS [CTRL]+[c] TO ABORT OR ANY OTHER KEY TO START RENAMING\n\n" + bcolors.ENDC
raw_input()

files = sorted(os.listdir(dir))
i = 0
for file in files:
	i+=1
	filenumbered = str(i).zfill(zeros)+"_"+file;
	os.rename(file, filenumbered)
	print file," -> ",filenumbered


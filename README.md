# Bash-Helper-Scripts
This repository contains Bash helper scripts to help in data wrangling.  Sometimes Bash is just the tool to get the job done.

### reshuffle.sh
Contains functions to randomly reshuffle lines of data in a csv file.  This task is easily done in python and pandas for small dataset, but very slow for large data sets.  Bash functions are able to handle this quickly.  This script implements additional functions to deal with a row header and also allows setting a random seed for reproducible shuffling.

### reshuffle_osx.sh
Same functionality as reshuffle.sh, but modified for Macs.  On Macs, the terminal does not include the shuf function.  This function can be obtained using homebrew to install coreutils.  It is called gshuf.

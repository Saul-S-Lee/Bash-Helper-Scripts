#!/bin/bash
# Bash script to assist in data wrangling
# Updated 2018-11
# Saul Lee

reshuffle()
{
	# This function randomly reshuffles lines of data in a csv file
	# it is assumed that the first line is the header, which is extracted
	# the data is then shuffled using shuf, change the random seed to alter shuffling order
	# expects the filename as the first argument
	# expects the optional random seed as the second argument, if none is given, defaults to 42
	
	# check is a random seed is specified, if not set to default value
	if [ "$2" != "" ]; then
		echo "Setting random seed to "$2
		random_seed=$2
	else
		echo "No random seed specified, setting to default value of 42"
		random_seed=42
	fi
	
	echo "Extracting Header"
	head $1 -n 1 > "header_"$1
	
	echo "Copying data to temp file"
	tail $1 -n +2 > temp_no_header.csv
	
	# shuffle the data.  uses the function get_seeded_random to ensure repeatable reordering
	# especially if the data is contained in multiple files.
	echo "Shuffling data"
	shuf temp_no_header.csv --random-source=<(get_seeded_random $random_seed) > temp_shuffled.csv

	echo "Reconstructing shuffled data"
	cat "header_"$1 temp_shuffled.csv > "shuffled_"$1

	echo "Removing temp files"
	rm temp_no_header.csv
	rm temp_shuffled.csv

	echo "Done processing "$1
}

get_seeded_random()
{
	# this is taken from https://www.gnu.org/software/coreutils/manual/html_node/Random-sources.html#Random-sources
	# allows the use of a random seed number to generate reproducible random numbers used in --random-source
	# expects a number to serve as the random seed in the first argument
	
  seed="$1"
  openssl enc -aes-256-ctr -pass pass:"$seed" -nosalt \
    </dev/zero 2>/dev/null
}


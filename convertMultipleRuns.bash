#!/bin/bash

# converts all of the runs with numbers ranging from argument 1 to 2
# argument 3 sepecifies the midas2sfu map to use

MAP=$3

for ((RUN=$1;RUN<=$2;RUN++))
do
   SUBRUNS=$(ls -1 midas/run"$RUN"*.mid | wc -l)
		echo "$SUBRUNS subrun(s) detected."

		#make list of subruns (special command needed to avoid listing color codes alongside filenames on midtig02) 
		for file in $(ls -f midas/run"$RUN"*); do echo $file; done > runs.list


		#convert the run/subruns(s) from midas to sfu format, if needed
		if [ $(ls -1 sfu/run"$RUN".sfu | wc -l) -gt 0 ]; then
				echo ".sfu file already exists for this run."
				echo "Event data from run "$RUN" has already been reconstructed."
				echo "Will use this data."
		else
				echo "Reconstructing events from run "$RUN"..."
				midas2sfu runs.list sfu/run"$RUN".sfu $MAP
		fi

		#clean up
		rm runs.list
done

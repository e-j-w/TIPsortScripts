#!/bin/bash

# A script for conversion of multiple midas files into sfu files
# using the TIPsort codes.

#the path to the directory containing the experiment's midas files
MIDAS_PATH=`dirname $0`/midas

#the path to the directory where the converted sfu files will be placed
SFU_PATH=`dirname $0`/sfu

#the path to the map being used
MAP=`dirname $0`/maps/November2013.map

for RUN in `seq $1 $2`;
do
    
    if [ -f $MIDAS_PATH/run$RUN.mid ]
    then 
	echo "File run$RUN.mid exists."
	if [ -f $SFU_PATH/run$RUN.sfu ]
	then 
	    echo "File run$RUN.sfu exists. No need to convert."
	else 
	    echo "File run$RUN.sfu does not exist."
	    echo "Creating run$RUN.sfu..."
	    #echo "Unzipping run$RUN.mid.gz..."
	    #gunzip $MIDAS_PATH/run$RUN.mid.gz
	    echo "Converting to sfu format..."
	    midas2sfu $MIDAS_PATH/run$RUN.mid $SFU_PATH/run$RUN.sfu $MAP
	    #echo "Conversion complete, zipping midas file..."
	    #gzip $MIDAS_PATH/run$RUN.mid
	    echo "Conversion of run$RUN.sfu COMPLETE"
	fi
	
    else 
	echo "File run$RUN.mid does not exist."
    fi
    
done



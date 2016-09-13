#!/bin/bash

# A script for conversion of multiple midas files into sfu files
# using the TIPsort codes.
# Arguments 1 and 2: run # range
# Arguments 3 and 4: subrun # range

#the path to the directory containing the experiment's midas files
MIDAS_PATH=`dirname $0`/midas

#the path to the directory where the converted sfu files will be placed
SFU_PATH=`dirname $0`/sfu

#the path to the map being used
MAP=`dirname $0`/maps/November2013.map

for RUN in `seq $1 $2`;
do
    for SUBRUN in `seq $3 $4`;
    do
    
    if [ $SUBRUN -lt 10 ]; then
        RUNSR=""$RUN"_00"$SUBRUN""
    else
        RUNSR=""$RUN"_0"$SUBRUN""
    fi
    
    if [ -f $MIDAS_PATH/run$RUNSR.mid ]
    then 
	echo "File run$RUNSR.mid exists."
	if [ -f $SFU_PATH/run$RUNSR.sfu ]
	then 
	    echo "File run$RUNSR.sfu exists. No need to convert."
	else 
	    echo "File run$RUNSR.sfu does not exist."
	    echo "Creating run$RUNSR.sfu..."
	    #echo "Unzipping run$RUNSR.mid.gz..."
	    #gunzip $MIDAS_PATH/run$RUNSR.mid.gz
	    echo "Converting to sfu format..."
	    midas2sfu $MIDAS_PATH/run$RUNSR.mid $SFU_PATH/run$RUNSR.sfu $MAP
	    #echo "Conversion complete, zipping midas file..."
	    #gzip $MIDAS_PATH/run$RUNSR.mid
	    echo "Conversion of run$RUNSR.sfu COMPLETE"
	fi
	
    else 
	echo "File run$RUNSR.mid does not exist."
    fi
    
    done
    
done



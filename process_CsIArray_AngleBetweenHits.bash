#!/bin/bash

# Script to generate the CsI-CsI timing spectrum for a given run.
# Argument 1 is the run number.

#copy master files
mkdir MasterFiles
cp GenericMasterFiles/master26563_CsIArrayTTCal MasterFiles/master"$1"_CsIArrayTTCal

#replace master file strings with appropriate values
sed -i 's/26563/'"$1"'/g'  MasterFiles/master"$1"_CsIArrayTTCal


#make the Tigress/BGO hit pattern ROOT file
mkdir CsIArray_AngleBetweenHits
CsIArray_AngleBetweenHits MasterFiles/master"$1"_CsIArrayTTCal
#mv CsIArray_TTCal.root CsIArray_TTCal/run"$1"_CsIArray_TTCal.root

#remove intermediate data files to save disk space and cleanup
echo ""
echo "Cleaning up..."
rm -rf MasterFiles/

#echo ""
#echo "Done making the CsI-CsI timing ROOT file: CsIArray_TTCal/run"$1"_CsIArray_TTCal.root"

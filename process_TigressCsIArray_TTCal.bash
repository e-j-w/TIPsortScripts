#!/bin/bash

# Script to generate the Tigress/CsI timing plot for a given run.
# Argument 1 is the run number.

#copy master files
mkdir MasterFiles
cp GenericMasterFiles/master26563_TigressCsIArrayTTCal MasterFiles/master"$1"_TigressCsIArrayTTCal

#replace master file strings with appropriate values
sed -i 's/26563/'"$1"'/g'  MasterFiles/master"$1"_TigressCsIArrayTTCal


#make the Tigress/CsI timing ROOT file
mkdir TigressCsIArray_TTCal
TigressCsIArray_TTCal MasterFiles/master"$1"_TigressCsIArrayTTCal
#mv TigressBGO_TTHP.root TigressCsIArray_TTCal/run"$1"_TigressCsIArray_TTCal.root

#remove intermediate data files to save disk space and cleanup
echo ""
echo "Cleaning up..."
rm -rf MasterFiles/

echo ""
echo "Done making the Tigress/CsI timing ROOT file: TigressCsIArray_TTCal/run"$1"_TigressCsIArray_TTCal.root"

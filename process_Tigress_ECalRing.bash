#!/bin/bash

# Script to generate the Tigress ring gamma ray energy spectrum for a given run.
# Argument 1 is the run number.

#copy master files
mkdir MasterFiles
cp GenericMasterFiles/master26563_Tigress_ECalRing MasterFiles/master"$1"_Tigress_ECalRing

#replace master file strings with appropriate values
sed -i 's/26563/'"$1"'/g'  MasterFiles/master"$1"_Tigress_ECalRing


#make the Tigress/BGO hit pattern ROOT file
mkdir Tigress_ECalRing
Tigress_ECalRing MasterFiles/master"$1"_Tigress_ECalRing
mv Ring_ECal.mca Tigress_ECalRing/run"$1"_Tigress_ECalRing.mca

#remove intermediate data files to save disk space and cleanup
echo ""
echo "Cleaning up..."
rm -rf MasterFiles/

echo ""
echo "Done making the Tigress ring gamma ray energy spectrum: Tigress_ECalRing/run"$1"_Tigress_ECalRing.mca"

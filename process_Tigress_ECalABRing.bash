#!/bin/bash

# Script to generate the Tigress addback ring gamma ray energy spectrum for a given run.
# Argument 1 is the run number.

#copy master files
mkdir MasterFiles
cp GenericMasterFiles/master26563_Tigress_ECalABRing MasterFiles/master"$1"_Tigress_ECalABRing

#replace master file strings with appropriate values
sed -i 's/26563/'"$1"'/g'  MasterFiles/master"$1"_Tigress_ECalABRing


#do separation on trigbit 69 (Tigress+CsI+RF)
mkdir TBsep
#separate_TrigBits sfu/run"$1".sfu TBsep/run"$1"_TBsep.sfu 69
cp sfu/run"$1".sfu TBsep/run"$1"_TBsep.sfu

#make the Tigress/BGO hit pattern ROOT file
mkdir Tigress_ECalABRing
Tigress_ECalABRing MasterFiles/master"$1"_Tigress_ECalABRing
mv Ring_ECalAB.mca Tigress_ECalABRing/run"$1"_Tigress_ECalABRing.mca

#remove intermediate data files to save disk space and cleanup
echo ""
echo "Cleaning up..."
rm -rf TBsep/
rm -rf MasterFiles/

echo ""
echo "Done making the Tigress addback ring gamma ray energy spectrum: Tigress_ECalABRing/run"$1"_Tigress_ECalABRing.mca"

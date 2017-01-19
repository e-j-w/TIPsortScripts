#!/bin/bash

# Script to generate the Tigress addback ring gamma ray energy spectrum for a given run.
# Spectra are gated according to
# Argument 1 is the run number.
# Argument 2 is suppLow.
# Argument 3 is suppHigh.

#copy master files
mkdir MasterFiles
cp GenericMasterFiles/master26563_Tigress_ECalABRing MasterFiles/master"$1"_Tigress_ECalABRing

#replace master file strings with appropriate values
sed -i 's/26563/'"$1"'/g'  MasterFiles/master"$1"_Tigress_ECalABRing
sed -i 's#sfu/run'"$1"'.sfu#CsIArray_PID_ERsep0p2a/run'"$1"'_PID_ERsep.sfu#g'  MasterFiles/master"$1"_Tigress_ECalABRing

#make the 0p2a spectrum
mkdir Tigress_ECalABSuppRingEGated_fromPIDsepdata0p2a
Tigress_ECalABSuppRingEGated MasterFiles/master"$1"_Tigress_ECalABRing $2 $3
mv Ring_ECalABSuppEGated.mca Tigress_ECalABSuppRingEGated_fromPIDsepdata0p2a/run"$1"_Tigress_ECalABSuppRingEGated_fromPIDsepdata.mca

#replace master file strings with appropriate values
sed -i 's#CsIArray_PID_ERsep0p2a/run'"$1"'_PID_ERsep.sfu#CsIArray_PID_ERsep2p0a/run'"$1"'_PID_ERsep.sfu#g'  MasterFiles/master"$1"_Tigress_ECalABRing

#make the 2p0a spectrum
mkdir Tigress_ECalABSuppRingEGated_fromPIDsepdata2p0a
Tigress_ECalABSuppRingEGated MasterFiles/master"$1"_Tigress_ECalABRing $2 $3
mv Ring_ECalABSuppEGated.mca Tigress_ECalABSuppRingEGated_fromPIDsepdata2p0a/run"$1"_Tigress_ECalABSuppRingEGated_fromPIDsepdata.mca



#remove intermediate data files to save disk space and cleanup
echo ""
echo "Cleaning up..."
rm -rf MasterFiles/

echo ""
echo "Done making the energy gated Tigress addback ring gamma ray energy spectrum from PID separated data: Tigress_ECalABRingEGated_fromPIDsepdata0p2a/run"$1"_Tigress_ECalABRingEGated_fromPIDsepdata.mca, Tigress_ECalABRingEGated_fromPIDsepdata2p0a/run"$1"_Tigress_ECalABRingEGated_fromPIDsepdata.mca"

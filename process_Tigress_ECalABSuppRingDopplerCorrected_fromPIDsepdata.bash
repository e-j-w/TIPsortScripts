#!/bin/bash

# Script to generate the Tigress addback ring gamma ray energy spectrum for a given run.
# Argument 1 is the run number.
# Argument 2 is suppLow.
# Argument 3 is suppHigh.
# Argument 4 is the ring doppler shift file

#copy master files
mkdir MasterFiles
cp GenericMasterFiles/master26563_Tigress_ECalABRing MasterFiles/master"$1"_Tigress_ECalABRing

#replace master file strings with appropriate values
sed -i 's/26563/'"$1"'/g'  MasterFiles/master"$1"_Tigress_ECalABRing
sed -i 's#sfu/run'"$1"'.sfu#CsIArray_PID_ERsep0p1a/run'"$1"'_PID_ERsep.sfu#g'  MasterFiles/master"$1"_Tigress_ECalABRing

#make the 0p1a spectrum
mkdir Tigress_ECalABSuppRingDopplerCorrected_fromPIDsepdata0p1a
Tigress_ECalABSuppRingDopplerCorrected MasterFiles/master"$1"_Tigress_ECalABRing $2 $3 $4
mv Ring_ECalABSupp.mca Tigress_ECalABSuppRingDopplerCorrected_fromPIDsepdata0p1a/run"$1"_Tigress_ECalABSuppRing_fromPIDsepdata.mca

#replace master file strings with appropriate values
sed -i 's#CsIArray_PID_ERsep0p1a/run'"$1"'_PID_ERsep.sfu#CsIArray_PID_ERsep0p2a/run'"$1"'_PID_ERsep.sfu#g'  MasterFiles/master"$1"_Tigress_ECalABRing

#make the 0p2a spectrum
mkdir Tigress_ECalABSuppRingDopplerCorrected_fromPIDsepdata0p2a
Tigress_ECalABSuppRingDopplerCorrected MasterFiles/master"$1"_Tigress_ECalABRing $2 $3 $4
mv Ring_ECalABSupp.mca Tigress_ECalABSuppRingDopplerCorrected_fromPIDsepdata0p2a/run"$1"_Tigress_ECalABSuppRing_fromPIDsepdata.mca

#replace master file strings with appropriate values
sed -i 's#CsIArray_PID_ERsep0p2a/run'"$1"'_PID_ERsep.sfu#CsIArray_PID_ERsep0p3a/run'"$1"'_PID_ERsep.sfu#g'  MasterFiles/master"$1"_Tigress_ECalABRing

#make the 0p3a spectrum
mkdir Tigress_ECalABSuppRingDopplerCorrected_fromPIDsepdata0p3a
Tigress_ECalABSuppRingDopplerCorrected MasterFiles/master"$1"_Tigress_ECalABRing $2 $3 $4
mv Ring_ECalABSupp.mca Tigress_ECalABSuppRingDopplerCorrected_fromPIDsepdata0p3a/run"$1"_Tigress_ECalABSuppRing_fromPIDsepdata.mca

#replace master file strings with appropriate values
sed -i 's#CsIArray_PID_ERsep0p3a/run'"$1"'_PID_ERsep.sfu#CsIArray_PID_ERsep1p0a/run'"$1"'_PID_ERsep.sfu#g'  MasterFiles/master"$1"_Tigress_ECalABRing

#make the 1p0a spectrum
mkdir Tigress_ECalABSuppRingDopplerCorrected_fromPIDsepdata1p0a
Tigress_ECalABSuppRingDopplerCorrected MasterFiles/master"$1"_Tigress_ECalABRing $2 $3 $4
mv Ring_ECalABSupp.mca Tigress_ECalABSuppRingDopplerCorrected_fromPIDsepdata1p0a/run"$1"_Tigress_ECalABSuppRing_fromPIDsepdata.mca

#replace master file strings with appropriate values
sed -i 's#CsIArray_PID_ERsep1p0a/run'"$1"'_PID_ERsep.sfu#CsIArray_PID_ERsep2p0a/run'"$1"'_PID_ERsep.sfu#g'  MasterFiles/master"$1"_Tigress_ECalABRing

#make the 2p0a spectrum
mkdir Tigress_ECalABSuppRingDopplerCorrected_fromPIDsepdata2p0a
Tigress_ECalABSuppRingDopplerCorrected MasterFiles/master"$1"_Tigress_ECalABRing $2 $3 $4
mv Ring_ECalABSupp.mca Tigress_ECalABSuppRingDopplerCorrected_fromPIDsepdata2p0a/run"$1"_Tigress_ECalABSuppRing_fromPIDsepdata.mca

#replace master file strings with appropriate values
sed -i 's#CsIArray_PID_ERsep2p0a/run'"$1"'_PID_ERsep.sfu#CsIArray_PID_ERsep3p0a/run'"$1"'_PID_ERsep.sfu#g'  MasterFiles/master"$1"_Tigress_ECalABRing

#make the 3p0a spectrum
mkdir Tigress_ECalABSuppRingDopplerCorrected_fromPIDsepdata3p0a
Tigress_ECalABSuppRingDopplerCorrected MasterFiles/master"$1"_Tigress_ECalABRing $2 $3 $4
mv Ring_ECalABSupp.mca Tigress_ECalABSuppRingDopplerCorrected_fromPIDsepdata3p0a/run"$1"_Tigress_ECalABSuppRing_fromPIDsepdata.mca

#replace master file strings with appropriate values
sed -i 's#CsIArray_PID_ERsep3p0a/run'"$1"'_PID_ERsep.sfu#CsIArray_PID_ERsep4p0a/run'"$1"'_PID_ERsep.sfu#g'  MasterFiles/master"$1"_Tigress_ECalABRing

#make the 4p0a spectrum
mkdir Tigress_ECalABSuppRingDopplerCorrected_fromPIDsepdata4p0a
Tigress_ECalABSuppRingDopplerCorrected MasterFiles/master"$1"_Tigress_ECalABRing $2 $3 $4
mv Ring_ECalABSupp.mca Tigress_ECalABSuppRingDopplerCorrected_fromPIDsepdata4p0a/run"$1"_Tigress_ECalABSuppRing_fromPIDsepdata.mca

#replace master file strings with appropriate values
sed -i 's#CsIArray_PID_ERsep4p0a/run'"$1"'_PID_ERsep.sfu#CsIArray_PID_ERsep1p1a/run'"$1"'_PID_ERsep.sfu#g'  MasterFiles/master"$1"_Tigress_ECalABRing

#make the 1p1a spectrum
mkdir Tigress_ECalABSuppRingDopplerCorrected_fromPIDsepdata1p1a
Tigress_ECalABSuppRingDopplerCorrected MasterFiles/master"$1"_Tigress_ECalABRing $2 $3 $4
mv Ring_ECalABSupp.mca Tigress_ECalABSuppRingDopplerCorrected_fromPIDsepdata1p1a/run"$1"_Tigress_ECalABSuppRing_fromPIDsepdata.mca

#replace master file strings with appropriate values
sed -i 's#CsIArray_PID_ERsep1p1a/run'"$1"'_PID_ERsep.sfu#CsIArray_PID_ERsep2p1a/run'"$1"'_PID_ERsep.sfu#g'  MasterFiles/master"$1"_Tigress_ECalABRing

#make the 2p1a spectrum
mkdir Tigress_ECalABSuppRingDopplerCorrected_fromPIDsepdata2p1a
Tigress_ECalABSuppRingDopplerCorrected MasterFiles/master"$1"_Tigress_ECalABRing $2 $3 $4
mv Ring_ECalABSupp.mca Tigress_ECalABSuppRingDopplerCorrected_fromPIDsepdata2p1a/run"$1"_Tigress_ECalABSuppRing_fromPIDsepdata.mca

#replace master file strings with appropriate values
sed -i 's#CsIArray_PID_ERsep2p1a/run'"$1"'_PID_ERsep.sfu#CsIArray_PID_ERsep1p2a/run'"$1"'_PID_ERsep.sfu#g'  MasterFiles/master"$1"_Tigress_ECalABRing

#make the 1p2a spectrum
mkdir Tigress_ECalABSuppRingDopplerCorrected_fromPIDsepdata1p2a
Tigress_ECalABSuppRingDopplerCorrected MasterFiles/master"$1"_Tigress_ECalABRing $2 $3 $4
mv Ring_ECalABSupp.mca Tigress_ECalABSuppRingDopplerCorrected_fromPIDsepdata1p2a/run"$1"_Tigress_ECalABSuppRing_fromPIDsepdata.mca




#remove intermediate data files to save disk space and cleanup
echo ""
echo "Cleaning up..."
rm -rf MasterFiles/

echo ""
echo "Done making the Tigress addback ring gamma ray energy spectrum from PID separated data: Tigress_ECalABRingDopplerCorrected_fromPIDsepdata0p2a/run"$1"_Tigress_ECalABRing_fromPIDsepdata.mca, Tigress_ECalABRingDopplerCorrected_fromPIDsepdata2p0a/run"$1"_Tigress_ECalABRing_fromPIDsepdata.mca"

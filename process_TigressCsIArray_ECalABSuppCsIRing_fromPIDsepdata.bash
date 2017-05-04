#!/bin/bash

# Script to generate the Tigress addback ring gamma ray energy spectrum for a given run.
# Argument 1 is the run number.
# Argument 2 is suppLow.
# Argument 3 is suppHigh.

#copy master files
mkdir MasterFiles
cp GenericMasterFiles/master26563_Tigress_ECalABRing MasterFiles/master"$1"_Tigress_ECalABRing

#replace master file strings with appropriate values
sed -i 's/26563/'"$1"'/g'  MasterFiles/master"$1"_Tigress_ECalABRing
sed -i 's#sfu/run'"$1"'.sfu#CsIArray_PID_ERsep0p1a/run'"$1"'_PID_ERsep.sfu#g'  MasterFiles/master"$1"_Tigress_ECalABRing

#make the 0p1a spectrum
mkdir TigressCsIArray_ECalABSuppCsIRing_fromPIDsepdata0p1a
TigressCsIArray_ECalABSuppCsIRing MasterFiles/master"$1"_Tigress_ECalABRing $2 $3
mv CsIRing_ECalABSupp.mca TigressCsIArray_ECalABSuppCsIRing_fromPIDsepdata0p1a/run"$1"_TigressCsIArray_ECalABSuppCsIRing_fromPIDsepdata.mca

#replace master file strings with appropriate values
sed -i 's#CsIArray_PID_ERsep0p1a/run'"$1"'_PID_ERsep.sfu#CsIArray_PID_ERsep0p2a/run'"$1"'_PID_ERsep.sfu#g'  MasterFiles/master"$1"_Tigress_ECalABRing

#make the 0p2a spectrum
mkdir TigressCsIArray_ECalABSuppCsIRing_fromPIDsepdata0p2a
TigressCsIArray_ECalABSuppCsIRing MasterFiles/master"$1"_Tigress_ECalABRing $2 $3
mv CsIRing_ECalABSupp.mca TigressCsIArray_ECalABSuppCsIRing_fromPIDsepdata0p2a/run"$1"_TigressCsIArray_ECalABSuppCsIRing_fromPIDsepdata.mca

#replace master file strings with appropriate values
sed -i 's#CsIArray_PID_ERsep0p2a/run'"$1"'_PID_ERsep.sfu#CsIArray_PID_ERsep0p3a/run'"$1"'_PID_ERsep.sfu#g'  MasterFiles/master"$1"_Tigress_ECalABRing

#make the 0p3a spectrum
mkdir TigressCsIArray_ECalABSuppCsIRing_fromPIDsepdata0p3a
TigressCsIArray_ECalABSuppCsIRing MasterFiles/master"$1"_Tigress_ECalABRing $2 $3
mv CsIRing_ECalABSupp.mca TigressCsIArray_ECalABSuppCsIRing_fromPIDsepdata0p3a/run"$1"_TigressCsIArray_ECalABSuppCsIRing_fromPIDsepdata.mca

#replace master file strings with appropriate values
sed -i 's#CsIArray_PID_ERsep0p3a/run'"$1"'_PID_ERsep.sfu#CsIArray_PID_ERsep1p0a/run'"$1"'_PID_ERsep.sfu#g'  MasterFiles/master"$1"_Tigress_ECalABRing

#make the 1p0a spectrum
mkdir TigressCsIArray_ECalABSuppCsIRing_fromPIDsepdata1p0a
TigressCsIArray_ECalABSuppCsIRing MasterFiles/master"$1"_Tigress_ECalABRing $2 $3
mv CsIRing_ECalABSupp.mca TigressCsIArray_ECalABSuppCsIRing_fromPIDsepdata1p0a/run"$1"_TigressCsIArray_ECalABSuppCsIRing_fromPIDsepdata.mca

#replace master file strings with appropriate values
sed -i 's#CsIArray_PID_ERsep1p0a/run'"$1"'_PID_ERsep.sfu#CsIArray_PID_ERsep2p0a/run'"$1"'_PID_ERsep.sfu#g'  MasterFiles/master"$1"_Tigress_ECalABRing

#make the 2p0a spectrum
mkdir TigressCsIArray_ECalABSuppCsIRing_fromPIDsepdata2p0a
TigressCsIArray_ECalABSuppCsIRing MasterFiles/master"$1"_Tigress_ECalABRing $2 $3
mv CsIRing_ECalABSupp.mca TigressCsIArray_ECalABSuppCsIRing_fromPIDsepdata2p0a/run"$1"_TigressCsIArray_ECalABSuppCsIRing_fromPIDsepdata.mca

#replace master file strings with appropriate values
sed -i 's#CsIArray_PID_ERsep2p0a/run'"$1"'_PID_ERsep.sfu#CsIArray_PID_ERsep4p0a/run'"$1"'_PID_ERsep.sfu#g'  MasterFiles/master"$1"_Tigress_ECalABRing

#make the 4p0a spectrum
mkdir TigressCsIArray_ECalABSuppCsIRing_fromPIDsepdata4p0a
TigressCsIArray_ECalABSuppCsIRing MasterFiles/master"$1"_Tigress_ECalABRing $2 $3
mv CsIRing_ECalABSupp.mca TigressCsIArray_ECalABSuppCsIRing_fromPIDsepdata4p0a/run"$1"_TigressCsIArray_ECalABSuppCsIRing_fromPIDsepdata.mca

#replace master file strings with appropriate values
sed -i 's#CsIArray_PID_ERsep4p0a/run'"$1"'_PID_ERsep.sfu#CsIArray_PID_ERsep1p1a/run'"$1"'_PID_ERsep.sfu#g'  MasterFiles/master"$1"_Tigress_ECalABRing

#make the 1p1a spectrum
mkdir TigressCsIArray_ECalABSuppCsIRing_fromPIDsepdata1p1a
TigressCsIArray_ECalABSuppCsIRing MasterFiles/master"$1"_Tigress_ECalABRing $2 $3
mv CsIRing_ECalABSupp.mca TigressCsIArray_ECalABSuppCsIRing_fromPIDsepdata1p1a/run"$1"_TigressCsIArray_ECalABSuppCsIRing_fromPIDsepdata.mca

#replace master file strings with appropriate values
sed -i 's#CsIArray_PID_ERsep1p1a/run'"$1"'_PID_ERsep.sfu#CsIArray_PID_ERsep2p1a/run'"$1"'_PID_ERsep.sfu#g'  MasterFiles/master"$1"_Tigress_ECalABRing

#make the 2p1a spectrum
mkdir TigressCsIArray_ECalABSuppCsIRing_fromPIDsepdata2p1a
TigressCsIArray_ECalABSuppCsIRing MasterFiles/master"$1"_Tigress_ECalABRing $2 $3
mv CsIRing_ECalABSupp.mca TigressCsIArray_ECalABSuppCsIRing_fromPIDsepdata2p1a/run"$1"_TigressCsIArray_ECalABSuppCsIRing_fromPIDsepdata.mca

#replace master file strings with appropriate values
sed -i 's#CsIArray_PID_ERsep2p1a/run'"$1"'_PID_ERsep.sfu#CsIArray_PID_ERsep1p2a/run'"$1"'_PID_ERsep.sfu#g'  MasterFiles/master"$1"_Tigress_ECalABRing

#make the 1p2a spectrum
mkdir TigressCsIArray_ECalABSuppCsIRing_fromPIDsepdata1p2a
TigressCsIArray_ECalABSuppCsIRing MasterFiles/master"$1"_Tigress_ECalABRing $2 $3
mv CsIRing_ECalABSupp.mca TigressCsIArray_ECalABSuppCsIRing_fromPIDsepdata1p2a/run"$1"_TigressCsIArray_ECalABSuppCsIRing_fromPIDsepdata.mca



#remove intermediate data files to save disk space and cleanup
echo ""
echo "Cleaning up..."
rm -rf MasterFiles/

echo ""
echo "Done making the Tigress addback ring gamma ray energy spectrum from PID separated data: Tigress_ECalABRing_fromPIDsepdata0p2a/run"$1"_TigressCsIArray_ECalABSuppCsIRing_fromPIDsepdata.mca, Tigress_ECalABRing_fromPIDsepdata2p0a/run"$1"_TigressCsIArray_ECalABSuppCsIRing_fromPIDsepdata.mca"

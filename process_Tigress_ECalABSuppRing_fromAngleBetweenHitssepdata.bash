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
sed -i 's#sfu/run'"$1"'.sfu#CsIArray_AngleBetweenHitssep_fromPIDsepdata0p1a/run'"$1"'_AngleBetweenHitssep.sfu#g'  MasterFiles/master"$1"_Tigress_ECalABRing

mkdir Tigress_ECalABSuppRing_fromAngleBetweenHitssepdata0p1a
mkdir Tigress_ECalABSuppRing_fromAngleBetweenHitssepdata0p2a
mkdir Tigress_ECalABSuppRing_fromAngleBetweenHitssepdata0p3a
mkdir Tigress_ECalABSuppRing_fromAngleBetweenHitssepdata2p0a

#make the 0p1a spectrum
Tigress_ECalABSuppRing MasterFiles/master"$1"_Tigress_ECalABRing $2 $3
mv Ring_ECalABSupp.mca Tigress_ECalABSuppRing_fromAngleBetweenHitssepdata0p1a/run"$1"_Tigress_ECalABSuppRing_fromAngleBetweenHitssepdata.mca

#replace master file strings with appropriate values
sed -i 's#CsIArray_AngleBetweenHitssep_fromPIDsepdata0p1a/run'"$1"'_AngleBetweenHitssep.sfu#CsIArray_AngleBetweenHitssep_fromPIDsepdata0p2a/run'"$1"'_AngleBetweenHitssep.sfu#g'  MasterFiles/master"$1"_Tigress_ECalABRing

#make the 0p2a spectrum
Tigress_ECalABSuppRing MasterFiles/master"$1"_Tigress_ECalABRing $2 $3
mv Ring_ECalABSupp.mca Tigress_ECalABSuppRing_fromAngleBetweenHitssepdata0p2a/run"$1"_Tigress_ECalABSuppRing_fromAngleBetweenHitssepdata.mca

#replace master file strings with appropriate values
sed -i 's#CsIArray_AngleBetweenHitssep_fromPIDsepdata0p2a/run'"$1"'_AngleBetweenHitssep.sfu#CsIArray_AngleBetweenHitssep_fromPIDsepdata0p3a/run'"$1"'_AngleBetweenHitssep.sfu#g'  MasterFiles/master"$1"_Tigress_ECalABRing

#make the 0p3a spectrum
Tigress_ECalABSuppRing MasterFiles/master"$1"_Tigress_ECalABRing $2 $3
mv Ring_ECalABSupp.mca Tigress_ECalABSuppRing_fromAngleBetweenHitssepdata0p3a/run"$1"_Tigress_ECalABSuppRing_fromAngleBetweenHitssepdata.mca

sed -i 's#CsIArray_AngleBetweenHitssep_fromPIDsepdata0p3a/run'"$1"'_AngleBetweenHitssep.sfu#CsIArray_AngleBetweenHitssep_fromPIDsepdata2p0a/run'"$1"'_AngleBetweenHitssep.sfu#g'  MasterFiles/master"$1"_Tigress_ECalABRing

#make the 2p0a spectrum
Tigress_ECalABSuppRing MasterFiles/master"$1"_Tigress_ECalABRing $2 $3
mv Ring_ECalABSupp.mca Tigress_ECalABSuppRing_fromAngleBetweenHitssepdata2p0a/run"$1"_Tigress_ECalABSuppRing_fromAngleBetweenHitssepdata.mca



#remove intermediate data files to save disk space and cleanup
echo ""
echo "Cleaning up..."
rm -rf MasterFiles/

echo ""
echo "Done making the Tigress addback ring gamma ray energy spectrum from CsI array angle separated data: Tigress_ECalABSuppRing_fromAngleBetweenHitssepdata0p1a/run"$1"_Tigress_ECalABSuppRing_fromAngleBetweenHitssepdata.mca, etc"

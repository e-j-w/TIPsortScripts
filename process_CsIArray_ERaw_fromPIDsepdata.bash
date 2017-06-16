#!/bin/bash

# Script to generate the CsI raw energy spectrum from PID separated data.
# Argument 1 is the run number.

#copy master files
mkdir MasterFiles
cp GenericMasterFiles/master26563_CsIArray_PID_ER MasterFiles/master"$1"_CsIArray_PID_ER

#replace master file strings with appropriate values
sed -i 's/26563/'"$1"'/g'  MasterFiles/master"$1"_CsIArray_PID_ER

#make the CsIArray raw energy spectrum files
mkdir CsIArray_ERaw_fromPIDsepdata0p1a
CsIArray_ERaw CsIArray_PID_ERsep0p1a/run"$1"_PID_ERsep.sfu
mv CsIArray_ERaw.mca CsIArray_ERaw_fromPIDsepdata0p1a/run"$1"_CsIArray_ERaw_fromPIDsepdata.mca

mkdir CsIArray_ERaw_fromPIDsepdata0p2a
CsIArray_ERaw CsIArray_PID_ERsep0p2a/run"$1"_PID_ERsep.sfu
mv CsIArray_ERaw.mca CsIArray_ERaw_fromPIDsepdata0p2a/run"$1"_CsIArray_ERaw_fromPIDsepdata.mca

mkdir CsIArray_ERaw_fromPIDsepdata0p3a
CsIArray_ERaw CsIArray_PID_ERsep0p3a/run"$1"_PID_ERsep.sfu
mv CsIArray_ERaw.mca CsIArray_ERaw_fromPIDsepdata0p3a/run"$1"_CsIArray_ERaw_fromPIDsepdata.mca

mkdir CsIArray_ERaw_fromPIDsepdata1p0a
CsIArray_ERaw CsIArray_PID_ERsep1p0a/run"$1"_PID_ERsep.sfu
mv CsIArray_ERaw.mca CsIArray_ERaw_fromPIDsepdata1p0a/run"$1"_CsIArray_ERaw_fromPIDsepdata.mca

mkdir CsIArray_ERaw_fromPIDsepdata1p1a
CsIArray_ERaw CsIArray_PID_ERsep1p1a/run"$1"_PID_ERsep.sfu
mv CsIArray_ERaw.mca CsIArray_ERaw_fromPIDsepdata1p1a/run"$1"_CsIArray_ERaw_fromPIDsepdata.mca

mkdir CsIArray_ERaw_fromPIDsepdata1p2a
CsIArray_ERaw CsIArray_PID_ERsep1p2a/run"$1"_PID_ERsep.sfu
mv CsIArray_ERaw.mca CsIArray_ERaw_fromPIDsepdata1p2a/run"$1"_CsIArray_ERaw_fromPIDsepdata.mca

mkdir CsIArray_ERaw_fromPIDsepdata2p0a
CsIArray_ERaw CsIArray_PID_ERsep2p0a/run"$1"_PID_ERsep.sfu
mv CsIArray_ERaw.mca CsIArray_ERaw_fromPIDsepdata2p0a/run"$1"_CsIArray_ERaw_fromPIDsepdata.mca

mkdir CsIArray_ERaw_fromPIDsepdata2p1a
CsIArray_ERaw CsIArray_PID_ERsep2p1a/run"$1"_PID_ERsep.sfu
mv CsIArray_ERaw.mca CsIArray_ERaw_fromPIDsepdata2p1a/run"$1"_CsIArray_ERaw_fromPIDsepdata.mca

mkdir CsIArray_ERaw_fromPIDsepdata3p0a
CsIArray_ERaw CsIArray_PID_ERsep3p0a/run"$1"_PID_ERsep.sfu
mv CsIArray_ERaw.mca CsIArray_ERaw_fromPIDsepdata3p0a/run"$1"_CsIArray_ERaw_fromPIDsepdata.mca

mkdir CsIArray_ERaw_fromPIDsepdata4p0a
CsIArray_ERaw CsIArray_PID_ERsep4p0a/run"$1"_PID_ERsep.sfu
mv CsIArray_ERaw.mca CsIArray_ERaw_fromPIDsepdata4p0a/run"$1"_CsIArray_ERaw_fromPIDsepdata.mca

echo ""
echo "Done making CsI raw energy files from PID separated data."

#!/bin/bash

# Script to generate the Tigress addback ring gamma ray energy spectrum for a given run.
# Spectra are gated according to
# Argument 1 is the run number.

#copy master files
mkdir MasterFiles
cp GenericMasterFiles/master26563_Tigress_ECalABRing MasterFiles/master"$1"_Tigress_ECalABRing

#replace master file strings with appropriate values
sed -i 's/26563/'"$1"'/g'  MasterFiles/master"$1"_Tigress_ECalABRing
sed -i 's#sfu/run'"$1"'.sfu#CsIArray_PID_ERsep0p2a/run'"$1"'_PID_ERsep.sfu#g'  MasterFiles/master"$1"_Tigress_ECalABRing

#make the CsI energy spectra from 0p1a data 
mkdir TigressCsIArray_CsIECal_853Gate_fromPIDsepdata0p1a
TigressCsIArray_CsIECal_TigEGate MasterFiles/master"$1"_Tigress_ECalABRing 851 856
mv CsIECal_TigEGate.mca TigressCsIArray_CsIECal_853Gate_fromPIDsepdata0p1a/run"$1"_TigressCsIArray_CsIECal_TigEGate_fromPIDsepdata.mca

mkdir TigressCsIArray_CsIECal_1083Gate_fromPIDsepdata0p1a
TigressCsIArray_CsIECal_TigEGate MasterFiles/master"$1"_Tigress_ECalABRing 1078 1085
mv CsIECal_TigEGate.mca TigressCsIArray_CsIECal_1083Gate_fromPIDsepdata0p1a/run"$1"_TigressCsIArray_CsIECal_TigEGate_fromPIDsepdata.mca

#replace master file strings with appropriate values
sed -i 's#CsIArray_PID_ERsep0p1a/run'"$1"'_PID_ERsep.sfu#CsIArray_PID_ERsep0p2a/run'"$1"'_PID_ERsep.sfu#g'  MasterFiles/master"$1"_Tigress_ECalABRing

#make the CsI energy spectra from 0p2a data 
mkdir TigressCsIArray_CsIECal_853Gate_fromPIDsepdata0p2a
TigressCsIArray_CsIECal_TigEGate MasterFiles/master"$1"_Tigress_ECalABRing 851 856
mv CsIECal_TigEGate.mca TigressCsIArray_CsIECal_853Gate_fromPIDsepdata0p2a/run"$1"_TigressCsIArray_CsIECal_TigEGate_fromPIDsepdata.mca

mkdir TigressCsIArray_CsIECal_1083Gate_fromPIDsepdata0p2a
TigressCsIArray_CsIECal_TigEGate MasterFiles/master"$1"_Tigress_ECalABRing 1078 1085
mv CsIECal_TigEGate.mca TigressCsIArray_CsIECal_1083Gate_fromPIDsepdata0p2a/run"$1"_TigressCsIArray_CsIECal_TigEGate_fromPIDsepdata.mca


#remove intermediate data files to save disk space and cleanup
echo ""
echo "Cleaning up..."
rm -rf MasterFiles/

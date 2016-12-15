#!/bin/bash

# Script to generate PID plots from TTCal seperated data.
# Argument 1 is the run number.

#copy master files
mkdir MasterFiles
cp GenericMasterFiles/master26563_CsIArray_PID_ER MasterFiles/master"$1"_CsIArray_PID_ER

#replace master file strings with appropriate values
sed -i 's/26563/'"$1"'/g'  MasterFiles/master"$1"_CsIArray_PID_ER
sed -i 's#sfu/run'"$1"'.sfu#TigressCsIArray_TTCalsep/run'"$1"'_TigressCsIArrayTTCalsep.sfu#g'  MasterFiles/master"$1"_CsIArray_PID_ER
sed -i 's#CsIArray_PID_ER/run'"$1"'_CsIArray_PID_ER.root#CsIArray_PID_ER_fromTTCalsepdata/run'"$1"'_CsIArray_PID_ER.root#g'  MasterFiles/master"$1"_CsIArray_PID_ER

#make the CsIArray PID ROOT file
mkdir CsIArray_PID_ER_fromTTCalsepdata
CsIArray_PID_ER MasterFiles/master"$1"_CsIArray_PID_ER 0 10 0 10000000

#remove intermediate data files to save disk space and cleanup
echo ""
echo "Cleaning up..."
rm -rf MasterFiles/
rm CsIArray_PID_Ratio.mca
rm CsIArray_PID_Energy.mca

echo ""
echo "Done making the CsI PID ROOT file from TTCal seperated data: CsIArray_PID_ER_fromTTCalsepdata/run"$1"_CsIArray_PID_ER.root"

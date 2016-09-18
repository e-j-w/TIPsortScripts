#!/bin/bash

# Script to generate PID separated data from the time correlated data.

#copy master files
mkdir MasterFiles
cp GenericMasterFiles/master26563_CsIArray_PID_ERsep MasterFiles/master"$1"_CsIArray_PID_ERsep

#replace master file strings with appropriate values
sed -i 's/26563/'"$1"'/g' MasterFiles/master"$1"_CsIArray_PID_ERsep


#do separation
mkdir CsIArray_PID_ERsep0p2a
mkdir CsIArray_PID_ERsep2p0a
separate_CsIArray_PID_ER MasterFiles/master"$1"_CsIArray_PID_ERsep 0 2
mv run"$1"_PID_ERsep.sfu CsIArray_PID_ERsep0p2a/run"$1"_PID_ERsep.sfu
separate_CsIArray_PID_ER MasterFiles/master"$1"_CsIArray_PID_ERsep 2 0
mv run"$1"_PID_ERsep.sfu CsIArray_PID_ERsep2p0a/run"$1"_PID_ERsep.sfu

#remove intermediate data files to save disk space and cleanup
echo ""
echo "Cleaning up..."
rm -rf MasterFiles/

echo ""
echo "Done making PID separated data: CsIArray_PID_ERsep0p2a/run"$1"_PID_ERsep.sfu, CsIArray_PID_ERsep2p0a/run"$1"_PID_ERsep.sfu"

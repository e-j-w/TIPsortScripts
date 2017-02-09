#!/bin/bash

# Script to generate PID separated data from the time correlated data.
# Argument 1 is the run number
# Argument 2 is the gate file (.root)
# Argument 3 is the game name file

#copy master files
mkdir MasterFiles
cp GenericMasterFiles/master26563_CsIArray_AngleBetweenHitssep MasterFiles/master"$1"_CsIArray_AngleBetweenHitssep

#replace master file strings with appropriate values
sed -i 's/26563/'"$1"'/g' MasterFiles/master"$1"_CsIArray_AngleBetweenHitssep

#do separation
mkdir CsIArray_AngleBetweenHitssep_fromPIDsepdata0p1a
mkdir CsIArray_AngleBetweenHitssep_fromPIDsepdata0p2a
mkdir CsIArray_AngleBetweenHitssep_fromPIDsepdata0p3a
mkdir CsIArray_AngleBetweenHitssep_fromPIDsepdata2p0a
separate_AngleBetweenHits MasterFiles/master"$1"_CsIArray_AngleBetweenHitssep -1 0.8
mv run"$1"_AngleBetweenHitssep.sfu CsIArray_AngleBetweenHitssep_fromPIDsepdata0p1a/run"$1"_AngleBetweenHitssep.sfu

sed -i 's/sep0p1a/sep0p2a/g' MasterFiles/master"$1"_CsIArray_AngleBetweenHitssep
separate_AngleBetweenHits MasterFiles/master"$1"_CsIArray_AngleBetweenHitssep -1 0.8
mv run"$1"_AngleBetweenHitssep.sfu CsIArray_AngleBetweenHitssep_fromPIDsepdata0p2a/run"$1"_AngleBetweenHitssep.sfu

sed -i 's/sep0p2a/sep0p3a/g' MasterFiles/master"$1"_CsIArray_AngleBetweenHitssep
separate_AngleBetweenHits MasterFiles/master"$1"_CsIArray_AngleBetweenHitssep -1 0.8
mv run"$1"_AngleBetweenHitssep.sfu CsIArray_AngleBetweenHitssep_fromPIDsepdata0p3a/run"$1"_AngleBetweenHitssep.sfu

sed -i 's/sep0p3a/sep2p0a/g' MasterFiles/master"$1"_CsIArray_AngleBetweenHitssep
separate_AngleBetweenHits MasterFiles/master"$1"_CsIArray_AngleBetweenHitssep -1 0.8
mv run"$1"_AngleBetweenHitssep.sfu CsIArray_AngleBetweenHitssep_fromPIDsepdata2p0a/run"$1"_AngleBetweenHitssep.sfu

#remove intermediate data files to save disk space and cleanup
echo ""
echo "Cleaning up..."
rm -rf MasterFiles/

echo ""
echo "Done making data separated on angle between CsI hits: CsIArray_AngleBetweenHitssep_fromPIDsepdata0p1a/run"$1"_AngleBetweenHitssep.sfu, etc..."

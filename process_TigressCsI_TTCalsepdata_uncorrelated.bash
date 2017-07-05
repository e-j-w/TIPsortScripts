#!/bin/bash

# Script to generate separated data which is time UNcorrelated by applying a series of gates:
# CsI-CsI time gate specified in CSIARRAY_par.dat (in ns), keeping data outside of the gate
# Tigress-Tigress time gate specified in CSIARRAY_par.dat (in ns), keeping data outside of the gate
# Tigress-CsI time gate (time gate in ns specified by arguments 2 and 3), keeping data outside of the gate
# Argument 1 is the run number.
# Arguments 2 and 3 specify the Tigress-CsI timing gate (in ns).

#copy master files
mkdir MasterFiles
cp GenericMasterFiles/master26563_CsIArrayTTCalsep MasterFiles/master"$1"_CsIArrayTTCalsep
cp GenericMasterFiles/master26563_TigressTTCalsep MasterFiles/master"$1"_TigressTTCalsep
cp GenericMasterFiles/master26563_TigressCsIArrayTTCalsep MasterFiles/master"$1"_TigressCsIArrayTTCalsep

#replace master file strings with appropriate values
sed -i 's/26563/'"$1"'/g'  MasterFiles/master"$1"_CsIArrayTTCalsep
sed -i 's/26563/'"$1"'/g'  MasterFiles/master"$1"_TigressTTCalsep
sed -i 's/26563/'"$1"'/g'  MasterFiles/master"$1"_TigressCsIArrayTTCalsep

#do separation
mkdir CsIArray_TTCalsep
mkdir Tigress_TTCalsep
mkdir TigressCsIArray_TTCalsep
separate_CsIArray_TTCalDiff MasterFiles/master"$1"_CsIArrayTTCalsep no
separate_Tigress_TTCalDiff MasterFiles/master"$1"_TigressTTCalsep no
separate_TigressCsIArray_TTCalFirstHitDiff MasterFiles/master"$1"_TigressCsIArrayTTCalsep $3 $2

#move intermediate files to appropriate directories
mv run"$1"_CsIArrayTTCalsep.sfu CsIArray_TTCalsep/run"$1"_CsIArrayTTCalsep.sfu
mv run"$1"_TigressTTCalsep.sfu Tigress_TTCalsep/run"$1"_TigressTTCalsep.sfu

#remove intermediate data files to save disk space and cleanup
echo ""
echo "Cleaning up..."
rm -rf MasterFiles/

echo ""
echo "Done making Tigress-CsI timing separated data: TigressCsIArray_TTCalsep/run"$1"_TigressCsIArrayTTCalsep.sfu"

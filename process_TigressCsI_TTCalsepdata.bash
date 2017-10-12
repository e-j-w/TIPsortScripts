#!/bin/bash

# Script to generate separated data which is time correlated by applying a series of gates:
# CsI-CsI time gate specified in CSIARRAY_par.dat (in ns)
# Tigress-Tigress time gate specified in CSIARRAY_par.dat (in ns)
# Tigress-CsI time gate (time gate in ns specified by arguments 2 and 3)
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
separate_CsIArray_TTCalDiffFirstHit MasterFiles/master"$1"_CsIArrayTTCalsep
separate_Tigress_TTCalDiffFirstHit MasterFiles/master"$1"_TigressTTCalsep
#separate_TigressCsIArray_TTCalFirstHitDiff MasterFiles/master"$1"_TigressCsIArrayTTCalsep 4560 4690
#separate_TigressCsIArray_TTCalFirstHitDiff MasterFiles/master"$1"_TigressCsIArrayTTCalsep $2 $3
separate_TigressCsIArray_TTCalAnyHitDiff MasterFiles/master"$1"_TigressCsIArrayTTCalsep $2 $3
#separate_TigressCsIArray_TTCalFirstHitDiff MasterFiles/master"$1"_TigressCsIArrayTTCalsep 0 100

#move intermediate files to appropriate directories
mv run"$1"_CsIArrayTTCalsep.sfu CsIArray_TTCalsep/run"$1"_CsIArrayTTCalsep.sfu
mv run"$1"_TigressTTCalsep.sfu Tigress_TTCalsep/run"$1"_TigressTTCalsep.sfu

#remove intermediate data files to save disk space and cleanup
echo ""
echo "Cleaning up..."
rm -rf MasterFiles/

echo ""
echo "Done making Tigress-CsI timing separated data: TigressCsIArray_TTCalsep/run"$1"_TigressCsIArrayTTCalsep.sfu"

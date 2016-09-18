#!/bin/bash

# Script to generate separated data which is time correlated by applying a series of gates:
# CsI-CsI time gate (100 ns)
# Tigress-Tigress time gate (120 ns)
# Tigress-CsI time gate
# Argument 1 is the run number.

#copy master files
mkdir MasterFiles
cp GenericMasterFiles/master26563_CsIArrayTTCalsep MasterFiles/master"$1"_CsIArrayTTCalsep
cp GenericMasterFiles/master26563_TigressTTCalsep MasterFiles/master"$1"_TigressTTCalsep
cp GenericMasterFiles/master26563_TigressCsIArrayTTCalsep MasterFiles/master"$1"_TigressCsIArrayTTCalsep

#replace master file strings with appropriate values
sed -i 's/26563/'"$1"'/g'  MasterFiles/master"$1"_CsIArrayTTCalsep
sed -i 's/26563/'"$1"'/g'  MasterFiles/master"$1"_TigressTTCalsep
sed -i 's/26563/'"$1"'/g'  MasterFiles/master"$1"_TigressCsIArrayTTCalsep


#do separation on trigbit 69 (Tigress+CsI+RF)
mkdir TBsep
#separate_TrigBits sfu/run"$1".sfu TBsep/run"$1"_TBsep.sfu 69
cp sfu/run"$1".sfu TBsep/run"$1"_TBsep.sfu

#do separation
mkdir TigressCsIArray_TTCalsep
separate_CsIArray_TTCalDiff MasterFiles/master"$1"_CsIArrayTTCalsep
separate_Tigress_TTCalDiff MasterFiles/master"$1"_TigressTTCalsep
#separate_TigressCsIArray_TTCalFirstHitDiff MasterFiles/master"$1"_TigressCsIArrayTTCalsep 4560 4690
separate_TigressCsIArray_TTCalFirstHitDiff MasterFiles/master"$1"_TigressCsIArrayTTCalsep 3550 3680

#remove intermediate data files to save disk space and cleanup
echo ""
echo "Cleaning up..."
rm -rf TBsep/
rm -rf MasterFiles/
rm run"$1"_CsIArrayTTCalsep.sfu
rm run"$1"_TigressTTCalsep.sfu

echo ""
echo "Done making Tigress-CsI timing separated data: TigressCsIArray_TTCalsep/run"$1"_TigressCsIArrayTTCalsep.sfu"

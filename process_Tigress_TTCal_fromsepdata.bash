#!/bin/bash

# Script to generate the Tigress/Tigress timing plot from timing separated data for a given run.
# Argument 1 is the run number.

#copy master files
mkdir MasterFiles
cp GenericMasterFiles/master26563_TigressTTCal MasterFiles/master"$1"_TigressTTCal

#replace master file strings with appropriate values
sed -i 's/26563/'"$1"'/g'  MasterFiles/master"$1"_TigressTTCal
sed -i 's/Tigress_TTCal/Tigress_TTCal_fromsepdata/g'  MasterFiles/master"$1"_TigressTTCal
sed -i 's#sfu/run'"$1"'.sfu#TigressCsIArray_TTCalsep/run'"$1"'_TigressCsIArrayTTCalsep.sfu#g'  MasterFiles/master"$1"_TigressTTCal

#make the Tigress/Tigress timing plot ROOT file
mkdir Tigress_TTCal_fromsepdata
Tigress_TTCal MasterFiles/master"$1"_TigressTTCal
#mv Tigress_TTCal.root Tigress_TTCal_fromsepdata/run"$1"_Tigress_TTCal_fromsepdata.root

#remove intermediate data files to save disk space and cleanup
echo ""
echo "Cleaning up..."
rm -rf MasterFiles/

echo ""
echo "Done making the Tigress/Tigress timing ROOT file from separated data: Tigress_TTCal_fromsepdata/run"$1"_Tigress_TTCal_fromsepdata.root"

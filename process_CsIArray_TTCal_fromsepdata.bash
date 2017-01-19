#!/bin/bash

# Script to generate the CsI/CsI timing plot from timing separated data for a given run.
# Argument 1 is the run number.

#copy master files
mkdir MasterFiles
cp GenericMasterFiles/master26563_CsIArrayTTCal MasterFiles/master"$1"_CsIArrayTTCal

#replace master file strings with appropriate values
sed -i 's/26563/'"$1"'/g'  MasterFiles/master"$1"_CsIArrayTTCal
sed -i 's/CsIArray_TTCal/CsIArray_TTCal_fromsepdata/g'  MasterFiles/master"$1"_CsIArrayTTCal
sed -i 's#sfu/run'"$1"'.sfu#TigressCsIArray_TTCalsep/run'"$1"'_TigressCsIArrayTTCalsep.sfu#g'  MasterFiles/master"$1"_CsIArrayTTCal

#make the CsI/CsI timing plot ROOT file
mkdir CsIArray_TTCal_fromsepdata
CsIArray_TTCal MasterFiles/master"$1"_CsIArrayTTCal
mv CsIArray_TTCal.root CsIArray_TTCal_fromsepdata/run"$1"_CsIArray_TTCal_fromsepdata.root

#remove intermediate data files to save disk space and cleanup
echo ""
echo "Cleaning up..."
rm -rf MasterFiles/

echo ""
echo "Done making the CsI/CsI timing ROOT file from separated data: CsIArray_TTCal_fromsepdata/run"$1"_CsIArray_TTCal_fromsepdata.root"

#!/bin/bash

# Script to generate the Tigress/CsI timing plot from timing separated data for a given run.
# Argument 1 is the run number.

#copy master files
mkdir MasterFiles
cp GenericMasterFiles/master26563_TigressCsIArrayTTCal MasterFiles/master"$1"_TigressCsIArrayTTCal

#replace master file strings with appropriate values
sed -i 's/26563/'"$1"'/g'  MasterFiles/master"$1"_TigressCsIArrayTTCal
sed -i 's/TigressCsIArray_TTCal/TigressCsIArray_TTCal_fromsepdata/g'  MasterFiles/master"$1"_TigressCsIArrayTTCal


#do separation on trigbit 69 (Tigress+RF+CsI)
mkdir TBsep
separate_TrigBits TigressCsIArray_TTCalsep/run"$1"_TigressCsIArrayTTCalsep.sfu TBsep/run"$1"_TBsep.sfu 69

#make the Tigress/BGO hit pattern ROOT file
mkdir TigressCsIArray_TTCal_fromsepdata
TigressCsIArray_TTCal MasterFiles/master"$1"_TigressCsIArrayTTCal
#mv TigressBGO_TTHP.root TigressCsIArray_TTCal/run"$1"_TigressCsIArray_TTCal.root

#remove intermediate data files to save disk space and cleanup
echo ""
echo "Cleaning up..."
rm -rf TBsep/
rm -rf MasterFiles/

echo ""
echo "Done making the Tigress/CsI timing ROOT file: TigressCsIArray_TTCal_fromsepdata/run"$1"_TigressCsIArray_TTCal_fromsepdata.root"

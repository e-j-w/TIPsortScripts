#!/bin/bash

# Script to generate the Tigress/BGO hit pattern for a given run.
# Argument 1 is the run number.

#copy master files
mkdir MasterFiles
cp GenericMasterFiles/master26563_TBGOHP MasterFiles/master"$1"_TBGOHP

#replace master file strings with appropriate values
sed -i 's/26563/'"$1"'/g'  MasterFiles/master"$1"_TBGOHP


#do separation on trigbit 69 (Tigress+RF+CsI)
mkdir TBsep
separate_TrigBits sfu/run"$1".sfu TBsep/run"$1"_TBsep.sfu 69

#make the Tigress/BGO hit pattern ROOT file
mkdir TigressBGO_TTHP
TigressBGO_TTHP MasterFiles/master"$1"_TBGOHP
mv TigressBGO_TTHP.root TigressBGO_TTHP/run"$1"_TigressBGO_TTHP.root

#remove intermediate data files to save disk space and cleanup
echo ""
echo "Cleaning up..."
rm -rf TBsep/
rm -rf MasterFiles/

echo ""
echo "Done making the Tigress/BGO hit pattern ROOT file: TigressBGO_TTHP/run"$1"_TigressBGO_TTHP.root"

#!/bin/bash

# A script for automatic online sorting.
# This version covers the September 2016 S1232 run

SCP_LOC="tigress@midtig06.triumf.ca:/data2/tigress/CaTargetTest/"
MAP="maps/December2016.map"

#set stuff up
if [ ! -d midas ]; then
	mkdir midas
fi
if [ ! -d sfu ]; then
	mkdir sfu
fi


echo "------------------------------------------------"
echo "Welcome to the fancy auto sort script which will" 
echo "never fail, since it was engineered by an expert" 
echo "grad student who  knows  differential equations."
echo "------------------------------------------------"

if [ "$1" == "cp" ]; then
	echo "Will only copy midas files over to this computer and convert them to sfu format."
elif [ "$1" == "ow" ]; then
  echo "Will overwrite the files previously generated for the sorted run, not including midas and sfu files."
elif [ "$1" == "superow" ]; then
  echo "Will overwrite the files previously generated for the sorted run, including midas and sfu files."
else
  echo "Re-run the script with argument:"
  echo "'ow' - if you want to overwrite the files previously generated for a given run (except midas and sfu files)"
  echo "'superow' - if you want to overwrite the files previously generated for a given run (including midas and sfu files)"
  echo "'cp' - if you only want to copy midas files over and convert to sfu format, but not sort any data"
fi

echo "Enter the number of the run which you would like to sort: "
read RUN
echo ""

if [ "$1" == "superow" ]; then
  rm midas/run"$RUN"*.mid
  rm sfu/run"$RUN".sfu
fi

if [ $(ls -1 midas/run"$RUN"*.mid | wc -l) -gt 0 ]; then
	echo "Data for run "$RUN" has already been copied to this computer."
	echo "Will sort from this data."
else
	echo "Data for run "$RUN" is not present on this computer."
	echo "Attempting to copy via SCP."
	scp "$SCP_LOC"run"$RUN*".mid midas/
fi

if [ $(ls -1 midas/run"$RUN"*.mid | wc -l) -lt 1 ]; then
	echo "ERROR: could not retrieve data for run "$RUN".  Exiting..."
	exit
fi


SUBRUNS=$(ls -1 midas/run"$RUN"*.mid | wc -l)
echo "$SUBRUNS subrun(s) detected."

#make list of subruns (special command needed to avoid listing color codes alongside filenames on midtig02) 
for file in $(ls -f midas/run"$RUN"*); do echo $file; done > runs.list


#convert the run/subruns(s) from midas to sfu format, if needed
if [ $(ls -1 sfu/run"$RUN".sfu | wc -l) -gt 0 ]; then
	  echo ".sfu file already exists for this run."
	  echo "Event data from run "$RUN" has already been reconstructed."
	  echo "Will use this data."
else
	  echo "Reconstructing events from run "$RUN"..."
	  midas2sfu runs.list sfu/run"$RUN".sfu $MAP
fi

#clean up
rm runs.list

#exit if the user has specified they only want to copy and convert data
if [ "$1" == "cp" ]; then
	exit
fi

#generate histograms if needed
echo ""
echo "Generating histograms for run "$RUN"..."
if [ ! -f TigressBGO_TTHP/run"$RUN"_TigressBGO_TTHP.root ] || [ "$1" == "ow" ] || [ "$1" == "superow" ]; then
echo ""
echo "-----------------------------------------------"
echo "Generating Tigress/BGO hit pattern histogram..."
echo "-----------------------------------------------"
echo ""
./process_TigressBGO_HP.bash $RUN
else
echo ""
echo "-------------------------------------------------------------"
echo "Tigress/BGO hit pattern histogram already exists, skipping..."
echo "-------------------------------------------------------------"
echo ""
fi

if [ ! -f TigressCsIArray_TTCal/run"$RUN"_TigressCsIArray_TTCal.root ] || [ "$1" == "ow" ] || [ "$1" == "superow" ]; then
echo ""
echo "------------------------------------------"
echo "Generating Tigress/CsI timing histogram..."
echo "------------------------------------------"
echo ""
./process_TigressCsIArray_TTCal.bash $RUN
else
echo ""
echo "--------------------------------------------------------"
echo "Tigress/CsI timing histogram already exists, skipping..."
echo "--------------------------------------------------------"
echo ""
fi


if [ ! -f CsIArray_PID_ER/run"$RUN"_CsIArray_PID_ER.root ] || [ "$1" == "ow" ] || [ "$1" == "superow" ]; then
echo ""
echo "------------------------------------------"
echo "Generating CsI PID histogram..."
echo "------------------------------------------"
echo ""
./process_CsIArray_PID_ER.bash $RUN
else
echo ""
echo "--------------------------------------------------------"
echo "CsI PID histogram already exists, skipping..."
echo "--------------------------------------------------------"
echo ""
fi

if [ ! -f Tigress_ECalRing/run"$RUN"_Tigress_ECalRing.mca ] || [ "$1" == "ow" ] || [ "$1" == "superow" ]; then
echo ""
echo "------------------------------------------"
echo "Generating calibrated TIGRESS ring spectra..."
echo "------------------------------------------"
echo ""
./process_Tigress_ECalRing.bash $RUN
else
echo ""
echo "--------------------------------------------------------"
echo "Calibrated TIGRESS ring spectra already exist, skipping..."
echo "--------------------------------------------------------"
echo ""
fi

if [ ! -f Tigress_ECalABRing/run"$RUN"_Tigress_ECalABRing.mca ] || [ "$1" == "ow" ] || [ "$1" == "superow" ]; then
echo ""
echo "------------------------------------------"
echo "Generating calibrated TIGRESS ring addback spectra..."
echo "------------------------------------------"
echo ""
./process_Tigress_ECalABRing.bash $RUN
else
echo ""
echo "--------------------------------------------------------"
echo "Calibrated TIGRESS ring addback spectra already exist, skipping..."
echo "--------------------------------------------------------"
echo ""
fi


if [ ! -f TigressCsIArray_TTCalsep/run"$RUN"_TigressCsIArrayTTCalsep.sfu ] || [ "$1" == "ow" ] || [ "$1" == "superow" ]; then
echo ""
echo "------------------------------------------"
echo "Generating separated Tigress-CsI time correlated data..."
echo "------------------------------------------"
echo ""
./process_TigressCsI_TTCalsepdata.bash $RUN
else
echo ""
echo "--------------------------------------------------------"
echo "Separated Tigress-CsI time correlated data already exists, skipping..."
echo "--------------------------------------------------------"
echo ""
fi


if [ ! -f TigressCsIArray_TTCal_fromsepdata/run"$RUN"_TigressCsIArray_TTCal_fromsepdata.root ] || [ "$1" == "ow" ] || [ "$1" == "superow" ]; then
echo ""
echo "------------------------------------------"
echo "Generating Tigress/CsI timing histogram from separated data..."
echo "------------------------------------------"
echo ""
./process_TigressCsIArray_TTCal_fromsepdata.bash $RUN
else
echo ""
echo "--------------------------------------------------------"
echo "Tigress/CsI timing histogram from separated data already exists, skipping..."
echo "--------------------------------------------------------"
echo ""
fi

if [ ! -f Tigress_ECalABRing_fromsepdata/run"$RUN"_Tigress_ECalABRing_fromsepdata.mca ] || [ "$1" == "ow" ] || [ "$1" == "superow" ]; then
echo ""
echo "------------------------------------------"
echo "Generating calibrated TIGRESS ring addback spectra from separated data..."
echo "------------------------------------------"
echo ""
./process_Tigress_ECalABRing_fromsepdata.bash $RUN
else
echo ""
echo "--------------------------------------------------------"
echo "Calibrated TIGRESS ring addback spectra from separated data already exist, skipping..."
echo "--------------------------------------------------------"
echo ""
fi


if [ ! -f CsIArray_PID_ERsep2p0a/run"$RUN"_PID_ERsep.sfu ] || [ "$1" == "ow" ] || [ "$1" == "superow" ]; then
echo ""
echo "------------------------------------------"
echo "Generating PID separated data..."
echo "------------------------------------------"
echo ""
./process_CsIArray_PID_ER_sepdata.bash $RUN
else
echo ""
echo "--------------------------------------------------------"
echo "PID separated data already exists, skipping..."
echo "--------------------------------------------------------"
echo ""
fi

if [ ! -f Tigress_ECalABRing_fromPIDsepdata2p0a/run"$RUN"_Tigress_ECalABRing_fromPIDsepdata.mca ] || [ "$1" == "ow" ] || [ "$1" == "superow" ]; then
echo ""
echo "------------------------------------------"
echo "Generating calibrated TIGRESS ring addback spectra from PID separated data..."
echo "------------------------------------------"
echo ""
./process_Tigress_ECalABRing_fromPIDsepdata.bash $RUN
else
echo ""
echo "--------------------------------------------------------"
echo "Calibrated TIGRESS ring addback spectra from PID separated data already exist, skipping..."
echo "--------------------------------------------------------"
echo ""
fi


echo ""
echo "------------------------------------------------------"
echo "Generating Tigress/CsI fold histogram..."
echo "Select 'File/Quit ROOT' when done viewing to continue."
echo "------------------------------------------------------"
echo ""
check_Fold2D sfu/run"$RUN".sfu 1 3

echo ""
echo "----------------------------------------------------------------------------------------------------"
echo "Finished sorting run data and histograms for run "$RUN"."
echo "Tigress/BGO hit pattern histogram available in: TigressBGO_TTHP/run"$RUN"_TigressBGO_TTHP.root"
echo "Tigress/CsI timing histogram available in: TigressCsIArray_TTCal/run"$RUN"_TigressCsIArray_TTCal.root "
echo "CsI PID histogram available in: CsIArray_PID_ER/run"$RUN"_CsIArray_PID_ER.root"
echo "Calibrated TIGRESS ring spectra available in: Tigress_ECalRing/run"$RUN"_Tigress_ECalRing.mca"
echo "Calibrated TIGRESS ring addback spectra available in: Tigress_ECalABRing/run"$RUN"_Tigress_ECalABRing.mca"
echo ""
echo "Time separated data available in: TigressCsIArray_TTCalsep/run"$RUN"_TigressCsIArrayTTCalsep.sfu"
echo "Tigress/CsI timing histogram from separated data available in: TigressCsIArray_TTCal_fromsepdata/run"$RUN"_TigressCsIArray_TTCal_fromsepdata.root"
echo "Calibrated TIGRESS ring addback spectra from separated data available in: Tigress_ECalABRing_fromsepdata/run"$RUN"_Tigress_ECalABRing_fromsepdata.mca"
echo "----------------------------------------------------------------------------------------------------"

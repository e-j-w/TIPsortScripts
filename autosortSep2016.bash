#!/bin/bash

# A script for automatic online sorting.
# This version covers the September 2016 S1232 run

SCP_LOC="tigress@midtig06.triumf.ca:/data1/tigress/TipTest/"

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

echo "Enter the number of the run which you would like to sort: "
read RUN
echo ""

if [ $(ls -1 midas/run"$RUN"*.mid | wc -l) -gt 0 ]; then
	echo "Data for run "$RUN" has already been copied to this computer."
	echo "Will sort from this data."
else
	echo "Data for run "$RUN" has not yet been copied to this computer."
	echo "Attempting to copy via SCP."
	scp "$SCP_LOC"run"$RUN*".mid midas/
fi

if [ $(ls -1 midas/run"$RUN"*.mid | wc -l) -lt 1 ]; then
	echo "Could not retrieve data for run "$RUN".  Exiting..."
	exit
fi

SUBRUNS=$(ls -1 midas/run"$RUN"*.mid | wc -l)
echo "$SUBRUNS subrun(s) detected."

#convert the run/subruns(s) from midas to sfu format, if needed
for ((i=0; i<$SUBRUNS; i++)); do
  if [ $(ls -1 sfu/run"$RUN"*.sfu | wc -l) -gt 0 ]; then
	  echo ".sfu files already exist for this run."
	  echo "Event data from run "$RUN" has already been reconstructed."
	  echo "Will use this data."
  else
	  echo "Reconstructing events from run "$RUN", subrun "$i"..."
	  ./convertsubruns.bash $RUN $RUN $i $i
  fi
done

#generate histograms if needed
for ((i=0; i<$SUBRUNS; i++)); do

  if [ $i -lt 10 ]; then
	  RUNSR=""$RUN"_00"$i""
  #else if [ $i -lt 100 ]; then
	#  RUNSR=""$RUN"_0"$i""
  else
	  RUNSR=""$RUN"_0"$i""
  fi

  echo ""
  echo "Generating histograms for run "$RUNSR"..."
  if [ ! -f TigressBGO_TTHP/run"$RUNSR"_TigressBGO_TTHP.root ]; then
  echo ""
  echo "-----------------------------------------------"
  echo "Generating Tigress/BGO hit pattern histogram..."
  echo "-----------------------------------------------"
  echo ""
  ./process_TigressBGO_HP.bash $RUNSR
  else
  echo ""
  echo "-------------------------------------------------------------"
  echo "Tigress/BGO hit pattern histogram already exists, skipping..."
  echo "-------------------------------------------------------------"
  echo ""
  fi

  if [ ! -f TigressCsIArray_TTCal/run"$RUNSR"_TigressCsIArray_TTCal.root ]; then
  echo ""
  echo "------------------------------------------"
  echo "Generating Tigress/CsI timing histogram..."
  echo "------------------------------------------"
  echo ""
  ./process_TigressCsIArray_TTCal.bash $RUNSR
  else
  echo ""
  echo "--------------------------------------------------------"
  echo "Tigress/CsI timing histogram already exists, skipping..."
  echo "--------------------------------------------------------"
  echo ""
  fi
  
  
  if [ ! -f CsIArray_PID_ER/run"$RUNSR"_CsIArray_PID_ER.root ]; then
  echo ""
  echo "------------------------------------------"
  echo "Generating CsI PID histogram..."
  echo "------------------------------------------"
  echo ""
  ./process_CsIArray_PID_ER.bash $RUNSR
  else
  echo ""
  echo "--------------------------------------------------------"
  echo "CsI PID histogram already exists, skipping..."
  echo "--------------------------------------------------------"
  echo ""
  fi
  

  echo ""
  echo "------------------------------------------------------"
  echo "Generating Tigress/CsI fold histogram..."
  echo "Select 'File/Quit ROOT' when done viewing to continue."
  echo "------------------------------------------------------"
  echo ""
  check_Fold2D sfu/run"$RUNSR".sfu 1 3

  echo ""
  echo "----------------------------------------------------------------------------------------------------"
  echo "Finished sorting run data and histograms for run "$RUNSR"."
  echo "Tigress/BGO hit pattern histogram available in: TigressBGO_TTHP/run"$RUNSR"_TigressBGO_TTHP.root"
  echo "Tigress/CsI timing histogram available in: TigressCsIArray_TTCal/run"$RUNSR"_TigressCsIArray_TTCal.root "
  echo "----------------------------------------------------------------------------------------------------"
done

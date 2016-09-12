#!/bin/bash

# A script for automatic online sorting.
# This version covers the September 2016 S1232 run

SCP_LOC="user@localhost:~/datadir/"

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

if [ -f midas/run"$RUN".mid ]; then
	echo "Data for run "$RUN" has already been copied to this computer."
	echo "Will sort from this data."
else
	echo "Data for run "$RUN" has not yet been copied to this computer."
	echo "Attempting to copy via SCP."
	scp "$SCP_LOC"run"$RUN".mid midas/
fi

if [ ! -f midas/run"$RUN".mid ]; then
	echo "Could not retrieve data for run "$RUN".  Exiting..."
	exit
fi


#convert the run from midas to sfu format, if needed
if [ -f sfu/run"$RUN".sfu ]; then
	echo "File run"$RUN".sfu exists."
	echo "Event data from run "$RUN" has already been reconstructed."
	echo "Will use this data."
else
	echo "Reconstructing events from run "$RUN"..."
	./convertrun.bash $RUN
fi

echo ""
echo "Generating histograms for run "$RUN"..."
if [ ! -f TigressBGO_TTHP/run"$RUN"_TigressBGO_TTHP.root ]; then
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

if [ ! -f TigressCsIArray_TTCal/run"$RUN"_TigressCsIArray_TTCal.root ]; then
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
echo "----------------------------------------------------------------------------------------------------"

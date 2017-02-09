#!/bin/bash

# A script for automatic online sorting.
# This version covers the December 2016 S1232 run

#variables unique to this run
EXPERIMENT_TITLE="DECEMBER 2016 S1232 TIP TARGET TEST RUN"
SCP_LOC="tigress@midtig06.triumf.ca:/data2/tigress/CaTargetTest/"
MAP="maps/December2016.map"
GATE_FILENAME="gates_December2016.root"
GATE_NAME_FILENAME="gateNames_December2016.dat"

#set stuff up
if [ ! -d midas ]; then
	mkdir midas
fi
if [ ! -d sfu ]; then
	mkdir sfu
fi

echo ""
echo "------------------------------------------------------------"
echo "You are now sorting: "$EXPERIMENT_TITLE""
echo "------------------------------------------------------------"
echo ""

if [ "$1" == "cp" ]; then
	echo "Will only copy midas files over to this computer and convert them to sfu format."
elif [ "$1" == "ow" ]; then
  echo "Will overwrite the files previously generated for the sorted run, not including midas and sfu files."
elif [ "$1" == "justfuckmyshitup" ]; then
  echo "Will overwrite the files previously generated for the sorted run, including midas and sfu files."
else
  echo "Re-run the script with argument:"
  echo "'cp' - if you only want to copy midas files over and convert to sfu format, but not sort any data"
  echo "'ow' - if you want to overwrite the files previously generated for a given run (except midas and sfu files)"
  echo "'justfuckmyshitup' - if you want to nuke everything from orbit and start over (overwriting the files previously generated for a given run including midas and sfu files)"
fi

#allow the run number to be specified as a parameter
if [ "$1" == "-rn" ]; then
	RUN=$2
elif [ "$2" == "-rn" ]; then
	RUN=$3
else
	echo ""
	echo "Enter the number of the run which you would like to sort: "
	read RUN
	echo ""
fi

if [ "$1" == "justfuckmyshitup" ]; then
	echo "Removing all traces of data for run "$RUN" on this computer..."
  rm midas/run"$RUN"*.mid
  rm sfu/run"$RUN".sfu
fi

if [ $(ls -1 sfu/run"$RUN".sfu | wc -l) -lt 1 ]; then
		
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

		#make list of subruns (special command needed to 
		#avoid listing color codes alongside filenames on midtig02) 
		for file in $(ls -f midas/run"$RUN"*); do echo $file; done > runs.list
		
		#convert the run/subruns(s) from midas to sfu format
		echo "Reconstructing events from run "$RUN"..."
	  midas2sfu runs.list sfu/run"$RUN".sfu $MAP
	  
	  #clean up
		rm runs.list
	  
else
		echo ".sfu file already exists for this run."
		echo "Event data from run "$RUN" has already been reconstructed."
		echo "Will use this data."
fi



#exit if the user has specified they only want to copy and convert data
if [ "$1" == "cp" ]; then
	exit
fi

#generate histograms if needed
echo ""
echo "Generating histograms for run "$RUN"..."
if [ ! -f TigressBGO_TTHP/run"$RUN"_TigressBGO_TTHP.root ] || [ "$1" == "ow" ] || [ "$1" == "justfuckmyshitup" ]; then
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

if [ ! -f Tigress_TTCal/run"$RUN"_Tigress_TTCal.root ] || [ "$1" == "ow" ] || [ "$1" == "justfuckmyshitup" ]; then
echo ""
echo "----------------------------------------------"
echo "Generating Tigress/Tigress timing histogram..."
echo "----------------------------------------------"
echo ""
./process_Tigress_TTCal.bash $RUN
else
echo ""
echo "------------------------------------------------------------"
echo "Tigress/Tigress timing histogram already exists, skipping..."
echo "------------------------------------------------------------"
echo ""
fi

if [ ! -f CsIArray_TTCal/run"$RUN"_CsIArray_TTCal.root ] || [ "$1" == "ow" ] || [ "$1" == "justfuckmyshitup" ]; then
echo ""
echo "--------------------------------------"
echo "Generating CsI/CsI timing histogram..."
echo "--------------------------------------"
echo ""
./process_CsIArray_TTCal.bash $RUN
else
echo ""
echo "----------------------------------------------------"
echo "CsI/CsI timing histogram already exists, skipping..."
echo "----------------------------------------------------"
echo ""
fi

if [ ! -f TigressCsIArray_TTCal/run"$RUN"_TigressCsIArray_TTCal.root ] || [ "$1" == "ow" ] || [ "$1" == "justfuckmyshitup" ]; then
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


if [ ! -f CsIArray_PID_ER/run"$RUN"_CsIArray_PID_ER.root ] || [ "$1" == "ow" ] || [ "$1" == "justfuckmyshitup" ]; then
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

if [ ! -f Tigress_ECalRing/run"$RUN"_Tigress_ECalRing.mca ] || [ "$1" == "ow" ] || [ "$1" == "justfuckmyshitup" ]; then
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

if [ ! -f Tigress_ECalABSuppRing/run"$RUN"_Tigress_ECalABSuppRing.mca ] || [ "$1" == "ow" ] || [ "$1" == "justfuckmyshitup" ]; then
echo ""
echo "------------------------------------------"
echo "Generating calibrated TIGRESS ring suppressed addback spectra..."
echo "------------------------------------------"
echo ""
./process_Tigress_ECalABSuppRing.bash $RUN 4000 5000
else
echo ""
echo "--------------------------------------------------------"
echo "Calibrated TIGRESS ring suppressedaddback spectra already exist, skipping..."
echo "--------------------------------------------------------"
echo ""
fi


if [ ! -f TigressCsIArray_TTCalsep/run"$RUN"_TigressCsIArrayTTCalsep.sfu ] || [ "$1" == "ow" ] || [ "$1" == "justfuckmyshitup" ]; then
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


if [ ! -f Tigress_TTCal_fromsepdata/run"$RUN"_Tigress_TTCal_fromsepdata.root ] || [ "$1" == "ow" ] || [ "$1" == "justfuckmyshitup" ]; then
echo ""
echo "------------------------------------------------------------------"
echo "Generating Tigress/Tigress timing histogram from separated data..."
echo "------------------------------------------------------------------"
echo ""
./process_Tigress_TTCal_fromsepdata.bash $RUN
else
echo ""
echo "--------------------------------------------------------------------------------"
echo "Tigress/Tigress timing histogram from separated data already exists, skipping..."
echo "--------------------------------------------------------------------------------"
echo ""
fi

if [ ! -f CsIArray_TTCal_fromsepdata/run"$RUN"_CsIArray_TTCal_fromsepdata.root ] || [ "$1" == "ow" ] || [ "$1" == "justfuckmyshitup" ]; then
echo ""
echo "----------------------------------------------------------"
echo "Generating CsI/CsI timing histogram from separated data..."
echo "----------------------------------------------------------"
echo ""
./process_CsIArray_TTCal_fromsepdata.bash $RUN
else
echo ""
echo "------------------------------------------------------------------------"
echo "CsI/CsI timing histogram from separated data already exists, skipping..."
echo "------------------------------------------------------------------------"
echo ""
fi

if [ ! -f TigressCsIArray_TTCal_fromsepdata/run"$RUN"_TigressCsIArray_TTCal_fromsepdata.root ] || [ "$1" == "ow" ] || [ "$1" == "justfuckmyshitup" ]; then
echo ""
echo "--------------------------------------------------------------"
echo "Generating Tigress/CsI timing histogram from separated data..."
echo "--------------------------------------------------------------"
echo ""
./process_TigressCsIArray_TTCal_fromsepdata.bash $RUN
else
echo ""
echo "----------------------------------------------------------------------------"
echo "Tigress/CsI timing histogram from separated data already exists, skipping..."
echo "----------------------------------------------------------------------------"
echo ""
fi

if [ ! -f Tigress_ECalABRing_fromsepdata/run"$RUN"_Tigress_ECalABRing_fromsepdata.mca ] || [ "$1" == "ow" ] || [ "$1" == "justfuckmyshitup" ]; then
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


if [ ! -f CsIArray_PID_ERsep0p3a/run"$RUN"_PID_ERsep.sfu ] || [ "$1" == "ow" ] || [ "$1" == "justfuckmyshitup" ]; then
echo ""
echo "------------------------------------------"
echo "Generating PID separated data..."
echo "------------------------------------------"
echo ""
./process_CsIArray_PID_ER_sepdata.bash $RUN $GATE_FILENAME $GATE_NAME_FILENAME
else
echo ""
echo "--------------------------------------------------------"
echo "PID separated data already exists, skipping..."
echo "--------------------------------------------------------"
echo ""
fi

if [ ! -f CsIArray_AngleBetweenHitssep_fromPIDsepdata0p3a/run"$RUN"_AngleBetweenHitssep.sfu ] || [ "$1" == "ow" ] || [ "$1" == "justfuckmyshitup" ]; then
echo ""
echo "------------------------------------------"
echo "Generating CsI hit angle separated data..."
echo "------------------------------------------"
echo ""
./process_CsIArray_AngleBetweenHits_sepdata.bash $RUN
else
echo ""
echo "--------------------------------------------------------"
echo "CsI hit angle separated data already exists, skipping..."
echo "--------------------------------------------------------"
echo ""
fi


if [ ! -f Tigress_ECalABSuppRing_fromPIDsepdata0p3a/run"$RUN"_Tigress_ECalABSuppRing_fromPIDsepdata.mca ] || [ "$1" == "ow" ] || [ "$1" == "justfuckmyshitup" ]; then
echo ""
echo "------------------------------------------"
echo "Generating calibrated TIGRESS ring suppressed addback spectra from PID separated data..."
echo "------------------------------------------"
echo ""
./process_Tigress_ECalABSuppRing_fromPIDsepdata.bash $RUN 4000 5000
else
echo ""
echo "--------------------------------------------------------"
echo "Calibrated TIGRESS ring suppressed addback spectra from PID separated data already exist, skipping..."
echo "--------------------------------------------------------"
echo ""
fi

if [ ! -f Tigress_ECalABSuppRingEGated_fromPIDsepdata0p3a/run"$RUN"_Tigress_ECalABSuppRingEGated_fromPIDsepdata.mca ] || [ "$1" == "ow" ] || [ "$1" == "justfuckmyshitup" ]; then
echo ""
echo "------------------------------------------"
echo "Generating energy gated calibrated TIGRESS ring suppressed addback spectra from PID separated data..."
echo "------------------------------------------"
echo ""
./process_Tigress_ECalABSuppRingEGated_fromPIDsepdata.bash $RUN 4000 5000
else
echo ""
echo "--------------------------------------------------------"
echo "Energy gated calibrated TIGRESS ring suppressed addback spectra from PID separated data already exist, skipping..."
echo "--------------------------------------------------------"
echo ""
fi

if [ ! -f Tigress_ECalABSuppRing_fromAngleBetweenHitssepdata0p3a/run"$RUN"_Tigress_ECalABSuppRing_fromAngleBetweenHitssepdata.mca ] || [ "$1" == "ow" ] || [ "$1" == "justfuckmyshitup" ]; then
echo ""
echo "------------------------------------------"
echo "Generating calibrated TIGRESS ring suppressed addback spectra from CsI hit angle seperated data..."
echo "------------------------------------------"
echo ""
./process_Tigress_ECalABSuppRing_fromAngleBetweenHitssepdata.bash $RUN 4000 5000
else
echo ""
echo "--------------------------------------------------------"
echo "Calibrated TIGRESS ring suppressed addback spectra from CsI hit angle separated data already exist, skipping..."
echo "--------------------------------------------------------"
echo ""
fi


#echo ""
#echo "------------------------------------------------------"
#echo "Generating Tigress/CsI fold histogram..."
#echo "Select 'File/Quit ROOT' when done viewing to continue."
#echo "------------------------------------------------------"
#echo ""
#check_Fold2D sfu/run"$RUN".sfu 1 3

echo ""
echo "--------------------------------------------------------"
echo "Finished sorting run data and histograms for run "$RUN"."
echo "--------------------------------------------------------"

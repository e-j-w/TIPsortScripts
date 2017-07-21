#!/bin/bash

rm TIGRESS_seg_energy.par
touch TIGRESS_seg_energy.par
echo "This is a calibration file for TIGRESS segments." >> TIGRESS_seg_energy.par
echo "pos     col     seg   a0            a1           a2" >> TIGRESS_seg_energy.par
for i in {1..16}
	do 
			for j in {0..3}
				do
						for k in {1..8}
							do
								echo "$i       $j       $k     $(gridlock ESegECore_pos"$i"_col"$j"_seg"$k".txt)" >> TIGRESS_seg_energy.par
							done
				done
	done

#handle segments with no hits
sed -i -e 's/ERROR: no data could be read from the input file./0 0 0/g' TIGRESS_seg_energy.par


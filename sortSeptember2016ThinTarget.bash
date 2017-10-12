#!/bin/bash

# sort all of the run numbers from the September 2016 28Mg thin target experiment

for RUN in {39580..39597}
do
    ./autosortSep2016ThinTarget.bash ow -rn $RUN
done

./autosortSep2016ThinTarget.bash ow -rn 2_39597


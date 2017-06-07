#!/bin/bash

# sort all of the run numbers from the September 2016 28Mg thin target experiment

for RUN in {39581..39597}
do
    ./autosortSep2016ThinTarget.bash ow -rn $RUN
done


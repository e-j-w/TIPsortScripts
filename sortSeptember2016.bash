#!/bin/bash

# sort all of the run numbers from the September 2016 28Mg experiment

for RUN in {39506..39523}
do
    ./autosortSep2016.bash ow -rn $RUN
done

for RUN in {39526..39565}
do
    ./autosortSep2016.bash ow -rn $RUN
done


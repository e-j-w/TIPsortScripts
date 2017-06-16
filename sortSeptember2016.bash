#!/bin/bash

# sort all of the run numbers from the September 2016 28Mg experiment

for RUN in {39506..39509}
do
    ./autosortSep2016.bash ow -rn $RUN
done

./autosortSep2016.bash ow -rn 39512

for RUN in {39515..39516}
do
    ./autosortSep2016.bash ow -rn $RUN
done

for RUN in {39522..39523}
do
    ./autosortSep2016.bash ow -rn $RUN
done

./autosortSep2016.bash ow -rn 39526

for RUN in {39528..39544}
do
    ./autosortSep2016.bash ow -rn $RUN
done

for RUN in {39546..39565}
do
    ./autosortSep2016.bash ow -rn $RUN
done


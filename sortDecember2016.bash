#!/bin/bash

# sort all of the run numbers from the December 2016 68Se experiment

for RUN in {40349..40366}
do
    ./autosortDec2016.bash -rn $RUN
done

for RUN in {40368..40381}
do
    ./autosortDec2016.bash -rn $RUN
done

for RUN in {40388..40388}
do
    ./autosortDec2016.bash -rn $RUN
done

for RUN in {40400..40409}
do
    ./autosortDec2016.bash -rn $RUN
done

for RUN in {40411..40429}
do
    ./autosortDec2016.bash -rn $RUN
done

for RUN in {40446..40465}
do
    ./autosortDec2016.bash -rn $RUN
done

for RUN in {40475..40499}
do
    ./autosortDec2016.bash -rn $RUN
done


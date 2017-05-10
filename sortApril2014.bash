#!/bin/bash

# sort all of the run numbers from the April 2014 68Se experiment

for RUN in {28046..28059}
do
    ./autosortApril2014.bash ow -rn $RUN
done

for RUN in {28061..28069}
do
    ./autosortApril2014.bash ow -rn $RUN
done

for RUN in {28088..28098}
do
    ./autosortApril2014.bash ow -rn $RUN
done


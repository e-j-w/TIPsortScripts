#!/bin/bash

# sort all of the runs with numbers ranging from argument 1 to 2

for ((RUN=$1;RUN<=$2;RUN++))
do
    ./autosortDec2016.bash -rn $RUN
done

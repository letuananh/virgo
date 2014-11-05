#!/usr/bin/sh

./compile_vrg.sh
printf "Enter sentence: "
answer -g vrg.dat -l

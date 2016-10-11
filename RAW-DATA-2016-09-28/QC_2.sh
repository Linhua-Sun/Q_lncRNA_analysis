#!/bin/bash

DATA=($(find ./ -name "trimmed_*.fq.gz"))

fastqc -t 10 ${DATA[1]} &
fastqc -t 10 ${DATA[2]} &
fastqc -t 10 ${DATA[3]} &
fastqc -t 10 ${DATA[4]} &


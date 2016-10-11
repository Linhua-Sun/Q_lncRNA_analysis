#!/bin/bash

DATA=$(find ./ -name "*.fq.gz")

echo ${DATA}


fastqc -t 10 ${DATA} 

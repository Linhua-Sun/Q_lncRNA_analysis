#!/bin/bash

#http://onetipperday.sterding.com/2012/08/convert-bed-to-gtf.html

if [ $# -ne 1 ]
then
       	echo "Please add a ucsc bed file!"
       	exit 0
fi

ID=$(basename ${1} .bed)

bedToGenePred ${ID}.bed stdout | genePredToGtf file stdin ${ID}.gtf

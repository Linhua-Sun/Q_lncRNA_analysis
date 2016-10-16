#!/bin/bash

CHROMSIZE="/data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAW-DATA-2016-09-28/ath.chrom.sizes"
BED="/data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAW-DATA-2016-09-28/RNA_Seq_rseqc/modi_Araport11.bed"
INPUT="${1}"
SAMPLE_PREFIX=$(basename ${1} .bam)

if [ ! -d ${INPUT}_OUT ]
        then mkdir -p ${INPUT}_OUT
fi

PREFIX="${INPUT}_OUT/${SAMPLE_PREFIX}"

clipping_profile.py \
-i ${INPUT} \
-s "PE" \
-o ${PREFIX} > ${PREFIX}_clipping_profile.log 2>&1 &

deletion_profile.py \
-i ${INPUT} \
-l 140 \
-o ${PREFIX} > ${PREFIX}_deletion_profile.log 2>&1 &

geneBody_coverage.py \
-r ${BED} \
-i ${INPUT} \
-o ${PREFIX} > ${PREFIX}_geneBody_coverage.log 2>&1 &

infer_experiment.py \
-r ${BED} \
-i ${INPUT} > ${PREFIX}_infer_experiment.out > ${PREFIX}_infer_experiment.log 2>&1 &

inner_distance.py \
-i ${INPUT} \
-o ${PREFIX} \
-r ${BED} > ${PREFIX}_inner_distance.log 2>&1 &

insertion_profile.py \
-s "PE" \
-i ${INPUT} \
-o ${PREFIX} > ${PREFIX}_insertion_profile.log 2>&1 &

junction_annotation.py \
-i ${INPUT}  \
-o ${PREFIX} \
-r ${BED} > ${PREFIX}_junction_annotation.log 2>&1 &

mismatch_profile.py \
-l 140 \
-i ${INPUT} \
-o ${PREFIX} > ${PREFIX}_mismatch_profile.log 2>&1 &

read_distribution.py  \
-i ${INPUT} \
-r ${BED} > ${PREFIX}_read_distribution.log 2>&1 &

tin.py \
-i ${INPUT} \
-r ${BED} \
-c 10 \
-s > ${PREFIX}_tin.log 2>&1 & 


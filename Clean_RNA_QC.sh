#!/bin/bash

CHROMSIZE="/data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAW-DATA-2016-09-28/ath.chrom.sizes"
BED="/data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAW-DATA-2016-09-28/RNA_Seq_rseqc/modi_Araport11.bed"
INPUT="${1}"
PREFIX=$(basename ${1} .bam)

bam2wig.py \
-i ${INPUT} \
-s ${CHROMSIZE} \
-o ${PREFIX} \
-u \
-d "1+-,1-+,2++,2--" &

clipping_profile.py \
-i ${INPUT} \
-s "PE" \
-o ${PREFIX} &

deletion_profile.py \
-i ${INPUT} \
-l 140 \
-o ${PREFIX} &

geneBody_coverage.py \
-r ${BED} \
-i ${INPUT} \
-o ${PREFIX} &

infer_experiment.py \
-r ${BED} \
-i ${INPUT} > ${PREFIX}_infer_experiment.out &

inner_distance.py \
-i ${INPUT} \
-o ${PREFIX} \
-r ${BED} &

insertion_profile.py \
-s "PE" \
-i ${INPUT} \
-o ${PREFIX} &

junction_annotation.py \
-i ${INPUT}  \
-o ${PREFIX} \
-r ${BED} &

mismatch_profile.py \
-l 140 \
-i ${INPUT} \
-o ${PREFIX} &

read_distribution.py  \
-i ${INPUT} \
-r ${BED} &

tin.py 
-i ${INPUT}
-r ${BED}
-c 10
-s &

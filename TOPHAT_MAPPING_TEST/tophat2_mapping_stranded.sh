#!/bin/bash

# usage: sh the_script.sh `pwd`(path)
# single end reads mapping pipeline
# time: Tue Jul 12 07:30:58 EDT 2016

# set several traps
set -e
set -u
set -o pipefail

cd ${1}

THREADS=2

OUTDIR="${1}/hisat2_stranded_$(date +%F)"

known_splicesite_infile="/data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/HISAT2_MAPPING/TAIR_10_Reference_genome/TAIR10_splicesites.txt"

INDEX="/data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/HISAT2_MAPPING/TAIR_10_Reference_genome/TAIR10"

if [ ! -d ${OUTDIR} ]
        then mkdir -p ${OUTDIR}
fi

for i in *_R1.fq.gz
do
        ID=$(basename ${i} _R1.fq.gz)
        echo "${ID} is mapping!"
        
	hisat2 -p ${THREADS} \
        --min-intronlen 20 \
        --max-intronlen 100000 \
        --pen-noncansplice 1000000 \
        --rna-strandness FR \
	--known-splicesite-infile "${known_splicesite_infile}" \
        -x "${INDEX}" \
        -1 ${ID}_R1.fq.gz -2 ${ID}_R2.fq.gz \
        -S ${OUTDIR}/${ID}_hisat_mapping_stranded.sam

        samtools view -@ ${THREADS} -b ${OUTDIR}/${ID}_hisat_mapping_stranded.sam > ${OUTDIR}/${ID}_hisat_mapping_stranded.bam
        samtools sort -@ ${THREADS} ${OUTDIR}/${ID}_hisat_mapping_stranded.bam > ${OUTDIR}/${ID}_hisat_mapping_stranded_sorted.bam
        samtools index ${OUTDIR}/${ID}_hisat_mapping_stranded_sorted.bam
        echo "${ID} mapping is finished! "
done

## refer: http://www.ccb.jhu.edu/software/hisat/manual.shtml


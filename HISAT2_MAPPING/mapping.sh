#!/bin/bash

# usage: sh the_script.sh `pwd`(path)
# single end reads mapping pipeline 
# time: Tue Jul 12 07:30:58 EDT 2016 

cd ${1}

THREADS=12

OUTDIR="${1}/HISAT-$(date +%F)"

if [ ! -d ${OUTDIR} ]
	then mkdir -p ${OUTDIR}
fi

	for i in *.fastq
	do

			ID=$(basename ${i} .fastq)

			echo ${ID}
			
			hisat2 -p ${THREADS} \
			--pen-noncansplice 1000000 \
			-x  /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/HISAT2_MAPPING/TAIR10 \
			--known-splicesite-infile /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/HISAT2_MAPPING/TAIR10/TAIR10_splicesites.txt \
			${i} \
			-S ${OUTDIR}/${ID}_hisat_$(date +%F).sam > ${OUTDIR}/${ID}_hisat_$(date +%F).log 2>&1
			
			samtools view -@ ${THREADS} -b ${OUTDIR}/${ID}_hisat_$(date +%F).sam > ${OUTDIR}/${ID}_hisat_mapping_$(date +%F).bam
			samtools sort -@ ${THREADS} ${OUTDIR}/${ID}_hisat_mapping_$(date +%F).bam > ${OUTDIR}/${ID}_hisat_mapping_$(date +%F)_sorted.bam
			samtools index ${OUTDIR}/${ID}_hisat_mapping_$(date +%F)_sorted.bam

			echo "${ID} is OK! "
	done

	## refer: http://www.ccb.jhu.edu/software/hisat/manual.shtml

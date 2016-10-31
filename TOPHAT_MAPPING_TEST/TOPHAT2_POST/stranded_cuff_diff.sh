#!/bin/bash

# Linhua Sun
# usage: sh the_script.sh `pwd`(path)

if [ $# -ne 1 ]
then
       	echo "Please add a PATH words!"
       	exit 0
fi

cd ${1}

THREADS=10

OUTDIR="stranded_diffout_TAIR-10_$(date +%F)"
REF="/data1/linhua/QIANLAB/TAIR10/TOPHAT2/TAIR10.fa"
GFF="/data1/linhua/QIANLAB/TAIR10/TOPHAT2/TAIR10_annotation/TAIR10_GFF3_genes_transposons.gff"

if [ ! -d ${OUTDIR} ]
	then mkdir -p ${OUTDIR}
fi

       	cuffdiff \
       	-o ${OUTDIR} \
       	-u \
       	-label Col-0,ddm1-10 \
       	-p ${THREADS} \
	-library-type fr-firststrand \
       	-b ${REF} ${GFF} \
	/data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/TOPHAT_MAPPING_TEST/TOPHAT2_POST/637_align_accepted_hits.bam \
	/data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/TOPHAT_MAPPING_TEST/TOPHAT2_POST/638_align_accepted_hits.bam

#!/bin/bash

# Linhua Sun
# usage: sh the_script.sh `pwd`(path)

if [ $# -ne 1 ]
then
       	echo "Please add a vcf.gz file!"
       	exit 0
fi

cd ${1}

THREADS=8


OUTDIR="./diffout-$(date +%F)"

Reference_Genome="/data1/linhua/QIANLAB/TAIR10/1/Arabidopsis_thaliana/Ensembl/TAIR10/Sequence/Bowtie2Index/genome.fa"

GFF="/data1/linhua/QIANLAB/TAIR10/1/Arabidopsis_thaliana/Ensembl/TAIR10/Annotation/Archives/archive-2015-07-17-14-28-46/Genes/genes_known.gff"

if [ ! -d ${OUTDIR} ]
	then mkdir -p ${OUTDIR}
fi

       	cuffdiff \
       	-o ${OUTDIR} \
       	-u \
       	-label Col-0,ddm1-10 \
       	-p ${THREADS} \
       	-b ${Reference_Genome} ${GFF} \
 	637_intron.bam \
	637_intron.bam	

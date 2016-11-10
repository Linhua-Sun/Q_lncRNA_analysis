#!/bin/bash

gtf="/data1/linhua/QIANLAB/TAIR10/TOPHAT2/TAIR10_annotation/TAIR10_GFF3_genes_transposons.gff"
input=$(basename ${1} .bam)
outdir=$(pwd)/${input}_stringtie_out_$(date +%F)

stringtie ${input}.bam \
-o ${outdir}/${input}.gtf \
-p 10 \
-G ${gtf} \
-l ${input}_STRG \
-f 0.1 \
-m 200 \
-A ${input}_gene_abund.tab \
-C ${input}_cov_refs.gtf \
-b ${outdir} 

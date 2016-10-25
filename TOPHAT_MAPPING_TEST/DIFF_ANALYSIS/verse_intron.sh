#!/bin/bash

GTF="/data1/linhua/QIANLAB/TAIR10/1/Arabidopsis_thaliana/Ensembl/TAIR10/Annotation/Archives/archive-2015-07-17-14-28-46/Genes/genes.gtf"
verse -S -Q 20 -a ${GTF} -t 'transcript' -g gene_id -z 3 -s 1 -o test_output ${1}

#!/bin/bash

GTF="/data1/linhua/QIANLAB/TAIR10/1/Arabidopsis_thaliana/Ensembl/TAIR10/Annotation/Archives/archive-2015-07-17-14-28-46/Genes/genes.gtf"

verse -S -Q 20 -a ${GTF} -t 'transcript' -g gene_id -z 2 -s 2 -o 637_transcript_z2_s2 637_intron_names.bam &

verse -S -Q 20 -a ${GTF} -t 'transcript' -g gene_id -z 2 -s 2 -o 638_transcript_z2_s2 638_intron_names.bam &

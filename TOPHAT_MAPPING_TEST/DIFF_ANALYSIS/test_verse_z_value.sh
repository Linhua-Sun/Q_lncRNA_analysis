#!/bin/bash

GTF="/data1/linhua/QIANLAB/TAIR10/1/Arabidopsis_thaliana/Ensembl/TAIR10/Annotation/Archives/archive-2015-07-17-14-28-46/Genes/genes.gtf"

verse -S -Q 20 -a ${GTF} -t 'transcript' -g gene_id -z 0 -s 2 -o transcript_z0_s2 637_intron_names.bam &
verse -S -Q 20 -a ${GTF} -t 'transcript' -g gene_id -z 1 -s 2 -o transcript_z1_s2 637_intron_names.bam &
verse -S -Q 20 -a ${GTF} -t 'transcript' -g gene_id -z 2 -s 2 -o transcript_z2_s2 637_intron_names.bam &
verse -S -Q 20 -a ${GTF} -t 'transcript' -g gene_id -z 3 -s 2 -o transcript_z3_s2 637_intron_names.bam &
verse -S -Q 20 -a ${GTF} -t 'transcript' -g gene_id -z 4 -s 2 -o transcript_z4_s2 637_intron_names.bam &
verse -S -Q 20 -a ${GTF} -t 'transcript' -g gene_id -z 5 -s 2 -o transcript_z5_s2 637_intron_names.bam &

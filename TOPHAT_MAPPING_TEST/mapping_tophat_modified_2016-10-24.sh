#!/bin/bash


tophat2 \
--min-intron-length 8 \
--max-intron-length 60000 \
-p 2 \
-r -25 \
--library-type fr-firststrand \
-o 638_intron \
--transcriptome-index /data1/linhua/QIANLAB/TAIR10/1/Arabidopsis_thaliana/Ensembl/TAIR10/Annotation/Archives/archive-2015-07-17-14-28-46/Genes/genes_known \
/data1/linhua/QIANLAB/TAIR10/1/Arabidopsis_thaliana/Ensembl/TAIR10/Sequence/Bowtie2Index/genome \
trimmed_BN2-638_R1.fq.gz trimmed_BN2-638_R2.fq.gz &

tophat2 \
--min-intron-length 8 \
--max-intron-length 60000 \
-p 2 \
-r -25 \
--library-type fr-firststrand \
-o 637_intron \
--transcriptome-index /data1/linhua/QIANLAB/TAIR10/1/Arabidopsis_thaliana/Ensembl/TAIR10/Annotation/Archives/archive-2015-07-17-14-28-46/Genes/genes_known \
/data1/linhua/QIANLAB/TAIR10/1/Arabidopsis_thaliana/Ensembl/TAIR10/Sequence/Bowtie2Index/genome \
trimmed_BN2-637_R1.fq.gz trimmed_BN2-637_R2.fq.gz &

#!/bin/bash

LOC="/data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAW-DATA-2016-09-28"

STAR \
--runThreadN 20 \
--genomeDir /data1/linhua/QIANLAB/TAIR10/STAR \
--readFilesIn ${LOC}/trimmed_BN2-638_R1.fq.gz ${LOC}/trimmed_BN2-638_R2.fq.gz \
--readFilesCommand gunzip -c \
--alignSJDBoverhangMin 1 \
--outReadsUnmapped Fastx \
--outFilterMismatchNoverLmax 0.05 \
--outFilterScoreMinOverLread 0.90 \
--outFilterMatchNminOverLread 0.90 \
--alignIntronMax 100000 \
--outSAMtype BAM SortedByCoordinate \
--outFileNamePrefix trimmed_BN2-638_intron_modified

#!/bin/bash

genic-GTF-file="/data1/linhua/QIANLAB/TAIR10/Arabidopsis_thaliana.TAIR10.32.gtf"
TE-GTF-file="/data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/TOPHAT_MAPPING_TEST/TOPHAT2_POST/DENOVO/TE_reanalysis/TAIR10_TE.gtf"

TEtranscripts --format BAM \
--mode multi \
-t 638_name.bam \
-c 637_name.bam \
--GTF genic-GTF-file \
--TE TE-GTF-file \
--project sample_nosort_test \
--stranded reverse

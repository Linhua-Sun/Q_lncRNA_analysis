#!/bin/bash

hisat2 -p 2 \
--pen-noncansplice 1000000 \
--min-intronlen 8 \
--max-intronlen 100000 \
-x  /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/HISAT2_MAPPING/TAIR_10_Reference_genome/TAIR10 \
--known-splicesite-infile /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/HISAT2_MAPPING/TAIR_10_Reference_genome/TAIR10_splicesites.txt \
-1 trimmed_BN2-637_R1.fq.gz -2 trimmed_BN2-637_R2.fq.gz \
-S test_hisat_output_unstrand.sam &

hisat2 -p 2 \
--pen-noncansplice 1000000 \
--min-intronlen 8 \
--max-intronlen 100000 \
--rna-strandness FR \
-x  /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/HISAT2_MAPPING/TAIR_10_Reference_genome/TAIR10 \
--known-splicesite-infile /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/HISAT2_MAPPING/TAIR_10_Reference_genome/TAIR10_splicesites.txt \
-1 trimmed_BN2-637_R1.fq.gz -2 trimmed_BN2-637_R2.fq.gz \
-S test_hisat_output_stranded.sam &


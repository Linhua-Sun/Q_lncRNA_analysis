ln -s /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAWDATA/Cleandata/RRL0001/RRL0001_R1.fq.gz .
ln -s /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAWDATA/Cleandata/RRL0001/RRL0001_R2.fq.gz .
ln -s /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAWDATA/Cleandata/RRL0002/RRL0002_R1.fq.gz .
ln -s /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAWDATA/Cleandata/RRL0002/RRL0002_R2.fq.gz .
ln -s /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAWDATA/Cleandata/RRL0003/RRL0003_R1.fq.gz .
ln -s /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAWDATA/Cleandata/RRL0003/RRL0003_R2.fq.gz .
ln -s /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAWDATA/Cleandata/RRL0004/RRL0004_R1.fq.gz .
ln -s /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAWDATA/Cleandata/RRL0004/RRL0004_R2.fq.gz .
ln -s /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAWDATA/Cleandata/RRL0005/RRL0005_R1.fq.gz .
ln -s /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAWDATA/Cleandata/RRL0005/RRL0005_R2.fq.gz .
ln -s /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAWDATA/Cleandata/RRL0006/RRL0006_R1.fq.gz .
ln -s /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAWDATA/Cleandata/RRL0006/RRL0006_R2.fq.gz .
ln -s /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAWDATA/Cleandata/RRL0007/RRL0007_R1.fq.gz .
ln -s /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAWDATA/Cleandata/RRL0007/RRL0007_R2.fq.gz .
ln -s /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAWDATA/Cleandata/RRL0008/RRL0008_R1.fq.gz .
ln -s /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAWDATA/Cleandata/RRL0008/RRL0008_R2.fq.gz .
ln -s /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAWDATA/Cleandata/RRL0009/RRL0009_R1.fq.gz .
ln -s /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAWDATA/Cleandata/RRL0009/RRL0009_R2.fq.gz .
ln -s /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAWDATA/Cleandata/RRL0010/RRL0010_R1.fq.gz .
ln -s /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAWDATA/Cleandata/RRL0010/RRL0010_R2.fq.gz .
ln -s /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAWDATA/Cleandata/RRL0011/RRL0011_R1.fq.gz .
ln -s /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAWDATA/Cleandata/RRL0011/RRL0011_R2.fq.gz .
ln -s /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAWDATA/Cleandata/RRL0012/RRL0012_R1.fq.gz .
ln -s /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAWDATA/Cleandata/RRL0012/RRL0012_R2.fq.gz .
ln -s /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAWDATA/Cleandata/RRL0013/RRL0013_R1.fq.gz .
ln -s /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAWDATA/Cleandata/RRL0013/RRL0013_R2.fq.gz .
ln -s /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAWDATA/Cleandata/RRL0014/RRL0014_R1.fq.gz .
ln -s /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAWDATA/Cleandata/RRL0014/RRL0014_R2.fq.gz .
ln -s /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAWDATA/Cleandata/RRL0015/RRL0015_R1.fq.gz .
ln -s /data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAWDATA/Cleandata/RRL0015/RRL0015_R2.fq.gz .

## align

#!/bin/bash

THREADS=15

GFF="/data1/linhua/QIANLAB/Araport_TOPHAT/TAIR10.tr/Araport11_GFF3_genes_transposons.201606"
REF="/data1/linhua/QIANLAB/Araport_TOPHAT/TAIR10"

ID=$(basename ${1} _R1.fq.gz)

tophat2 \
--min-intron-length 8 \
--max-intron-length 5000 \
-p ${THREADS} \
-r -25 \
--library-type fr-firststrand \
-o ${ID}_tophat_align \
--transcriptome-index ${GFF} \
${REF} \
${ID}_R1.fq.gz ${ID}_R2.fq.gz

##

sh align.sh RRL0001_R1.fq.gz
sh align.sh RRL0002_R1.fq.gz
sh align.sh RRL0003_R1.fq.gz
sh align.sh RRL0004_R1.fq.gz
sh align.sh RRL0005_R1.fq.gz
sh align.sh RRL0006_R1.fq.gz
sh align.sh RRL0007_R1.fq.gz
sh align.sh RRL0008_R1.fq.gz
sh align.sh RRL0009_R1.fq.gz
sh align.sh RRL0010_R1.fq.gz
sh align.sh RRL0011_R1.fq.gz
sh align.sh RRL0012_R1.fq.gz
sh align.sh RRL0013_R1.fq.gz
sh align.sh RRL0014_R1.fq.gz
sh align.sh RRL0015_R1.fq.gz


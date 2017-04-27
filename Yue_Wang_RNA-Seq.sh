ln -s /data1/linhua/QIANLAB/PROJECT/Yue_Wang_2017_4_22/New_added_RNA-Seq_data/clean_data20170427/Col-0_HH2HNALXX_L8_1.clean.fq.gz .
ln -s /data1/linhua/QIANLAB/PROJECT/Yue_Wang_2017_4_22/New_added_RNA-Seq_data/clean_data20170427/Col-0_HH2HNALXX_L8_2.clean.fq.gz .
ln -s /data1/linhua/QIANLAB/PROJECT/Yue_Wang_2017_4_22/New_added_RNA-Seq_data/clean_data20170427/Salk-011035_HH2HNALXX_L8_1.clean.fq.gz .
ln -s /data1/linhua/QIANLAB/PROJECT/Yue_Wang_2017_4_22/New_added_RNA-Seq_data/clean_data20170427/Salk-011035_HH2HNALXX_L8_2.clean.fq.gz .

mv Col-0_HH2HNALXX_L8_1.clean.fq.gz 		Col_R1.fq.gz
mv Col-0_HH2HNALXX_L8_2.clean.fq.gz 		Col_R2.fq.gz
mv Salk-011035_HH2HNALXX_L8_1.clean.fq.gz 	Salk_R1.fq.gz
mv Salk-011035_HH2HNALXX_L8_2.clean.fq.gz 	Salk_R2.fq.gz

fastqc -t 2 Col_R1.fq.gz &
fastqc -t 2 Col_R2.fq.gz &
fastqc -t 2 Salk_R1.fq.gz &
fastqc -t 2 Salk_R2.fq.gz &

ln -s /data1/linhua/QIANLAB/PROJECT/Yue_Wang_2017_4_22/New_added_RNA-Seq_data/Mapping/Salk_tophat_align/accepted_hits.bam glu1.bam
ln -s /data1/linhua/QIANLAB/PROJECT/Yue_Wang_2017_4_22/New_added_RNA-Seq_data/Mapping/Col_tophat_align/accepted_hits.bam Col.bam

#!/bin/bash

# Linhua Sun
# usage: sh the_script.sh `pwd`(path)

if [ $# -ne 1 ]
then
       	echo "Please add a path word!"
       	exit 0
fi

cd ${1}

THREADS=15

OUTDIR="./cuffdiff-nuclear-$(date +%F)"

Reference_Genome="/data1/linhua/QIANLAB/Araport_TOPHAT/TAIR10.fa"

GFF="/data1/linhua/QIANLAB/Araport_related_data/Araport11_GFF3_genes_transposons.201606.gff"
#GFF="/data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RE_ANALYSIS_LNC_RNA_DATA_SET/GTF_DOWN/Merged_GTF_FILES/f_30_merged.gtf"

if [ ! -d ${OUTDIR} ]
       	then mkdir -p ${OUTDIR}
fi

cuffdiff \
-o ${OUTDIR} \
-u \
-label Col,glu1 \
-library-type fr-firststrand \
-p ${THREADS} \
-b ${Reference_Genome} ${GFF} \
Col.bam \
glu1.bam 
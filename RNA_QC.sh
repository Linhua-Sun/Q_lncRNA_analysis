#!/bin/bash

CHROMSIZE="/data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAW-DATA-2016-09-28/ath.chrom.sizes"

BED="/data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/RAW-DATA-2016-09-28/RNA_Seq_rseqc/modi_Araport11.bed"

INPUT="${1}"

PREFIX=$(basename ${1} .bam)

## INPUT bam file

#bam2wig.py Convert BAM file into wig/bigWig format.

#-t TOTAL_WIGSUM, --wigsum=TOTAL_WIGSUM
#Specified wigsum. Eg: 1,000,000,000 equals to coverage of 10 million 100nt reads. Ignore this option to disable normalization
#-u, --skip-multi-hits

bam2wig.py \
-i ${INPUT} \
-s ${CHROMSIZE} \
-o ${PREFIX} \
-u \
-d "1+-,1-+,2++,2--" \


# Calculate the distributions of clipped nucleotides across reads

clipping_profile.py \
-i ${INPUT} \
-s "PE" \
-o ${PREFIX} \


# Calculate the distributions of deletions across reads


deletion_profile.py 
-i ${INPUT}
-l 140 
-o ${PREFIX}

# Calculate the RNA-seq reads coverage over gene body.

## A single BAM file.


geneBody_coverage.py 
-r ${BED}
-i ${INPUT}
-o ${PREFIX}


## A list of BAM files separated by ”,”.

### geneBody_coverage.py 
### -r hg19.housekeeping.bed 
### -i test1.bam,test2.bam,test3.bam  
### -o output


# infer_experiment.py

## This program is used to “guess” how RNA-seq sequencing were configured, particulary how reads were stranded for strand-specific RNA-seq data, through comparing the “strandness of reads” with the “standness of transcripts”.
## The “strandness of reads” is determiend from alignment, and the “standness of transcripts” is determined from annotation.
## For non strand-specific RNA-seq data, “strandness of reads” and “standness of transcripts” are independent.
## For strand-specific RNA-seq data, “strandness of reads” is largely determined by “standness of transcripts”. See below 3 examples for details.
## You don’t need to know the RNA sequencing protocol before mapping your reads to the reference genome. Mapping your RNA-seq reads **as if they were non-strand specific**, this script can “guess” how RNA-seq reads were stranded.

### 

infer_experiment.py -r ${BED} -i ${INPUT} > ${PREFIX}_infer_experiment.out



#inner_distance.py
#Calculate inner distance between read pairs.

inner_distance.py 
-i ${INPUT} 
-o ${PREFIX} 
-r ${BED}


#insertion_profile.py
#Calculate the distributions of inserted nucleotides across reads. Note that to use this funciton, CIGAR strings within SAM/BAM file should have ‘I’ operation

insertion_profile.py \
-s "PE" \
-i ${INPUT} \
-o ${PREFIX}

# junction_annotation.py

junction_annotation.py \
-i ${INPUT}  \
-o ${PREFIX} \
-r ${BED} 



#mismatch_profile.py
#Calculate the distribution of mismatches across reads.

mismatch_profile.py \
-l 140 \
-i ${INPUT} \
-o ${PREFIX}

# read_distribution.py
# Provided a BAM/SAM file and reference gene model, this module will calculate how mapped reads were distributed over genome feature (like CDS exon, 5’UTR exon, 3’ UTR exon, Intron, Intergenic regions). When genome features are overlapped (e.g. a region could be annotated as both exon and intron by two different transcripts) , they are prioritize as: CDS exons > UTR exons > Introns > Intergenic regions, for example, if a read was mapped to both CDS exon and intron, it will be assigned to CDS exons

read_distribution.py  \
-i ${INPUT} \
-r ${BED}



# tin.py¶
## This program is designed to evaluate RNA integrity at transcript level. TIN (transcript integrity number) is named in analogous to RIN (RNA integrity number). RIN (RNA integrity number) is the most widely used metric to evaluate RNA integrity at sample (or transcriptome) level. It is a very useful preventive measure to ensure good RNA quality and robust, reproducible RNA sequencing. However, it has several weaknesses.


#-c MINIMUM_COVERAGE, --minCov=MINIMUM_COVERAGE
#Minimum number of read mapped to a transcript. default=10
#-n SAMPLE_SIZE, --sample-size=SAMPLE_SIZE
#Number of equal-spaced nucleotide positions picked from mRNA. Note: if this number is larger than the length of mRNA (L), it will be halved until it’s smaller than L. default=100
#-s, --subtract-background
#Subtract background noise (estimated from intronic reads). Only use this option if there are substantial intronic reads.

tin.py 
-i ${INPUT}
-r ${BED}
-c 10
-s


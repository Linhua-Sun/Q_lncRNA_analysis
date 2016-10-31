path="/data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/TOPHAT_MAPPING_TEST/TOPHAT2_POST/"


setwd(path)

dir()

cat(readLines("stranded_cuff_diff_Araport.sh"),sep="\n")

library(cummeRbund)

cuff<-readCufflinks("stranded_diffout_Araport_2016-10-26")

cuff

gene.diff<-diffData(genes(cuff))

head(gene.diff)



gff<-import.gff("/data1/linhua/QIANLAB/Araport_related_data/Araport11_GFF3_genes_transposons.201606.gff")

sig_gene<-subset(gene.diff,abs(gene.diff$log2_fold_change)>1 & gene.diff$q_value<0.01 & gene.diff$significant=="yes")



ncRNA<-import.gff("./Araport_lncRNA/Araport_extracted_ncRNA.gff3")
lnc_RNA<-import.gff("./Araport_lncRNA/Araport_extracted_lnc_RNA.gff3")
antisense_RNA<-import.gff("./Araport_lncRNA/Araport_extracted_antisense_RNA.gff3")
antisense_lncRNA<-import.gff("./Araport_lncRNA/Araport_extracted_antisense_lncRNA.gff3")





c(as.character(antisense_lncRNA@elementMetadata@listData$Parent) ,
  as.character(ncRNA@elementMetadata@listData$Parent) , 
  as.character(lnc_RNA@elementMetadata@listData$Parent),
  as.character(antisense_RNA@elementMetadata@listData$Parent) )

length(unique(c(as.character(antisense_lncRNA@elementMetadata@listData$Parent) ,
         as.character(ncRNA@elementMetadata@listData$Parent) , 
         as.character(lnc_RNA@elementMetadata@listData$Parent),
         as.character(antisense_RNA@elementMetadata@listData$Parent) )))


uniq_lncRNA<-unique(c(as.character(antisense_lncRNA@elementMetadata@listData$Parent) ,
         as.character(ncRNA@elementMetadata@listData$Parent) , 
         as.character(lnc_RNA@elementMetadata@listData$Parent),
         as.character(antisense_RNA@elementMetadata@listData$Parent) ))


RE1<-intersect(sig_gene$gene_id , uniq_lncRNA)
######################################

sig_gene2<-subset(gene.diff,abs(gene.diff$log2_fold_change) >2 && gene.diff$significant=="yes")

nrow(sig_gene2))


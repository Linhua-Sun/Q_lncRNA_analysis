## Different tissue RNA-Seq (INFO) ----
## RNA_Seq
meristem<-fread("/data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/lncRNA_public/Nelson_G3/RNA-Seq/Meristem.txt")
tissue<-fread("/data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/lncRNA_public/Nelson_G3/RNA-Seq/tissue.txt")
stress<-fread("/data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/lncRNA_public/Nelson_G3/RNA-Seq/stress.txt")

colnames(stress)
colnames(tissue)
colnames(meristem)

clean_stress<-stress[,c("Run_s","Sample_Name_s","age_s","tissue_s"),with=F]
clean_tissue<-tissue[,c("Run_s","Sample_Name_s","age_s","dev_stage_s"),with=F]
clean_meristem<-meristem[,c("Run_s","Sample_Name_s","age_s","tissue_s"),with=F]
clean_stress$Note<-paste(clean_stress$Run_s,clean_stress$Sample_Name_s,clean_stress$age_s,clean_stress$tissue_s,sep="***")
clean_tissue$Note<-paste(clean_tissue$Run_s,clean_tissue$Sample_Name_s,clean_tissue$age_s,clean_tissue$dev_stage_s,sep="***")
clean_meristem$Note<-paste(clean_meristem$Run_s,clean_meristem$Sample_Name_s,clean_meristem$age_s,clean_meristem$tissue_s,sep="***")
clean_stress$type<-"stress"
clean_tissue$type<-"tissue"
clean_meristem$type<-"meristem"
View(rbind(clean_stress[,c("Run_s","Note","type")],clean_tissue[,c("Run_s","Note","type")],clean_meristem[,c("Run_s","Note","type")]))
rbind(clean_stress[,c("Run_s","Note","type")],clean_tissue[,c("Run_s","Note","type")],clean_meristem[,c("Run_s","Note","type")])-> SRA_INFO

## import total seq reads for each sample ----
Ti<-fread("/data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/lncRNA_public/Nelson_G3/RNA-Seq/BAM/Ti.txt")
colnames(Ti)<-c("SRAID","Total_Reads")
head(Ti)
p<-gghistogram(data = Ti,x = "Total_Reads",rug = T,add_density = T,bins = 30,color = "blue")
ggpar(p,main = "Sequenceing depth of 200 SRA RNA-Seq datasets",xlab = "Total sequenced reads",ylab = "Counts")

## Calculate the exon length per gene by Biocon ----

## REFER  https://www.biostars.org/p/83901/
library(GenomicFeatures)
txdb <- makeTxDbFromGFF("/data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/Yuxin-Cao/Auxin/Araport11_GFF3_genes_transposons.201606.gtf",format="gtf")
# then collect the exons per gene id
exons.list.per.gene <- exonsBy(txdb,by="gene")
# then for each gene, reduce all the exons to a set of non overlapping exons, calculate their lengths (widths) and sum then
exonic.gene.sizes <-
    lapply(exons.list.per.gene, function(x) {
        sum(width(reduce(x)))
    })
TTT<-t(fread("test.csv"))
exonic.gene.sizes_DT<-as.data.table(TTT)
exonic.gene.sizes_DT$ID<-rownames(TTT)
exonic.gene.sizes_DT
colnames(exonic.gene.sizes_DT)[1]<-"length"
exonic.gene.sizes_DT<-exonic.gene.sizes_DT[,c("ID","length"),with=F]
write.csv(exonic.gene.sizes_DT,file = "Arabidopsis_exon_length_per_gene.csv",row.names = F)
## "For each meta-feature, the Length column gives the total length of genomic regions covered by features included in that meta-feature. Note that this length will be less than the sum of lengths of features included in the meta-feature when there are features overlapping with each other."





## Import Gene raw counts by verse ----
setwd("/data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/Yuxin-Cao/Auxin/CSV")
Genes_Counts<-fread("200-Genes-Verse-Counts.csv")
## Check
Genes_Counts[1:5,1:5]

Genes_Counts[Genes_Counts$ID %in% exonic.gene.sizes_DT$ID]-> Genes_Counts

New_Genes_Counts<-as.data.frame(Genes_Counts)
rownames(New_Genes_Counts)<-New_Genes_Counts$ID
New_Genes_Counts$ID<-NULL
head(New_Genes_Counts)[,1:10]

New_Genes_Counts<-sweep(New_Genes_Counts,2,Ti$Total_Reads,FUN = "/")*10e9

New_Genes_Counts<-sweep(New_Genes_Counts,1,exonic.gene.sizes_DT$length,FUN = "/")

head(New_Genes_Counts)[,1:10]
nrow(New_Genes_Counts)
write.csv(New_Genes_Counts,"Araport_37330_Genes_200_SRA_RPKM.csv")

##  New_Genes_Counts_no0<-New_Genes_Counts[rowSums(New_Genes_Counts)!=0,]
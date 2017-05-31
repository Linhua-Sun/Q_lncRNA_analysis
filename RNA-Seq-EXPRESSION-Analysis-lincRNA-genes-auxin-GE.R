setwd("/data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/Yuxin-Cao/Auxin/CSV")

Gene_RPKM<-fread("Araport_37330_Genes_200_SRA_RPKM.csv")
Linc_RPKM<-fread("PC_6480_lincRNA_200_SRA_RPKM.csv")

ROOT_PH<-fread("Root_SRA_PH.txt",header = F)

Auxin_22_genes<-readLines("/data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/Yuxin-Cao/Auxin/CSV/22_genes.txt")
Linc_45<-readLines("/data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/Yuxin-Cao/Auxin/CSV/linc_ID_auxin.txt")

#write.csv(SRA_INFO,"SRA_INFO.csv",row.names = F)
## Root related EX ----
Root_SRA_ID<-readLines("Root_SRA.txt")
Gene_RPKM[V1 %in% Auxin_22_genes][,c("V1",Root_SRA_ID),with=F]
Linc_RPKM[V1 %in% Linc_45][,c("V1",Root_SRA_ID),with=F]

## Export Gene Expression level for auxin related genes ---- 

Gene_RPKM[V1 %in% Auxin_22_genes][,c("V1",Root_SRA_ID),with=F]-> Root_Gene_RPKM
Root_Gene_RPKM<-as.data.frame(Root_Gene_RPKM)
rownames(Root_Gene_RPKM)<-Root_Gene_RPKM$V1
Root_Gene_RPKM$V1<-NULL

setnames(Root_Gene_RPKM,ROOT_PH$V1,ROOT_PH$V2)
Root_Gene_RPKM[, order(colnames(Root_Gene_RPKM))][order(rowSums(Root_Gene_RPKM), decreasing = T), ] %>% round(digits = 1) %>%  write.csv("Root_auxin_22_genes_RPKM.csv", row.names = T)

## ----
Linc_RPKM[V1 %in% Linc_45]-> Linc_45_RPKM
Linc_45_RPKM<-as.data.frame(Linc_45_RPKM)
rownames(Linc_45_RPKM)<-Linc_45_RPKM$V1
Linc_45_RPKM$V1<-NULL
Linc_45_RPKM[rowSums(Linc_45_RPKM)>1,] %>% rownames %>% cat(sep="\n")

rowSums(Linc_45_RPKM[rowSums(Linc_45_RPKM)>0,]) %>% sort() %>% as.data.frame()->A
rowMeans(Linc_45_RPKM[rowSums(Linc_45_RPKM)>0,]) %>% sort() %>% as.data.frame() ->B

lincRNA_All_Sample<-cbind(A,B)
colnames(lincRNA_All_Sample)<-c("Sum","Mean")
head(lincRNA_All_Sample)
write.csv(round(lincRNA_All_Sample,3),"lincRNA_45_All_samples_Sum_Mean.csv")

## ----
Linc_RPKM[V1 %in% Linc_45][,c("V1",Root_SRA_ID),with=F] -> Root_auxin_45_lncRNA

Root_auxin_45_lncRNA<-as.data.frame(Root_auxin_45_lncRNA)
rownames(Root_auxin_45_lncRNA)<-Root_auxin_45_lncRNA$V1
Root_auxin_45_lncRNA$V1<-NULL

Root_auxin_45_lncRNA<-round(Root_auxin_45_lncRNA,1)
setnames(Root_auxin_45_lncRNA,ROOT_PH$V1,ROOT_PH$V2)

Root_auxin_45_lncRNA<-Root_auxin_45_lncRNA[,sort(colnames(Root_auxin_45_lncRNA))]

write.csv(Root_auxin_45_lncRNA[order(rowSums(Root_auxin_45_lncRNA),decreasing = T),],"Root_auxin_45_lncRNA.csv",row.names = T)

Root_auxin_45_lncRNA[rowSums(Root_auxin_45_lncRNA)>0,] %>% write.csv("Root_auxin_6_linc_RPKM_from45.csv",row.names = T)
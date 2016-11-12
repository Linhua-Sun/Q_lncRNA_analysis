# analysis gffcompare results 

setwd("/data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/TOPHAT_MAPPING_TEST/TOPHAT2_POST/DENOVO/GFF_reannotation/GFF_QUALITY")

Intron_chain<-read.table("Intron_chain.summary",header = F)
Intron_chain <- data.frame(Intron_chain$V1,Intron_chain$V2,Intron_chain$V4)
colnames(Intron_chain) <- c("ID","Sensitivity","Precision")

Base<-read.table("Base.summary",header = F)
Base <- data.frame(Base$V1,Base$V2,Base$V4)
colnames(Base) <- c("ID","Sensitivity","Precision")

Exon<-read.table("Exon.summary",header = F)
Exon <- data.frame(Exon$V1,Exon$V2,Exon$V4)
colnames(Exon) <- c("ID","Sensitivity","Precision")

Intron<-read.table("Intron.summary",header = F)
Intron <- data.frame(Intron$V1,Intron$V2,Intron$V4)
colnames(Intron) <- c("ID","Sensitivity","Precision")

Transcript<-read.table("Transcript.summary",header = F)
Transcript <- data.frame(Transcript$V1,Transcript$V2,Transcript$V4)
colnames(Transcript) <- c("ID","Sensitivity","Precision")

Locus<-read.table("Locus.summary",header = F)
Locus <- data.frame(Locus$V1,Locus$V2,Locus$V4)
colnames(Locus) <- c("ID","Sensitivity","Precision")

Intron_chain$Group<-"Intron_chain"
Base$Group<-"Base"
Exon$Group<-"Exon"
Intron$Group<-"Intron"
Transcript$Group<-"Transcript"
Locus$Group<-"Locus"

all<-rbind(Intron_chain,Base,Exon,Intron,Transcript,Locus)
table(all$ID)

levels(all$ID)<-gsub(x = levels(all$ID) ,pattern = "gff_quality_",replacement ="" )
levels(all$ID)<-gsub(x = levels(all$ID) ,pattern = ".stats",replacement ="" )
levels(all$ID)[1]<-"Col-0"
levels(all$ID)[2]<-"ddm1-10"

all



library(ggpubr)


library(ggsci)
ggplot(all,mapping = aes(x = all$Group,y = all$Sensitivity,fill=all$ID))+ geom_bar(stat = "identity",width = 0.5,position = "dodge")+theme_pubr() +scale_color_aaas()


 
ggbarplot(te,x = "Group",y = "Sensitivity",fill = "ID",color="white",position = position_dodge(),width = 0.9)+scale_color_gradient2()

head(te)
te$ID<-gsub(te$ID, pattern = "Col-0_",replacement = "")
te$ID<-gsub(te$ID, pattern = "_",replacement = "=")

ggbarplot(te,x = "Group",y = "Precision",fill = "ID",color="black",size = 0.2,position = position_dodge(),width = 0.7)+scale_fill_discrete()

ggbarplot(te,x = "Group",y = "Sensitivity",fill = "ID",color="black",size = 0.2,position = position_dodge(),width = 0.7)+scale_fill_discrete()



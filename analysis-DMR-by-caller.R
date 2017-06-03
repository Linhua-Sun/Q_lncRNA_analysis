## Set env ----
library(DMRcaller)
setwd("/data1/linhua/QIANLAB/PROJECT/DME_2017_4_24/Daniel-Data/Mapping/Test")
IMPORT_BISMARK<- function (file)
{
    cat("Reading file: ", file, "\n", sep = "")
    
    suppressPackageStartupMessages(library(data.table))
    
    da <- fread(file)
    
    colnames(da) <-
        c(
            "Chr",
            "start",
            "strand",
            "readsM",
            "readsUM",
            "context",
            "trinucleotide_context"
        )
    
    dat <-
        GRanges(
            seqnames = da$Chr,
            ranges = IRanges(start = da$start,
                             end = da$start),
            strand = da$strand,
            context = da$context,
            readsM = da$readsM,
            readsN = da$readsM + da$readsUM,
            trinucleotide_context = da$trinucleotide_context
        )
    cat("Finished reading file: ", file, "\n", sep = "")
    return(dat)
    
}

## Import CX_report files by Bismark
WT2<-IMPORT_BISMARK("SRR516180_bismark_bt2_deduplicated.deduplicated.CX_report.txt")
TR2<-IMPORT_BISMARK("SRR516179_bismark_bt2_deduplicated.deduplicated.CX_report.txt")
methylationDataList <- GRangesList("WT" = WT2,"TR" = TR2)

## BINS DMR calling ----
DMRsbinsCG <- computeDMRs(methylationDataList[["WT"]],
                                 methylationDataList[["TR"]],
                                 context = "CG",
                                 method = "bins",
                                 binSize=200,
                                 test ="score",
                                 pValueThreshold = 0.05,
                                 minCytosinesCount = 4,
                                 minProportionDifference = 0.4,
                                 minGap = 200,
                                 minSize = 50,
                                 minReadsPerCytosine = 4,
                                 cores = 10)

DMRsbinsCHG <- computeDMRs(methylationDataList[["WT"]],
                          methylationDataList[["TR"]],
                          context = "CHG",
                          method = "bins",
                          binSize=200,
                          test ="score",
                          pValueThreshold = 0.05,
                          minCytosinesCount = 4,
                          minProportionDifference = 0.4,
                          minGap = 200,
                          minSize = 50,
                          minReadsPerCytosine = 4,
                          cores = 10)

DMRsbinsCHH <- computeDMRs(methylationDataList[["WT"]],
                           methylationDataList[["TR"]],
                           context = "CHH",
                           method = "bins",
                           binSize=200,
                           test ="score",
                           pValueThreshold = 0.05,
                           minCytosinesCount = 4,
                           minProportionDifference = 0.1,
                           minGap = 200,
                           minSize = 50,
                           minReadsPerCytosine = 4,
                           cores = 10)
## Export DMR by context to GTF files ----
DMRsbinsCG[DMRsbinsCG$cytosinesCount>6] -> DMR_filtered_CG
DMRsbinsCHG[DMRsbinsCHG$cytosinesCount>6 & (DMRsbinsCHG$proportion2-DMRsbinsCHG$proportion1)>0.4]-> DMR_filtered_CHG
DMRsbinsCHH[DMRsbinsCHH$cytosinesCount>6 & (DMRsbinsCHH$proportion2-DMRsbinsCHH$proportion1)>0.4]-> DMR_filtered_CHH

setwd("/data1/linhua/QIANLAB/PROJECT/DME_2017_4_24/Daniel-Data/Mapping/Test/GTF-DOWNLOAD")
DMRsbinsCG[DMRsbinsCG$cytosinesCount>6]  %>% export("DMRsbinsCG.gtf","gtf")
DMRsbinsCHG[DMRsbinsCHG$cytosinesCount>6 & (DMRsbinsCHG$proportion2-DMRsbinsCHG$proportion1)>0.4] %>% export("DMRsbinsCHG.gtf","gtf")
DMRsbinsCHH[DMRsbinsCHH$cytosinesCount>6 & (DMRsbinsCHH$proportion2-DMRsbinsCHH$proportion1)>0.4] %>% export("DMRsbinsCHH.gtf","gtf")


## Import Genes info from Araport annotation ----
Ara<-import("/data1/linhua/QIANLAB/Araport_TOPHAT/Araport11_GFF3_genes_transposons.201606.gff")
Ara[Ara$type=="gene"]-> gAra
c(DMR_filtered_CG,DMR_filtered_CHG,DMR_filtered_CHH)->DMR_dme

## Define usrful terms names ----
gAra_DMR_dme_DT[,str_detect(colnames(gAra_DMR_dme_DT),"X"),with=F] %>% colnames() %>% cat(sep = "\n")

Useful_terms <- c(
    "first.X.seqnames",
    "first.X.start",
    "first.X.end",
    "first.X.width",
    "first.X.strand",
    "first.X.ID",
    "first.X.symbol",
    "first.X.full_name",
    "first.X.locus_type",
    "second.X.seqnames",
    "second.X.start",
    "second.X.end",
    "second.X.width",
    "second.X.sumReadsM1",
    "second.X.sumReadsN1",
    "second.X.proportion1",
    "second.X.sumReadsM2",
    "second.X.sumReadsN2",
    "second.X.proportion2",
    "second.X.cytosinesCount",
    "second.X.context",
    "second.X.pValue",
    "second.X.regionType"
)

str_replace_all(Useful_terms,"first.X","GENE") %>% str_replace_all("second.X","DMR")->New_Useful_terms
## Find Overlaps in Genes ----

findOverlapPairs(gAra,DMR_dme)-> gAra_DMR_dme
as.data.table(gAra_DMR_dme)-> gAra_DMR_dme_DT
gAra_DMR_dme_DT[,str_detect(colnames(gAra_DMR_dme_DT),"X"),with=F][,Useful_terms,with=F]-> gAra_DMR_dme_DT_clean
setnames(gAra_DMR_dme_DT_clean,Useful_terms,New_Useful_terms)
gAra_DMR_dme_DT_clean[1:4]
gAra_DMR_dme_DT_clean$DMR.regionType %>% table

## Find Overlaps in Promoters 1K up ----

findOverlapPairs(promoters(gAra,upstream = 1000,downstream = 0),subject = DMR_dme)-> pgAra_DMR_dme
as.data.table(pgAra_DMR_dme)-> pgAra_DMR_dme_DT
pgAra_DMR_dme_DT[,str_detect(colnames(pgAra_DMR_dme_DT),"X"),with=F][,Useful_terms,with=F]-> pgAra_DMR_dme_DT_clean
setnames(pgAra_DMR_dme_DT_clean,Useful_terms,New_Useful_terms)
pgAra_DMR_dme_DT_clean[1:4]
pgAra_DMR_dme_DT_clean$DMR.regionType %>% table

## Find Overlaps in Promoters 3K up ----
findOverlapPairs(promoters(gAra,upstream = 3000,downstream = 0),subject = DMR_dme)-> K3_pgAra_DMR_dme
as.data.table(K3_pgAra_DMR_dme)-> K3_pgAra_DMR_dme_DT
K3_pgAra_DMR_dme_DT[,str_detect(colnames(K3_pgAra_DMR_dme_DT),"X"),with=F][,Useful_terms,with=F]-> K3_pgAra_DMR_dme_DT_clean
setnames(K3_pgAra_DMR_dme_DT_clean,Useful_terms,New_Useful_terms)
K3_pgAra_DMR_dme_DT_clean[1:4]
K3_pgAra_DMR_dme_DT_clean$DMR.regionType %>% table
## 
path="/data1/linhua/QIANLAB/PROJECT/Long-Noncoding-RNA-project/TOPHAT_MAPPING_TEST/TOPHAT2_POST/QUAN_TOPHAT2"
setwd(path)
dir()
bg = ballgown(dataDir=path, samplePattern='QUAN_', meas='all')
save(bg, file='QUAN.rda')



### A ballgown object has six slots: structure, expr, indexes, dirs, mergedDate, and meas.
structure(bg)$exon

structure(bg)$intron

structure(bg)$trans

## 
### *expr(ballgown_object_name, <EXPRESSION_MEASUREMENT>)

### e for exon, i for intron, t for transcript, or g for gene

transcript_fpkm = texpr(bg, 'FPKM')
transcript_cov = texpr(bg, 'cov')
whole_tx_table = texpr(bg, 'all')
exon_mcov = eexpr(bg, 'mcov')
junction_rcount = iexpr(bg)
whole_intron_table = iexpr(bg, 'all')
gene_expression = gexpr(bg)

sampleNames(bg)

pData(bg) = data.frame(id=sampleNames(bg), group=c(1,2))

stat_results = stattest(bg, feature='transcript', meas='FPKM', covariate='group')

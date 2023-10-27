fread.gzipped<-function(filepath,...){
  require(R.utils)
  require(data.table)



  # decompress first, fread can't read gzipped files
  if (R.utils::isGzipped(filepath)){

    if(.Platform$OS.type == "unix") {
      filepath=paste("zcat",filepath)
      } else {
          filepath <- R.utils::gunzip(filepath,temporary = FALSE, overwrite = TRUE,
                                remove = FALSE)
    }


  }

  ## Read in the file
  fread(filepath,...)

}
readBismarkCoverage<-function( location,sample.id,assembly="unknown",treatment,
                                    context="CpG",min.cov=10)
{
  if(length(location)>1){
    stopifnot(length(location)==length(sample.id),
              length(location)==length(treatment))
  }

  result=list()
  for(i in 1:length(location)){
    df=fread.gzipped(location[[i]],data.table=FALSE)

    # remove low coverage stuff
    df=df[ (df[,5]+df[,6]) >= min.cov ,]




    # make the object (arrange columns of df), put it in a list
    result[[i]]= new("methylRaw",data.frame(chr=df[,1],start=df[,2],end=df[,3],
                               strand="*",coverage=(df[,5]+df[,6]),
                               numCs=df[,5],numTs=df[,6]),
        sample.id=sample.id[[i]],
        assembly=assembly,context=context,resolution="base"
        )
  }

  if(length(result) == 1){
    return(result[[1]])
  }else{

    new("methylRawList",result,treatment=treatment)
  }

}
reports = read.delim('bismark_summary_report.txt')
reports$Sample = unlist(lapply(reports$File, function(x){paste(unlist(strsplit(x, split = '_'))[1:2],collapse = '_')}))
rownames(reports) <- reports$Sample
both = reports
both$Duplication_rate = (both$Duplicate.Reads..removed. / both$Aligned.Reads)*100
convert_separated_regions <- function (x, split = "_", type = "gr") 
{
    library(GenomicRanges)
    chr <- unlist(strsplit(x, split = split))[seq(1, length(unlist(strsplit(x, 
        split = split))), 3)]
    start <- as.numeric(unlist(strsplit(x, split = split))[seq(2, 
        length(unlist(strsplit(x, split = split))), 3)])
    end <- as.numeric(unlist(strsplit(x, split = split))[seq(3, 
        length(unlist(strsplit(x, split = split))), 3)])
    if (type == "df") {
        return(as.data.frame(cbind(chr, start, end)))
    }
    else if (type == "gr") {
        return(GRanges(na.omit(as.data.frame(cbind(chr, start, end)))))
    }
    else {
        return(print("Wrong type."))
    }
}
samples = both$Sample
l = c()
u = list.files()[grepl('cov', list.files())]
for(i in samples){
    tmp = u[grepl(i, u)]
    l <- c(l, tmp)
}
files = l
a1 = round(length(files)/2)
a2=  length(files)-round(length(files)/2)
group_ = c(rep('0', a1), rep('1', a2))
disable_htmp = FALSE
diff_meth_on = TRUE
regions = NA
design = FALSE
regions_on = FALSE
adj.pval = TRUE
assembly = "hg38"
cov_thresh = 1
lt = "dashed"
top = "sig"
breaks = seq(-2, 2, by=4/50)
clustering_method = "ward.D"
xlim1 = -20
xlim2 = 20
pval_thresh = 0.05
logfc_thresh = 0
colorscheme = c("#E34036", 
        "#5CA1D6", "#CCCCCC")
diffmeth = "limma"
diffmeth_res = "cpg"
adj.method = "BH"
scale = "none"
difference = 25
qvalue = 0.05
pca_on = T
additional_group = NA
extend_genes = 2000
do_go = TRUE
go_pval_cutoff = 0.2
go_n = 20
promoters = FALSE

    library(methylKit)
    if (is.na(regions)) {
        regions_on = FALSE
    }
    if (!regions_on) {
        diffmeth_res = "cpg"
    }
    group_ = factor(group_)
    obj_all <- readBismarkCoverage(location = files, sample.id = samples, 
        assembly = assembly, treatment = as.numeric(group_ == 
            levels(group_)[1]), min.cov = 0)
    if (regions_on) {
        regionCounts_all <- regionCounts(obj_all, regions)
        filtered_regionCounts_all = filterByCoverage(regionCounts_all, 
            lo.count = cov_thresh, lo.perc = NULL, hi.count = NULL, 
            hi.perc = 99.9)
    }
    filtered_cpgCounts_all = filterByCoverage(obj_all, lo.count = cov_thresh, 
        lo.perc = NULL, hi.count = NULL, hi.perc = 99.9)
    if (regions_on) {
        meth_all_regions = methylKit::unite(filtered_regionCounts_all, min.per.group = 0L,
            destrand = FALSE)
        m <- methylKit::getData(meth_all_regions)
        all_regions <- paste(m$chr, m$start, m$end, sep = "_")
        meth_all_regions.perc <- percMethylation(meth_all_regions)
        rownames(meth_all_regions.perc) <- all_regions
    }
puc=c()
lambd = c()
for(i in 1:length(filtered_cpgCounts_all)){
    tmp = filtered_cpgCounts_all[[i]]
    pUC = tmp[grepl('pUC', tmp$chr),]
    lambda = tmp[grepl('Lambda', tmp$chr),]
    pUC$methylationperc = as.numeric(pUC$numCs)/(as.numeric(pUC$numCs) + as.numeric(pUC$numTs))
    lambda$methylationperc = as.numeric(lambda$numCs)/(as.numeric(lambda$numCs) + as.numeric(lambda$numTs))
    puc <- c(puc, mean(pUC$methylationperc))
    lambd = c(lambd, mean(lambda$methylationperc)) 
    }
    
both$pUC_methpercentage = unlist(lapply(puc, function(x){x*100}))
both$Lambda_methpercentage = unlist(lapply(lambd, function(x){x*100}))
lambd_puc = read.csv('puc_lambda.csv')
a = unlist(lapply(lambd_puc$Sample, function(x){paste(unlist(strsplit(x, split = '_'))[1:2],collapse = '_')}))
rownames(lambd_puc) = a
both$pUC_coverage = lambd_puc[rownames(both),3]
both$Lambda_coverage = lambd_puc[rownames(both),2]
both$Covered_CpGs = NA
for (i in 1:nrow(both)){
    both[i, 'Covered_CpGs'] = nrow(filtered_cpgCounts_all[[i]])
}
both$Aligned_reads = reports$Aligned.Reads
both$Uniquely_mapped_reads = reports$Unique.Reads..remaining.
both$Methylated_CpGs = reports$Methylated.CpGs
both$Unmethylated_CpGs =reports$Unmethylated.CpGs
both$Methylated_CHGs = reports$Methylated.chgs
both$Unmethylated_CHGs = reports$Unmethylated.chgs
both$Methylated_CHHs = reports$Methylated.CHHs
both$Unmethylated_CHHs = reports$Unmethylated.CHHs

both$Average_perc_CpG_methylation = (both$Methylated_CpGs/(both$Methylated_CpGs+both$Unmethylated_CpGs))*100
both$Average_perc_CHG_methylation = (both$Methylated_CHGs/(both$Methylated_CHGs+both$Unmethylated_CHGs))*100
both$Average_perc_CHH_methylation = (both$Methylated_CHHs/(both$Methylated_CHHs+both$Unmethylated_CHHs))*100
write.csv(both, 'metadata.csv')
library(GenomicAlignments)
library(rtracklayer)
args = commandArgs(trailingOnly=TRUE)
wdory <- args[1]
bed_dir <- args[2]
setwd(wdory)
files <- list.files()[grepl('.bam', list.files())]
df <- matrix(NA, nrow = 1, ncol = 2)
colnames(df) <- c('Sample', 'On target %')
bedfile <- import.bed(bed_dir)
for(i in files){
bamfile <- readGAlignments(i)
overlap.counts <- countOverlaps(bedfile, bamfile)
df <- rbind(df, c(i, round(sum(overlap.counts)/length(bamfile), digits = 4)*100))
}
write.table(as.data.frame(na.omit(df)), 'on_target.tsv', sep = '\t')


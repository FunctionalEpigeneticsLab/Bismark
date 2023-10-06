args = commandArgs(trailingOnly=TRUE)
f <- args[1]
df = read.delim(f, header = F)
cat(paste(f, mean(as.numeric(df$V5)), sep = '\t'), file = 'on_target.coverages', append = TRUE)
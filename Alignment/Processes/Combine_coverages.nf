process COMBINE_MEAN_REGIONAL_COVERAGES {
        tag "Combining coverages..."
        publishDir "${baseDir}/Results/Reports/${params.batch}", mode: 'copy'
        container = "docker://kobedr/bismark_alignment_biocond:latest"
        input:
        path "*"

        output:
        path "on_target.coverages"

        script:
        """
        for i in $(ls *.summary)
        do
        echo -e "$i\t$(R -e \"df = read.delim($i);mean(as.numeric(df$V5))\")" >> on_target.coverages &
        done
        wait
        """
}

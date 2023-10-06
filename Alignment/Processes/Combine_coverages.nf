process COMBINE_MEAN_REGIONAL_COVERAGES {
        tag "Combining coverages..."
        publishDir "${baseDir}/Results/Reports/${params.batch}", mode: 'copy'
        container = "docker://kobedr/bismark_alignment_biocond:latest"
        input:
        path "*"
        scripts

        output:
        path "on_target.coverages"

        script:
        """
        for i in \$(ls *.summary)
        do
        Rscript ./Scripts/combine_coverages.r \$i &
        done
        """
}

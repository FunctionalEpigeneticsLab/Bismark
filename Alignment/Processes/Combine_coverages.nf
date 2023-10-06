process COMBINE_MEAN_REGIONAL_COVERAGES {
        tag "Combining coverages..."
        publishDir "${baseDir}/Results/Cache/Reports/${params.batch}"
        container = "docker://kobedr/bismark_alignment_biocond:latest"
        input:
        path "*"
        path scripts

        output:
        path "on_target.coverages"

        script:
        """
        for i in \$(ls *.summary)
        do
        Rscript ./Scripts/combine_coverages.r \$i
        done
        """
}

process COMPUTE_ON_TARGET {
        tag "Computing on-target rate..."
        publishDir "${baseDir}/Results/Cache/Reports/${params.batch}"
        container = "docker://kobedr/bismark_alignment_biocond:latest"
        input:
        path regions
        path "*"
        path scripts

        output:
        path "on_target.tsv"


        script:
        """
        Rscript ./Scripts/get_on_target.r . $regions
        """
}
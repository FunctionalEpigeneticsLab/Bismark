process COMBINE_METADATA {
        tag "Produce metadata..."
        publishDir "${baseDir}/Results/Reports/${params.batch}", mode: 'copy'
        container = "docker://kobedr/bismark_alignment_biocond:latest"
        input:
        path "*"
        path puc_lambda
        path summary_report
        path scripts

        output:
        path "metadata.csv"

        script:
        """
         Rscript ./Scripts/metadata_production.r 
        """
}
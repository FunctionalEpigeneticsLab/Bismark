process COMBINE_METADATA {
        tag "Produce metadata..."
        publishDir "${baseDir}/Reports/${params.batch}", mode: 'copy'
        container = "docker://kobedr/bismark_alignment_biocond:latest"
        input:
        path "*"
        path puc_lambda
        path summary_report

        output:
        path "metadata.csv"

        script:
        """
         Rscript $baseDir/metadata_production.r 
        """
}
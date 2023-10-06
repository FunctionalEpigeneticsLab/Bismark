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

process COMBINE_METADATA_REGIONS {
        tag "Produce metadata..."
        publishDir "${baseDir}/Results/Reports/${params.batch}", mode: 'copy'
        container = "docker://kobedr/bismark_alignment_biocond:latest"
        input:
        path "*"
        path puc_lambda
        path summary_report
        path scripts
        path on_targ
        path reg_reads
        path comb_cov

        output:
        path "metadata.csv"

        script:
        """
         Rscript ./Scripts/metadata_production_regions.r 
        """
}
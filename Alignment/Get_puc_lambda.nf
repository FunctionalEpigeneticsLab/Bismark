process GET_PUC_LAMBDA {
        tag "Produce metadata..."
        publishDir "${baseDir}/Cache/pUC_Lambda/${params.batch}"
        container = "docker://kobedr/bismark_alignment_utils:latest"
        input:
        path "*"

        output:
        path "puc_lambda.csv"

        script:
        """
         bash $baseDir/Scripts/get_puc_lambda_derived_reads_main.sh
        """
}
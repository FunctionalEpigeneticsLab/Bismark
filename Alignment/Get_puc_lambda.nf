process GET_PUC_LAMBDA {
        tag "Produce metadata..."
        publishDir "${baseDir}/Cache/pUC_Lambda/${params.batch}"
        container = "docker://kobedr/bismark_alignment_utils:latest"
        input:
        path "*"
        path scripts

        output:
        path "puc_lambda.csv"

        script:
        '''
        cp ./Scripts/puc_lambda_header.csv ./puc_lambda.csv
        for i in $(ls *.bam)
        do
        echo -e "${i},$(samtools view $i | grep Lambda | wc -l),$(samtools view $i | grep pUC | wc -l)" >> puc_lambda.csv &
        done
        wait
        '''
}
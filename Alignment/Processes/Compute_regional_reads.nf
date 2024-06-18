process REGIONAL_READS {
        tag "Computing reads on target..."
        publishDir "${baseDir}/Results/Cache/Reports/${params.batch}"
        container = "docker://kobedr/bismark_alignment_utils:latest"
        input:
        path "*"

        output:
        path "reads_on_target.tsv"


        script:
        '''
        for i in $(ls *.bam)
        do
        echo -e "$i\\t$(samtools view $i | wc -l)" >> reads_on_target.tsv &
        done
        wait
        '''
}
process REGIONAL_READS {
        tag "Computing reads on target..."
        publishDir "${baseDir}/Results/Reports/${params.batch}", mode: 'copy'
        container = "docker://kobedr/bismark_alignment_biocond:latest"
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
        '''
}
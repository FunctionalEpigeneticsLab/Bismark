process EXTRACT {
        tag "Extracting methylation...."
        publishDir "${baseDir}/Methextracts/${params.batch}", mode: 'copy'
        container = "docker://nfcore/methylseq:latest"
        input:
        path bam_file
        output:
        path "*.bedGraph.gz", emit: bedgraphs
        path "*.cov.gz", emit: coverages
        path "*.txt", emit: reports
        script:
        """
        bismark_methylation_extractor --paired-end -gzip --multicore ${task.cpus} --bedGraph $bam_file
        """

}
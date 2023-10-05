process DEPTH_OF_COVERAGE {
        tag "Computing reads on target..."
        publishDir "${baseDir}/Results/Cache/Coverage/${params.batch}", mode: 'copy'
        container = "docker://kobedr/bismark_alignment_utils:latest"
        input:
        path regions
        tuple path(bam), path(bai)
        path index


        output:
        path "${bam}.summary"

        script:
        """
        samtools bedcov $regions $bam > ${bam}.summary
        """
}
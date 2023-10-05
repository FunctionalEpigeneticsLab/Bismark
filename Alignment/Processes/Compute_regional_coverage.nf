process DEPTH_OF_COVERAGE_GATK {
        tag "Computing reads on target..."
        publishDir "${baseDir}/Results/Cache/Coverage/${params.batch}", mode: 'copy'
        container = "docker://mgibio/gatk-cwl:4.1.8.1"
        input:
        path regions
        path bam
        path index


        output:
        path "${bam}.summary"

        script:
        """
        gatk DepthOfCoverage -I $bam -L $regions -O ${bam}.summary -R ${index}/*.fasta
        """
}
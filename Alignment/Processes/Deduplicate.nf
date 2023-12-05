process DEDUPLICATE {
        tag "Deduplicating..."
        publishDir "${baseDir}/Results/Bams/Deduplicated/${params.batch}", mode: 'copy'
        container= "docker://nfcore/methylseq:latest"

        input:
        tuple val(sample), path(bam_file)
        output:
        tuple val(sample), path("*.deduplicated.bam"), emit: bam_files
        path "*.deduplicated.bam", emit:bam_file2
        path "*.txt", emit: reports

        script:
        """
        deduplicate_bismark --paired --bam $bam_file
        """
}
process DEDUPLICATE {
        tag "Deduplicating..."
        publishDir "${baseDir}/Bams/Deduplicated", mode: 'copy'
        container= "docker://nfcore/methylseq:latest"

        input:
        path bam_file
        output:
        path "*.deduplicated.bam", emit: bam_files
        path "*.txt", emit: reports

        script:
        """
        deduplicate_bismark --paired --bam $bam_file
        """
}
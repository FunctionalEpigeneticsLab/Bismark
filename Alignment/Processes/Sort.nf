process SORT {
        tag "Sorting reads...."
        publishDir "${baseDir}/Results/Cache/Alignment/Sorted/${params.batch}"
        container = "docker://kobedr/bismark_alignment_utils:latest"
        input:
        tuple val(sample), path(bam_file)

        output:
        tuple val(sample), path("${bam_file}")

        script:
        """
        samtools sort -@ ${task.cpus} -n $bam_file > tmp
        mv tmp $bam_file
        """
}

process SORT_AND_INDEX {
        tag "Sorting reads...."
        publishDir "${baseDir}/Results/Sorted_and_indexed/${params.batch}", mode: 'copy'
        container = "docker://kobedr/bismark_alignment_utils:latest"
        input:
        tuple val(sample), path(bam_file)

        output:
        tuple val(sample), path("${bam_file}"), path('*.bai')

        script:
        """
        samtools sort -@ ${task.cpus} $bam_file > tmp
        mv tmp $bam_file
        samtools index $bam_file
        """
}
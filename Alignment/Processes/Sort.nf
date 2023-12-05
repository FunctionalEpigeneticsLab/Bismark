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
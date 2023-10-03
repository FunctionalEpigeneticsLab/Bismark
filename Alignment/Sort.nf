process SORT {
        tag "Sorting reads...."
        publishDir "${baseDir}/Cache/Alignment/Sorted/${params.batch}"
        container = "docker://kobedr/bismark_alignment_utils:latest"
        input:
        path bam_file

        output:
        path "${bam_file}"

        script:
        """
        samtools sort -@ ${task.cpus} -n $bam_file > tmp
        mv tmp $bam_file
        """
}
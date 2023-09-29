process SORT {
        tag "Sorting reads...."
        publishDir "${baseDir}/Cache/Alignment/Sorted"
        container = "docker://kobedr/bismark_alignment_utils:latest"
        input:
        path bam_file

        output:
        path "${bam_file}"

        script:
        """
        samtools sort -n $bam_file > tmp
        mv tmp $bam_file
        """
}
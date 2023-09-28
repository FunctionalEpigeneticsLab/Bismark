process SORT {
        tag "Sorting reads...."
        publishDir "${workingDir}/Cache/Alignment/Sorted"
        container = "docker://biocontainers/samtools"
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
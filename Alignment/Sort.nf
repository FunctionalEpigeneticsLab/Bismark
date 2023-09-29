process SORT {
        tag "Sorting reads...."
        publishDir "${baseDir}/Cache/Alignment/Sorted"
        container = "docker://biocontainers/samtools:v1.9-4-deb_cv1"
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
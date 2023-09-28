process FASTQC {
        tag "Performing FastQC..."
        publishDir "${baseDir}/Cache/FastQC"
        container = "docker://biocontainers/fastqc"
        input:
        path(reads)

        output:
        path "*.html", emit: htmls
        path "*.zip", emit: zips

        script:
        """
        fastqc -t ${task.cpus} $reads
        """
}
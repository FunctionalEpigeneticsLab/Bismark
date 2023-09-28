process FASTQC {
        tag "Performing FastQC..."
        publishDir "${workingDir}/Cache/FastQC"
        container = "docker://biocontainers/fastqc:latest"
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
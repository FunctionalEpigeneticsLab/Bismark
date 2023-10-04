process FASTQC {
        tag "Performing FastQC..."
        publishDir "${baseDir}/Results/Cache/FastQC/${params.batch}"
        container = "docker://biocontainers/fastqc:v0.11.9_cv8"
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
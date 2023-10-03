process MULTIFASTQC {
        tag "Performing MultiFastQC..."
        container = "docker://staphb/multiqc:latest"
        publishDir "${baseDir}/Reports/${params.batch}", mode: 'copy'
        input:
        path "*"

        output:
        path "*.html"

        script:
        """
        multiqc .
        """
}
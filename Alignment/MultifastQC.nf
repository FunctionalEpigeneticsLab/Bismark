process MULTIFASTQC {
        tag "Performing MultiFastQC..."
        container = "docker://staphb/multiqc"
        publishDir "${baseDir}/FastQC", mode: 'copy'
        input:
        path "*"

        output:
        path "*.html"

        script:
        """
        multiqc .
        """
}
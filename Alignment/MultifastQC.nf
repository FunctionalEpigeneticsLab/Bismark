process MULTIFASTQC {
        tag "Performing MultiFastQC..."
        container = "docker://staphb/multiqc"
        publishDir "${workingDir}/FastQC", mode: 'copy'
        input:
        path "*"

        output:
        path "*.html"

        script:
        """
        multiqc .
        """
}
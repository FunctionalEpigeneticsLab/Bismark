process FASTQ_SCREEN {
        tag "Screening FastQs..."
        publishDir "${baseDir}/FastQC", mode: 'copy'
        container = "docker://singlecellpipeline/fastq_screen"
        input:
        tuple val(sample), path(file1), path(file2)
        output:
        path "*"

        script:
        """
        fastq_screen --bisulfite --outdir . --threads ${task.cpus} $file1 $file2
        """
}
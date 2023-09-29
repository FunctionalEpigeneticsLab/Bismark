process FASTQ_SCREEN {
        tag "Screening FastQs..."
        publishDir "${baseDir}/FastQC", mode: 'copy'
        container = "docker://kobedr/bismark_alignment_utils:latest"
        input:
        tuple val(sample), path(file1), path(file2)
        output:
        path "*"

        script:
        """
        fastq_screen --bisulfite --outdir . --threads ${task.cpus} $file1 $file2
        """
}
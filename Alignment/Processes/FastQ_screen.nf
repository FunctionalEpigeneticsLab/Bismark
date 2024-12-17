process FASTQ_SCREEN {
        tag "Screening FastQs..."
        publishDir "${baseDir}/Results/FastQC/${params.batch}", mode: 'copy'
        container= "docker://kobedr/fastq_screen:latest"

        input:
        tuple val(sample), path(file1), path(file2)
        output:
        path "*"

        script:
        """
        export PATH=/staging/leuven/stg_00064/Kobe_2/miniconda3/bin:$PATH
        /opt/conda/bin/fastq_screen --bisulfite --outdir . --threads ${task.cpus} $file1 $file2
        """
}
process FASTQ_SCREEN {
        tag "Screening FastQs..."
        publishDir "${baseDir}/Results/FastQC/${params.batch}", mode: 'copy'
        container= "docker://singlecellpipeline/fastq_screen:v0.0.2"

        input:
        tuple val(sample), path(file1), path(file2)
        output:
        path "*"

        script:
        """
        export PATH=/staging/leuven/stg_00064/Kobe_2/miniconda3/bin:$PATH
        fastq_screen --bisulfite --outdir . --threads ${task.cpus} $file1 $file2
        """
}
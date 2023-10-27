process FASTQ_SCREEN {
        tag "Screening FastQs..."
        publishDir "${baseDir}/Results/FastQC/${params.batch}", mode: 'copy'

        input:
        tuple val(sample), path(file1), path(file2)
        output:
        path "*"

        script:
        """
        /staging/leuven/stg_00064/Kobe_2/github/Nextflow/projects/Archive/nextflow_image/opt/conda/envs/fastq_screen/bin/fastq_screen --bisulfite --outdir . --threads ${task.cpus} $file1 $file2
        """
}
process FASTQ_SCREEN {
        tag "Screening FastQs..."
        publishDir "${baseDir}/Results/FastQC/${params.batch}", mode: 'copy'
        container = "/staging/leuven/stg_00064/Kobe_2/github/Nextflow/projects/nextflow_image_2.sif"
        input:
        tuple val(sample), path(file1), path(file2)
        output:
        path "*"

        script:
        """
        /opt/conda/envs/fastq_screen/bin/fastq_screen --bisulfite --outdir . --threads ${task.cpus} $file1 $file2
        """
}
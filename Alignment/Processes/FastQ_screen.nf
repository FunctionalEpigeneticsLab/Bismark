process FASTQ_SCREEN {
        tag "Screening FastQs..."
        publishDir "${baseDir}/Results/FastQC/${params.batch}", mode: 'copy'

        input:
        tuple val(sample), path(file1), path(file2)
        output:
        path "*"

        script:
        """
        export PATH=/staging/leuven/stg_00064/Kobe_2/miniconda3/bin:$PATH
        fastq_screen --conf /lustre1/project/stg_00064/Kobe_2/FastQ_Screen_Genomes/FastQ_Screen_Genomes_Bisulfite/fastq_screen.conf --bisulfite --outdir . --threads ${task.cpus} $file1 $file2
        """
}
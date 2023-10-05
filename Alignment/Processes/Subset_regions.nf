process REGIONAL_SUBSET {
        tag "Subsetting bams..."
        publishDir "${baseDir}/Results/Cache/Bams/Subsetted/${params.batch}", mode: 'copy'
        container = "docker://kobedr/bismark_alignment_utils:latest"
        input:
        path regions
        path bam

        output:
        tuple path("subset_${bam}"), path("subset_${bam}.bai")


        script:
        """
        samtools view -@ ${task.cpus} -b -h -L $regions $bam > subset_${bam}
        samtools sort subset_${bam} > sorted_tmp
        mv sorted_tmp subset_${bam}
        samtools index subset_${bam}
        """
}
process REGIONAL_SUBSET {
        tag "Subsetting bams..."
        publishDir "${baseDir}/Results/Cache/Bams/Subsetted/${params.batch}", mode: 'copy'
        container = "docker://kobedr/bismark_alignment_utils:latest"
        input:
        path regions
        tuple val(sample), path(bam)

        output:
        tuple val(sample), path("subset*.bam"), path("subset*.bai")


        script:
        """
        samtools view -@ ${task.cpus} -b -h -L $regions $bam > subset_${bam}
        samtools sort subset_${bam} > sorted_tmp
        mv sorted_tmp subset_${bam}
        samtools index subset_${bam}
        """
}

process REGIONAL_SUBSET_DUPLICATED {
        tag "Subsetting bams..."
        publishDir "${baseDir}/Results/Cache/Bams/Subsetted/${params.batch}", mode: 'copy'
        container = "docker://kobedr/bismark_alignment_utils:latest"
        input:
        path regions
        tuple val(sample), path(bam)

        output:
        tuple val(sample), path("subset*.bam"), path("subset*.bai")


        script:
        """
        samtools view -@ ${task.cpus} -b -h -L $regions $bam > subset_${bam}
        samtools sort subset_${bam} > sorted_tmp
        mv sorted_tmp subset_${bam}
        samtools index subset_${bam}
        """
}


process DUPLICATION_ON_TARGET {
        tag "Computing on target duplication..."
        publishDir "${baseDir}/Results/Reports/${params.batch}", mode: 'copy'
        container = "docker://kobedr/bismark_alignment_utils:latest"
        input:
        path regions
        tuple val(sample), path(bam)

        output:
        path "*.tsv"


        script:
        """
        echo -e "Deduplicated_reads\\t\$(samtools view -@ ${task.cpus} *deduplicated* | wc -l)" > on_target_duplic_rate_${sample}.tsv
        echo -e "Duplicated_reads\\t\$(samtools view -@ ${task.cpus} *deduplicated* | wc -l)" > on_target_duplic_rate_${sample}.tsv
        """
}
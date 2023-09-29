process TRIM {
        tag "Trimming reads..."
        container = 'docker://clinicalgenomics/trim_galore:0.6.7'
        publishDir "${baseDir}/Cache/Trimmed"
        input:
        tuple val(sample), path(reads)
        output:
        tuple val(sample), path("*_1.fq.gz"), path("*_2.fq.gz")

        script:
        """
        trim_galore --clip_R1 ${params.clip_R1} --clip_R2 ${params.clip_R2} --three_prime_clip_R1 ${params.three_prime_clip_R1} --three_prime_clip_R2 ${params.three_prime_clip_R2} --paired ${reads[0]} ${reads[1]}
        """
}
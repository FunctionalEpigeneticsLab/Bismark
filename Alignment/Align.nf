process BISMARK_ALIGN {
        tag "Aligning using Bismark..."
        publishDir "${baseDir}/Cache/Alignment/Raw"
        container = "docker://nfcore/methylseq:latest"
        input:
        path bismark_index
        tuple val(sample), path(file1), path(file2)

        output:
        path "*_bismark_bt2_pe.bam", emit: bam_files
        path "*.txt", emit: reports

        script:
        """
        bismark ${params.bismark_align} --multicore ${task.cpus} --dovetail -bam --genome $bismark_index -1 $file1 -2 $file2
        """
}
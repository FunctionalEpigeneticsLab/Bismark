process COMPUTE_ON_TARGET {
        tag "Computing on-target rate..."
        publishDir "${baseDir}/CoverageMetrics", mode: 'copy'
        container = "docker://kobedr/bismark_alignment_utils:latest"
        input:
        path regions
        path "*"

        output:
        path "*.tsv"


        script:
        """
        Rscript $baseDir/Scripts/get_on_target.r . $regions
        """
}
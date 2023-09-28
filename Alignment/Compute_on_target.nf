process COMPUTE_ON_TARGET {
        tag "Computing on-target rate..."
        publishDir "${workingDir}/CoverageMetrics", mode: 'copy'
        container = "docker://r-base"
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
process COMPUTE_ON_TARGET {
        tag "Computing on-target rate..."
        publishDir "${baseDir}/Results/Reports/${params.batch}", mode: 'copy'
        container = "docker://kobedr/bismark_alignment_biocond:latest"
        input:
        path regions
        path "*"

        output:
        path "on_target.tsv"


        script:
        """
        Rscript $baseDir/Scripts/get_on_target.r . $regions
        """
}
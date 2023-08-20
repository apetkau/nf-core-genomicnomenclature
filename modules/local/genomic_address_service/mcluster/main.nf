process GENOMIC_ADDRESS_SERVICE_MCLUSTER {
    label 'process_single'

    container 'docker.io/apetkau/genomic_address_service:latest'

    input:
    path(distance_matrix)
    val(thresholds)
    val(method)

    output:
    path("results/clusters.text")  , emit: clusters_text
    path("results/run.json")       , emit: run_json
    path("results/thresholds.json"), emit: thresholds_json
    path("results/tree.nwk")       , emit: nwk
    path "versions.yml"            , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix
    """
    gas \\
        mcluster \\
        $args \\
        --force \\
        --matrix $distance_matrix \\
        --outdir results \\
        --thresholds "$thresholds"

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
       gas_mcluster : \$(echo \$(gas mcluster --version 2>&1) | sed 's/^.*gas //' )
    END_VERSIONS
    """
}

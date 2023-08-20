process GENOMIC_ADDRESS_SERVICE_MCLUSTER {
    tag "${meta.id}"
    label 'process_low'

    container 'docker.io/apetkau/genomic_address_service:latest'

    input:
    tuple val(meta), path(distance_matrix)
    val(thresholds)

    output:
    tuple val(meta), path("*_results/clusters.text")  , emit: clusters_text
    tuple val(meta), path("*_results/distances.text") , emit: distances_text
    tuple val(meta), path("*_results/run.json")       , emit: run_json
    tuple val(meta), path("*_results/thresholds.json"), emit: thresholds_json
    tuple val(meta), path("*_results/tree.nwk")       , emit: nwk
    path "versions.yml"                               , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    """
    gas \\
        mcluster \\
        $args \\
        --force \\
        --matrix $distance_matrix \\
        --outdir "${prefix}_results" \\
        --thresholds "$thresholds"

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        gas_mcluster : \$(echo \$(gas mcluster --version 2>&1) | sed 's/^.*gas //' )
    END_VERSIONS
    """
}

process PROFILE_DISTS {
    tag "${meta.id}"
    label 'process_low'

    container 'docker.io/apetkau/profile_dists:latest'

    input:
    tuple val(meta), path(allele_profiles)

    output:
    tuple val(meta), path ("*_results/allele_map.json")   , emit: allele_map_json
    tuple val(meta), path ("*_results/query_profile.text"), emit: query_profile_text
    tuple val(meta), path ("*_results/ref_profile.text")  , emit: ref_profile_text
    tuple val(meta), path ("*_results/results.text")      , emit: distance_matrix
    path "versions.yml"                                   , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    """
    profile_dists \\
        --query $allele_profiles \\
        --ref $allele_profiles \\
        $args \\
        --force \\
        --cpus $task.cpus \\
        --outdir "${prefix}_results"

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        profile_dists : \$(echo \$(profile_dists --version 2>&1) | sed 's/^.*profile_dists //' )
    END_VERSIONS
    """
}

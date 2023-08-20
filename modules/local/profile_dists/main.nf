process PROFILE_DISTS {
    label 'process_single'

    container 'docker.io/apetkau/profile_dists:latest'

    input:
    tuple val(meta), path(allele_profiles)

    output:
    path ("*_results/allele_map.json")   , emit: allele_map_json
    path ("*_results/query_profile.text"), emit: query_profile_text
    path ("*_results/ref_profile.text")  , emit: ref_profile_text
    path ("*_results/results.text")      , emit: results_text
    path "versions.yml"                  , emit: versions

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

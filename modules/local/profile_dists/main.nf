process PROFILE_DISTS {
    label 'process_single'

    container 'docker.io/apetkau/profile_dists:latest'

    input:
    path(query_profile)
    path(reference_profile)

    output:
    path ("results/allele_map.json")   , emit: allele_map_json
    path ("results/query_profile.text"), emit: query_profile_text
    path ("results/ref_profile.text")  , emit: ref_profile_text
    path ("results/results.text")      , emit: results_text
    path "versions.yml"                , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix
    """
    profile_dists \\
        --query $query_profile \\
        --ref $reference_profile \\
        $args \\
        --force \\
        --cpus $task.cpus \\
        --outdir results

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        profile_dists : \$(echo \$(profile_dists --version 2>&1) | sed 's/^.*profile_dists //' )
    END_VERSIONS
    """
}

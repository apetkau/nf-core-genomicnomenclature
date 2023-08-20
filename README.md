# Example Nextflow nomenclature pipeline

This pipeline is an example for genomic nomenclature (using <https://github.com/phac-nml/genomic_address_service>).

If you have Nextflow and Docker installed, you can test it out with:

```bash
nextflow run apetkau/nf-core-genomicnomenclature -profile docker,test -r dev -latest --outdir results
```

Or, if you wish to use your own data:

```bash
nextflow run apetkau/nf-core-genomicnomenclature -r dev -latest -profile docker --input profilesheet.csv --outdir results
```

Here, the `profilesheet.csv` lists the cg/wgMLST profiles to cluster/generate nomenclature. The format is a CSV file that contains the columns: `id`, `profiles_format`, `allele_profiles`. An example is below (or refer to the test [profilesheet.csv](test_data/profilesheet.csv)).

**profilesheet.csv**:

| id | profiles_format | allele_profiles |
|---|---|---|
| test | tsv | allele_profiles.tsv |

Output for genomic address mcluster will be in `results/genomic/{id}_results`, which contains the output of `gas mcluster` as described at <https://github.com/phac-nml/genomic_address_service>.

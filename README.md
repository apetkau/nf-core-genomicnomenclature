# Example Nextflow nomenclature pipeline

This pipeline is an example for genomic nomenclature (using <https://github.com/phac-nml/genomic_address_service>).

If you have Nextflow and Docker installed, you can test it out with:

```bash
nextflow run https://github.com/apetkau/nf-core-genomicnomenclature -profile docker,test -r dev --outdir results
```

Or, if you wish to use your own data:

```bash
nextflow run https://github.com/apetkau/nf-core-genomicnomenclature -r dev -profile docker --samples_profile allele_profiles.tsv --outdir results --input 'https://raw.githubusercontent.com/nf-core/test-datasets/viralrecon/samplesheet/samplesheet_test_illumina_amplicon.csv'
```

Note, that the parameter of `--input` is not used right now now, but is only there until this is fixed to be used to pass the actual input data using this parameter.

Output for genomic address mcluster will be in `results/genomic/results`.

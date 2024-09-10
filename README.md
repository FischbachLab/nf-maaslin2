# nf-MaAsLin2

## Acknowledgement

This pipeline is based on the original [MaAsLin2](https://github.com/biobakery/Maaslin2) repo. Modifications have been made to make use of our infrastrucutre more readily. If you're here for details about the pipeline, please consider taking a look at the original repo.

<!--And a heatmap produced by [Hclust2](https://github.com/SegataLab/hclust2) on the MetaPhlAn2 abundance profiles.-->

## Examples
====================

### This is a MaAsLin2 pipeline for the Nextflow framework.

#### 1. Four required parameters are an input merged metaphlan file, a metadata file, a project name and a base group name

#### 2. An example input metadata file is 2-cloumn tsv file with headers
```{bash}
sample_name     group
AD8_10_1A       Tac_pre
AD8_10_3A       Jax_pre
AD8_10_1D       Tac_co
AD8_10_2D       Tac_co
AD8_10_3D       Tac_co
AD8_10_5D       Jax_co
AD8_11_1A       Tac_pre
AD8_11_1D       Tac_co
AD8_11_2D       Tac_co
AD8_11_3D       Jax_co
AD8_11_4A       Jax_pre
AD8_11_4D       Jax_co
AD8_11_5D       Jax_co
```

#### 3. An example input metaphlan abundance profiles 
```{bash}
sample_name	UNCLASSIFIED	Lactobacillus_johnsonii	GGB27876_SGB40310	Muribaculaceae_bacterium	Duncaniella_freteri	Ligilactobacillus_murinus	Adlercreutzia_muris	Adlercreutzia_caecimuris	Adlercreutzia_mucosicola
AD8_10_1A	12.42943	0.0	0.9643621890335738	0.0	2.7948849254256785	3.47154275066472	0.22291089609757747	0.7195498923805046	0.01243502150691652
(base) [ec2-user@ip-172-31-28-65 Maaslin]$ less  metaphlan_by_group2.tsv | cut -f1-10 | head -n 5
sample_name	UNCLASSIFIED	Lactobacillus_johnsonii	GGB27876_SGB40310	Muribaculaceae_bacterium	Duncaniella_freteri	Ligilactobacillus_murinus	Adlercreutzia_muris	Adlercreutzia_caecimuris	Adlercreutzia_mucosicola
AD8_10_1A	12.42943	0.0	0.9643621890335738	0.0	2.7948849254256785	3.47154275066472	0.22291089609757747	0.7195498923805046	0.01243502150691652
AD8_10_3A	19.04224	42.68327697691621	0.0	0.0	0.0	0.0	0.0	0.0	0.0
AD8_10_1D	6.65516	2.222596551686741	5.228421618666584	0.0	0.5258301300665145	3.9532844867036463	0.2390094525376891	0.03543369973962381	0.0005974069502992425
AD8_10_2D	14.100220000000002	9.299011762878296	3.6592790089581535	0.0	0.272534226109324	2.563172069940028	0.3113952857405082	0.011759679627562157	0.0
```

#### 4. An example batch job (default mode)
```{bash}
aws batch submit-job \
  --job-name nf-maaslin2 \
  --job-queue priority-maf-pipelines \
  --job-definition nextflow-production \
  --container-overrides command="FischbachLab/nf-maaslin2 \
"--project", "TEST", \
"--profiles", "awsbatch", \
"--group_name", "Tac_pre", \
"--input_path", "s3://nextflow-pipelines/nf-maaslin2/data/metaphlan_abundance_profiles.tsv", \
"--metadata", "s3://nextflow-pipelines/nf-maaslin2/data/metadata.tsv", \
"--output_path", "s3://genomics-workflow-core/Results/maaslin2" "
```

#### 5. Run on a local machine after commenting out the batch mode options and enabling the local mode
```{bash}
nextflow run main.nf --project TEST --group_name Tac_pre --input_path "s3://nextflow-pipelines/nf-maaslin2/data/metaphlan_abundance_profiles.tsv" --metadata "s3://nextflow-pipelines/nf-maaslin2/data/metadata.tsv" --profiles local
```


#### 6. The final output files:
```{bash}
s3://genomics-workflow-core/Results/maaslin2/TEST/Maaslin2_outputs/
```


<!--img src="assets/images/" width="900" height="300" /-->


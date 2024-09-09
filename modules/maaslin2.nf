/*
 * Run Sanger assembly Pipeline
 */
process Maaslin2 {
    tag "${params.group_name}"
    
    container "${params.docker_container_maaslin2}"
    cpus 2
    memory 8.GB
    
    publishDir "${params.output_path}/${params.project}/Maaslin2", mode:'copy'

    input:
     path(mp)
     path(meta)

    output:
    path "Maaslin2_outputs/*"     

    script:
    """
     /work/Maaslin2-1.7.3/R/Maaslin2.R -e 2 \
    -m ${params.ANALYSIS_METHOD} \
    --transform=${params.TRANSFORM}  \
    --standardize=${params.STANDARDIZE} \
    --reference="group,${params.group_name}" \
    ${mp} \
    ${meta} \
    Maaslin2_outputs
    """
}
/* 
*  The heatmap produced by Hclust2 on the MetaPhlAn2 abundance profiles 
*  TODO -- need to combine MP profile and metadata files into one input file
*/
process hclust2 {
    tag "${params.group_name}"
    
    //container 'fischbachlab/nf-sanger:latest'
    container "${params.docker_container_hclust2}"
    cpus 8
    memory 16.GB
    
    publishDir "${params.output_path}/${params.project}"/hclust2, mode:'copy'

    input:
    
    output:
    path "*"     

    script:
    """
    hclust2.py \
		-i merged_metaphlan_abundance_species.tsv \
		-o heatmap_metaphlan_abundance_profiles_by_groups.png \
		--metadata_rows 1 \
		--ftop 30 \
		--f_dist_f correlation \
		--s_dist_f braycurtis \
		--cell_aspect_ratio 1 \
		--log_scale \
		--flabel_size 4 \
		--slabel_size 4 \
		--max_flabel_len 30 \
		--max_slabel_len 30 \
		--metadata_height 0.1 \
		--metadata_separation 0.01 \
		--minv 0.01 \
		--dpi 600 \
		--colorbar_font_size 6 \
        --slinkage complete \
        --flinkage complete \
		--title ${params.project}
        --legend_file legend_${params.project}.png


    """
}

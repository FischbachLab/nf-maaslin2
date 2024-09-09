#!/usr/bin/env nextflow
nextflow.enable.dsl=2

include { Maaslin2;} from './modules/maaslin2'

// If the user uses the --help flag, print the help text below
params.help = false

// Function which prints help message text
def helpMessage() {
    log.info"""
    Run the Sanger assembly and annotatin pipeline for sanger reads

    Required Arguments:
      --input_path    s3 path to input merged metaphlan file
      --metadata      s3 path to metadata file
      --project       assigned project name
      --group_name    the base group name              
      --output_path   output_s3_path

    Options:
      -profile        docker      run locally


    """.stripIndent()
}

// Show help message if the user specifies the --help flag at runtime
if (params.help){
    // Invoke the function above which prints the help message
    helpMessage()
    // Exit out and do not run anything else
    exit 0
}

if (params.input_path == "null") {
	exit 1, "Missing the input path"
}

if (params.project == "null") {
	exit 1, "Missing the project name"
}

if (params.metadata == "null") {
	exit 1, "Missing the metadata file"
}

if (params.group_name == "null") {
	exit 1, "Missing the base group name"
}

/*
 * Defines the pipeline inputs parameters (giving a default value for each for them)
 * Each of the following parameters can be specified as command line options
 */

workflow {

    input_mp = Channel
                    .fromPath(params.input_path, checkIfExists:true) //("$baseDir/data/metaphlan_abundance_profiles.tsv")
                    .ifEmpty { exit 1, "Cannot find the input metaphlan file" }
                    //.view()

    input_metadata = Channel
                    .fromPath(params.metadata, checkIfExists:true)  //("$baseDir/data/metadata.tsv"))
                    .ifEmpty { exit 1, "Cannot find the input meatadata file" }
                    //.view()
    //display metadata
    //println file(params.metadata).text


    Maaslin2(input_mp, input_metadata)

    //hclust2 (input_mp, input_metadata)

}

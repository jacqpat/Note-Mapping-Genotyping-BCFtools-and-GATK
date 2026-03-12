#!/bin/bash
#SBATCH -J eagar_ug_mito_anguilla
#SBATCH -p workq

module purge
module load bioinfo/NextflowWorkflows/nfcore-Nextflow-v21.10.6
module load containers/singularity/3.9.9

path_to_input=""
path_to_fasta=""
name_of_fasta=""
name_of_index=""
name_of_sqdic=""
path_to_confg=""
name_of_confg=""
nextflow run nf-core/eager --input '${path_to_input}/*.bam' \
                           --fasta '${path_to_fasta}/${name_of_fasta}' \
			   --fasta_index '${path_to_fasta}/${name_of_index}' \
			   --seq_dict '${path_to_fasta}/${name_of_sqdic}' \
			   -c '${path_to_confg}/${name_of_confg}' \
			   -profile genotoul \
			   --bam \
			   --single_end \
			   --skip_fastqc \
			   --skip_adapterremoval \
			   --skip_preseq \
			   --run_genotyping \
			   --genotyping_tool 'hc' \
			   --genotyping_source 'raw' \
			   --gatk_hc_out_mode 'EMIT_VARIANTS_ONLY' \
			   --gatk_hc_emitrefconf 'GVCF' \
			   --run_bcftools_stats \
			   --outdir '04_GENOTYPING/03_all_mito'
#			   -resume

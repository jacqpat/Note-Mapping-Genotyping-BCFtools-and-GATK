#!/bin/bash

#SBATCH -J eager_Ssal_rescaled
#SBATCH -p workq

module purge
module load bioinfo/NextflowWorkflows/nfcore-Nextflow-v21.10.6
module load containers/singularity/3.9.9

path_to_file=""
path_to_ref=""
path_to_config=""
name_of_file="" # FASTQ.gz. Example if you have both forward and reverse reads: *{1,2}*.fastq.gz
name_of_ref="" # .fa (or FASTA, etc.)
name_of_idx="" # .fa.fai
name_of_seq="" # .dict
name_of_config="" # .config


nextflow run nf-core/eager --input '${path_to_file}/${name_of_file}' \
			   --single_end \
         --fasta '${path_to_ref}/${name_of_ref}' \
			   --fasta_index '${path_to_ref}/${name_of_idx}' \
			   --seq_dict '${path_to_ref}/${name_of_seq}' \
         -c '${path_to_config}/${name_of_config}' \
			   --outdir './' \
			   -profile genotoul \
			   --skip_fastqc \
			   --skip_adapterremoval \
			   --skip_preseq \
			   --clip_readlength 25 \
			   --mapper 'bwamem'
#			   -resume

# NOTE:
# bwa aln is the default mapper
# remove --single_end if you have both forward and reverse reads.
# remove "fasta_index" and "seq_dict" if no index and dict of seq.
# add "bwa_index" if you have one (ex: if you've already run EAGER)
# "resume" is an option to use if there was an error and you want to restart where you were.
# "profile" give configuration presets for different compute environments. Here: the genotoul. See documentation for more info.
#
# to keep discarded unmapped reads for later, do:
# --run_bam_filtering
# --bam_unmapped_type "bam"

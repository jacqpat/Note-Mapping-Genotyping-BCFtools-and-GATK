#!/bin/bash

#SBATCH --j gatk_genomicDB
#SBATCH --cpus-per-task=1
#SBATCH --mem 10G

module load devel/python/Python-3.11.1
module load devel/java/17.0.6
module load bioinfo/GATK/4.4.0.0

# The sample map is a tab-delimited text fiel with sample_name -- tab -- path_to_sample_vcf per line.
# Using a sample map saves the tool from having to download the GVCF headers in order to determine the sample names.
# Sample names in the sample name map file may have non-tab whitespace, but may not begin or end with whitespace.
path_db=""
map=""
int="" # either a specific chromosome name or a file listing chromosomes (one per line)
tmp=""
# Provide sample GVCFs in a map file.
gatk GenomicsDBImport --genomicsdb-workspace-path $path_db --batch-size 100 -L $int --sample-name-map $map --tmp-dir $tmp #--reader-threads
# Option -L to add specific chromosome you want to study (ex. -L 'NC_002333.2')

# Once it is done, to get a VCF file run something like:
# gatk GenotypeGVCFs -R 00_REF/Salmo_trutta_mitochondrion_NC_024032.fa -V gendb://02_ANCIENT_SALMO_TRUTTA_DATABASE -G StandardAnnotation -O test_output_salmo_trutta.vcf

# UPDATE MODE !!!
#gatk GenomicsDBImport --genomicsdb-update-workspace-path "05_DATABASE/DART_6711" --batch-size 50 --sample-name-map $map --tmp-dir './tmp/'

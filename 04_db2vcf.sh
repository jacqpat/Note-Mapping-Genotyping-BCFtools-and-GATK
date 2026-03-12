#!/bin/bash

#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem 10G

module load devel/python/Python-3.11.1
module load devel/java/17.0.6
module load bioinfo/GATK/4.4.0.0

refrnce="./Anguilla_anguilla_mitochondrion_NC_006531.fa"
databse="05_DATABASE/DART_ALL_MITO"
outfile="06_VCF_FINAL/Aang_all_DART_mito.vcf.gz"
gatk GenotypeGVCFs -R $refrnce -V gendb://$databse -G StandardAnnotation -O $outfile

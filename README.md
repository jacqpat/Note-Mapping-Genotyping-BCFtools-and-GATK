# Note-Mapping-Genotyping-BCFtools-and-GATK
Quick personal notes and a script for mapping and genotyping using BCFTools and/or GATK

# Mapping
## Getting Started
First off, we need our sequenced samples (preferably format FASTQ) and our reference genome (format FASTA).
We will assume hereafter that we are 100% sure our samples are from the reference species.

Then, we need the **Burrow-Wheeler Aligner** (BWA) package. First we have to index our reference genome because otherwise BWA won't work.
Personally, I use **Samtools** (samtools faidx) but it's also possible to use BWA for indexing as well (BWA index).
Take the time to create a **sequence dictionary** that will be helpful later on.
We need **GATK** to do so.

`gatk CreateSequenceDictionary -R our-reference.fa -O our-reference.dict`

Githubs of our tools:
- BCFtools: https://github.com/samtools/bcftools?tab=readme-ov-file
- Samtools:
- BWA: https://github.com/lh3/bwa
- 

## (Optional) Seqkit
Before aligning your sequences, it's good practice to remove reads that are too short to be really useful.
It's a way to avoid issue such as chimera: contigs assembled from reads that actually come from widely different places in the genome.

`seqtk seq -L 25 one-of-our-samples.fastq.gz | one-of-our-samples.fastq`

## BWAmem
To align modern samples, we use BWAmem and Samtools. Samtools index expect a file as parameter, not a piped input.
So for ease of use, let us simply create intermediary files (do not forget to delete them if they're still up).

`bwa mem -t 4 our-reference.fa one-of-our-samples.fastq.gz | samtools view -b | samtools sort -o one-of-our-samples.mapped.sorted.bam && samtools index one-of-our-samples.mapped.sorted.bam`

With -t 4 the number of threads. To be adapted.

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

## BWAmem
To align modern samples, we use BWAmem and Samtools. Samtools index expect a file as parameter, not a piped input.
So for ease of use, let us simply create intermediary files (do not forget to delete them if they're still up).

`bwa mem our-reference.fa one-of-our-samples.fastq.gz | samtools view -b | samtools sorted -o `



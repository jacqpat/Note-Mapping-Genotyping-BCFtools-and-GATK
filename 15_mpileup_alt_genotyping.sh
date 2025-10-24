#!/bin/bash

module load bioinfo/Bcftools/1.17

ulimit -n 2048 # changed ulimit because we had a lot of bam files.

bam="list_all_bam.txt"
ref=""
out=""
bcftools mpileup -f $ref -b $bam -q 20 -Q 20 -Ou | bcftools call -mv -Oz -o $out

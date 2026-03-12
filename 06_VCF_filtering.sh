#!/bin/bash

vcf=""
out=""
bcftools view --types snps -m 2 -M 2 $vcf -Ou | bcftools filter -i 'QUAL >= 30 && DP >= 5' -Oz -o $out

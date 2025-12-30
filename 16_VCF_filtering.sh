#!/bin/bash

vcf=""
out=""
bcftools filter -i 'QUAL >= 30 && DP >= 5' $vcf -Oz -o $out

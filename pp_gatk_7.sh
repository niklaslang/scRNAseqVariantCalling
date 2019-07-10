#!/bin/bash

#SBATCH --ntasks=8
#SBATCH --mem=20000

for file in *-1.bam.snp.vcf ; do
  sbatch --export=file=$file sc_gatk_7.sh
done

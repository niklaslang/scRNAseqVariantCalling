#!/bin/bash

#SBATCH --ntasks=8
#SBATCH --mem=20000

for file in *-1.bam; do
  sbatch --export=file=$file sc_picard_4.sh
done

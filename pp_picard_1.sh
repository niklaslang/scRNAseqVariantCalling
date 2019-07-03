#!/bin/bash

#SBATCH --ntasks=8
#SBATCH --mem=20000

#nota bene: BamCleave output will be one [XYZ]_rest.bam as well as N [XYZ]_sel_[barcode-sequence]-1.bam each representing one of N cells. Hence, we only loopp over the *-1.bam files.

for file in *-1.bam; do
  sbatch --export=file=$file sc_picard_1.sh
done

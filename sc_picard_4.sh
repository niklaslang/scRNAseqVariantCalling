#!/bin/bash

#presets

#SBATCH --ntasks=8
#SBATCH --mem=20000

#picard - presets

inDir=/PATH/TO/picard_2

outDir=/PATH/TO/results/picard/picard_4

mkdir $outDir

#picard 4 - sort BAM File

#sorts the input BAM file by coordinate

java -jar PATH/TO/picard.jar SortSam \
I=$inDir/$file  \
O=$outDir/$file  \
SORT_ORDER=coordinate \
TMP_DIR=/PATH/TO/tmpDir \
CREATE_INDEX=TRUE

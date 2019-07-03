#!/bin/bash

#presets

#SBATCH --ntasks=8
#SBATCH --mem=20000

#picard - presets

inDir=/PATH/TO/results/picard/picard_1

outDir=/PATH/TO/results/picard/picard_2

mkdir $outDir

#picard_2 - mark duplicates

#locates and tags duplicate reads in a BAM file (duplicate reads are defined as originating from a single fragment of DNA)

java -jar /PATH/TO/picard.jar MarkDuplicates \
I=$inDir/$file \
O=$outDir/$file \
CREATE_INDEX=true \
VALIDATION_STRINGENCY=SILENT \
M=$outDir/${file}.marked_dup_metrics.txt

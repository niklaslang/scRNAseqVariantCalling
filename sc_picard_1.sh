#!/bin/bash

#presets

#SBATCH --ntasks=8
#SBATCH --mem=20000

#picard - presets

inDir=/PATH/TO/BamCleave/OUPUT

outDir=/PATH/TO/results/picard/picard_1

mkdir $outDir

#picard_1 - AddOrReplaceReadGroups

#GATK expects all read groups appearing in the read data to be specified in the file header

java -jar /PATH/TO/picard.jar AddOrReplaceReadGroups \
I=$inDir/$file \
O=$outDir/$file \
SORT_ORDER=coordinate \
RGID=$file \
RGLB=Homo_sapiens \
RGPL=illumina \
RGPU=$file \
RGSM=$file

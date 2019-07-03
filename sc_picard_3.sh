#!/bin/bash

#presets

#SBATCH --ntasks=8
#SBATCH --mem=20000

#picard - presets

inDir=/PATH/TO/results/picard/picard_2

outDir=/PATH/TO/results/picard/picard_3

mkdir $outDir

#picard_3 - build BAM index

#creates an index file for the input BAM file that allows quick look-up of data in the BAM file

java -jar /PATH/TO/picard.jar BuildBamIndex \
I=$inDir/$file \
TMP_DIR=/PATH/TO/tmpDir

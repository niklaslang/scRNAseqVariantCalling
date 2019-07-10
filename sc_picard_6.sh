#!/bin/bash

#presets

#SBATCH --ntasks=8
#SBATCH --mem=20000

#picard - presets

inDir=/PATH/TO/results/picard/picard_4

outDir=/PATH/TO/results/picard/picard_6

mkdir $outDir

fastaDir=/PATH/TO/data/reference_genome/Homo_sapiens.GRCh38.dna.primary_assembly.fa

#picard 6 - ReorderSam

#reorders reads according to reference genome

java -jar /PATH/TO/picard.jar ReorderSam \
I=$inDir/$file \
O=$outDir/$file \
REFERENCE=$fastaDir \
CREATE_INDEX=TRUE

#!/bin/bash

#SBATCH --ntasks=8
#SBATCH --mem=20000

#picard - presets

inDir=/work/project/becstr_006/Clustering_SNV/results/picard/picard_4

outDir=/work/project/becstr_006/Clustering_SNV/results/picard/picard_6

mkdir $outDir

fastaDir=/work/project/becstr_006/Clustering_SNV/data/reference_genome/Homo_sapiens.GRCh38.dna.primary_assembly.fa

#picard 6 - order reads according to a reference genome

java -jar /work/project/becstr_006/Clustering_SNV/picard/build/libs/picard.jar ReorderSam \
I=$inDir/$file \
O=$outDir/$file \
REFERENCE=$fastaDir \
CREATE_INDEX=TRUE

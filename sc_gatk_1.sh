#!/bin/bash

#SBATCH --mem=20000
#SBATCH --ntasks=16

#load anaconda

module load Anaconda3/4.3.1

#presets

inDir=/PATH/TO/results/picard/picard_6

outDir=/PATH/TO/results/gatk/gatk_1

mkdir $outDir

refDir=/PATH/TO/data/reference_genome/Homo_sapiens.GRCh38.dna.primary_assembly.fa

#pre-gatk - SplitNCigarReads

java -jar /PATH/TO/gatk3.8/GenomeAnalysisTK.jar \
   -T SplitNCigarReads \
   -I $inDir/$file \
   -o $outDir/$file \
   -R $refDir \
   -rf ReassignOneMappingQuality \
   -RMQF 255 \
   -RMQT 60 \
   -U ALLOW_N_CIGAR_READS

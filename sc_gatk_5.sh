#!/bin/bash

#SBATCH --mem=24000
#SBATCH --ntasks=16

#load anaconda and GATK

module load Anaconda3/4.3.1

#preset paths

inDir=/PATH/TO/results/gatk/gatk_3

outDir=/PATH/TO/results/gatk/gatk_5

mkdir $outDir

refDir=/PATH/TO/data/reference_genome/Homo_sapiens.GRCh38.dna.primary_assembly.fa

#gatk 5 - PrintReads

java -jar /PATH/TO/gatk3.8/GenomeAnalysisTK.jar \
    -T PrintReads \
    -I $inDir/$file \
    --out $outDir/$file \
    -R $refDir \
    -BQSR $inDir/${file}.recal_data.csv \
    -nct 20

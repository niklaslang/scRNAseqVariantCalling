#!/bin/bash

#SBATCH --ntasks=16
#SBATCH --mem=240000

#load anaconda and GATK

module load Anaconda3/4.3.1

#preset paths

inDir=/PATH/TO/results/gatk/gatk_3

refDir=/PATH/TO/reference_genome/Homo_sapiens.GRCh38.dna.primary_assembly.fa

vcfDir=/PATH/TO/data/indel_calls/00-All.sorted.vcf

#gatk 4 - BaseRecalibrator

java -jar /PATH/TO/gatk3.8/GenomeAnalysisTK.jar \
    -T BaseRecalibrator \
    -I $inDir/$file \
    -o $inDir/${file}.recal_data.csv \
    -R $refDir \
    -nct 20 \
    -knownSites $vcfDir \

#!/bin/bash

#SBATCH --mem=160000
#SBATCH --ntasks=16

#load anaconda and GATK

module load Anaconda3/4.3.1

#preset paths

inDir=/PATH/TO/results/gatk/gatk_1

outDir=/PATH/TO/results/gatk/gatk_3

refDir=/PATH/TO/data/reference_genome/Homo_sapiens.GRCh38.dna.primary_assembly.fa

vcfDir=/PATH/TO/data/indel_calls/00-All.sorted.vcf

#gatk 3 - IndelRealigner

java -jar /PATH/TO/gatk3.8/GenomeAnalysisTK.jar \
    -T IndelRealigner \
    -I $inDir/$file \
    -o $outDir/$file \
    -targetIntervals $inDir/${file}.ALLforIndelRealigner.intervals \
    -R $refDir

#!/bin/bash

#SBATCH --mem=200000
#SBATCH --ntasks=16

#load anaconda and GATK

module load Anaconda3/4.3.1

#preset paths

inDir=/PATH/TO/results/gatk/gatk_6

outDir=/PATH/TO/results/gatk/gatk_7/$file

mkdir $outDir

refDir=/PATH/TO/data/reference_genome/Homo_sapiens.GRCh38.dna.primary_assembly.fa

#gatk 7 - VariantFiltration

java -jar /PATH/TO/gatk3.8/GenomeAnalysisTK.jar \
    -T VariantFiltration \
    -V $inDir/$file \
    -o $outDir/snv_filtered.vcf \
    -R $refDir \
    -cluster 3 \
    --filterExpression "FS > 30.0" \
    --filterName "FS" \
    --filterExpression "QD < 2.0" \
    --filterName "QD"

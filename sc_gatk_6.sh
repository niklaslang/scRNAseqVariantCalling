#!/bin/bash

#SBATCH --mem=24000
#SBATCH --ntasks=16

#load anaconda and GATK

module load Anaconda3/4.3.1

#preset paths

inDir=/PATH/TO/results/gatk/gatk_5

outDir=/PATH/TO/results/gatk/gatk_6

refDir=/PATH/TO/data/reference_genome/Homo_sapiens.GRCh38.dna.primary_assembly.fa

vcfDir=/PATH/TO/data/indel_calls/00-All.sorted.vcf

#gatk 6 - Variant Calling

java -jar /PATH/TO/gatk3.8/GenomeAnalysisTK.jar \
    -T HaplotypeCaller \
    -I $inDir/$file \
    -o $outDir/${file}.snp.vcf \
    -R $refDir \
    --dbsnp $vcfDir \
    -dontUseSoftClippedBases \

#!/bin/bash

#SBATCH --mem=50000
#SBATCH --ntasks=16

#load anaconda

module load Anaconda3/4.3.1

#preset paths

inDir=/PATH/TO/results/gatk/gatk_1

refDir=/PATH/TO/data/reference_genome/Homo_sapiens.GRCh38.dna.primary_assembly.fa

vcfDir=/PATH/TO/data/indel_calls/00-All.sorted.vcf

#gatk 2 - RealignerTargetCreator

java -jar /PATH/TO/gatk3.8/GenomeAnalysisTK.jar \
    -T RealignerTargetCreator \
    -I $inDir/$file \
    --known $vcfDir \
    -o $inDir/${file}.ALLforIndelRealigner.intervals \
    -R $refDir \
    -nt 16

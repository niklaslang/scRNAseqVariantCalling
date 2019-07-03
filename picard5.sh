#!/bin/bash

#presets

#SBATCH --mem=240000
#SBATCH --ntasks=16

#picard - presets

fastaDir=/PATH/TO/data/reference_genome/Homo_sapiens.GRCh38.dna.primary_assembly.fa

dictDir=/PATH/TO/data/reference_genome/Homo_sapiens.GRCh38.dict

mkDir $dictDir

#download FASTA File

cd $dictDir

wget -c ftp://ftp.ensembl.org/pub/release-96/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz

gunzip Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz

#generate FASTA index file

module load ngs/samtools/1.9

samtools faidx $fastaDir

#picard_5 - create sequence dictionary

#nota bene: FASTA File and sequence dictionary must be located in the same folder!

java -jar /PATH/TO/picard.jar CreateSequenceDictionary \
R=$fastaDir \
O=$dictDir \

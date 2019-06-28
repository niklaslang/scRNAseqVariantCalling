#!/bin/bash

#presets

#SBATCH --mem=240000
#SBATCH --ntasks=16

#load CellRanger

module load ngs/cellranger/2.1.1

#perform alignement

#nota bene no.1 : memory above (SLURM) is specified in MB, the memory below (CellRanger) is specified in GB!

#nota bene no.2 : input samples - either multiple comma seperated samplenames (as seen below) or cellranger specific sample sheets (which didn't worked when I tried)

#nota bene no.3 : path to transcriptome reference on BMC cluster

cellranger count --fastqs=./data/gold \
--sample=SRR6782109,SRR6782110,SRR6782111,SRR6782112 \
--id=gold \
--transcriptome=/work/data/10xGenomes/refdata-cellranger-GRCh38-1.2.0 \
--expect-cells=1200 \
--localmem=240 \

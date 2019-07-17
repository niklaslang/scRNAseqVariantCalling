#!/bin/bash

#SBATCH --ntasks=16
#SBATCH --mem=20000

#featureCounts - presets

#each cell must have a distinct GE expression profile file with a unique name (e.g. counts.txt) inside a unique folder, specific of the cell. Hence, we create a new unique folder for every input file

gtfDir=/work/data/genomes/human/Homo_sapiens/NCBI/GRCh38/Annotation/Genes/genes.gtf

inDir=/PATH/TO/BamCleave/OUPUT/$file

outDir=/PATH/TO/results/counts/$file

mkdir $outDir

#calculate gene expression matrix

/work/project/becstr_006/subread/bin/featureCounts -p -B -C -M --primary -T 16 \
-t  exon \
-g gene_id \
-a $gtfDir \
-o $outDir/counts.txt \
$inDir

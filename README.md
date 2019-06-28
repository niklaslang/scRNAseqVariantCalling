# scRNAseqVariantCalling

## Computation Pipeline

This pipeline aims to perform variant calling at the single cell level with the ultimate goal to receive one VCF file per cell as well as binary n_cell x n_snv matrix.

It consists of four subsequent main steps:

- align reads to a reference transcriptome using CellRanger

- split the BAM File into single cell specific BAM Files using bamCleave

- perform individual variant calling on theses single cell specific BAM Files using the Picard Toolkit and GATK

- compute a binary n_cell x n_snv matrix using SSrGE

A more detailed flowchart of the whole pipeline is provided below. It p

## Flowchart



##Requirements

- CellRanger version 2.1.1

- BamCleave: https://warwick.ac.uk/fac/sci/systemsbiology/staff/dyer/software/bamcleave/

- featureCounts (included in the subread package): http://subread.sourceforge.net/

- Picard Toolkit version 2.20.2:  http://broadinstitute.github.io/picard/

- GATK version 3.8: https://software.broadinstitute.org/gatk/

- SSrGE: https://github.com/lanagarmire/SSrGE

##Step by Step

### 1. Alignment

- CellRanger version 2.1.1

- script: [alignment.sh](https://github.com/niklaslang/scRNAseqVariantCalling/blob/master/alignment.sh)

Alignment of the FASTQ Files using CellRanger version 2.1.1

### 2. Splitting BAM Files

- BamCleave: https://warwick.ac.uk/fac/sci/systemsbiology/staff/dyer/software/bamcleave/

- script: [BamCleave.sh] (https://github.com/niklaslang/scRNAseqVariantCalling/blob/master/BamCleave.sh)
Splitting BAM files (CellRanger output) into single cell specific BAM files based on barcodes.
This means one BAM file per cell.

BamCleave identifies cells by the cell barcodes within the BAM file. Since there are far more cell barcodes than actual cells, BAM Cleave asks you to specify the number of cells N in advance. BamCleave then reads through the BAM file to find the N cell barcodes with the most reads and then creates one BAM files for each of those N barcodes.
Here, we simply use the number of cells estimated by CellRanger (therefore, see the web_summary.html in the CellRanger output folder).

### 3. Calculating Gene Expression Matrix

- featureCounts (included in the subread package): http://subread.sourceforge.net/

### 4. Preprocessing BAM Files

- Picard Toolkit version 2.20.2:  http://broadinstitute.github.io/picard/

### 5. Realignment and Recalibration

- GATK version 3.8: https://software.broadinstitute.org/gatk/

### 6. Variant Callling

- GATK version 3.8: https://software.broadinstitute.org/gatk/

### 7. Computing n_cell x n_snv matrix

- SSrGE: https://github.com/lanagarmire/SSrGE

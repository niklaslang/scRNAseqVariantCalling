# scRNAseqVariantCalling

# Procedere

# Flowchart

# 1. Alignment

- CellRanger version 2.1.1

Alignment of the FASTQ Files using CellRanger version 2.1.1

# 2. Splitting BAM Files

- BamCleave: https://warwick.ac.uk/fac/sci/systemsbiology/staff/dyer/software/bamcleave/

Splitting BAM files (CellRanger output) into single cell specific BAM files based on barcodes.
This means one BAM file per cell.

BamCleave identifies cells by the cell barcodes within the BAM file. Since there are far more cell barcodes than actual cells, BAM Cleave asks you to specify the number of cells N in advance. BamCleave then reads through the BAM file to find the N cell barcodes with the most reads and then creates one BAM files for each of those N barcodes.
Here, we simply use the number of cells estimated by CellRanger (therefore, see the web_summary.html in the CellRanger output folder).

# 3. Calculating Gene Expression Matrix

- featureCounts (included in the subread package): http://subread.sourceforge.net/

# 4. Preprocessing BAM Files

- Picard Toolkit version 2.20.2:  http://broadinstitute.github.io/picard/

# 5. Realignment and Recalibration

- GATK version 3.8: https://software.broadinstitute.org/gatk/

# 6. Variant Callling

- GATK version 3.8: https://software.broadinstitute.org/gatk/

# 7. Computing cell x SNV matrix

- SSrGE: https://github.com/lanagarmire/SSrGE

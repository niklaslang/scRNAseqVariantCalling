# scRNAseqVariantCalling

## Computation Pipeline

This pipeline aims to perform variant calling at the single cell level with the ultimate goal of one VCF file per cell as well as binary n_cell x n_snv matrix.

It consists of four subsequent main steps:

- align reads to a reference transcriptome using CellRanger (step 1)

- split the BAM File into single cell specific BAM Files using bamCleave (step 2 and 3)

- perform individual variant calling on each of the single cell specific BAM Files using the Picard Toolkit and GATK (step 5)

- compute a binary n_cell x n_snv matrix using SSrGE (step 6)


Our pipeline is in large parts based on the GATK Good Practices for Variant Calling in RNAseq, which can be found [here](https://gatkforums.broadinstitute.org/wdl/discussion/3891/calling-variants-in-rnaseq).
Please note that the GATK Good Practices haven't been updated since 01/2017 and that there might be more recent and/or more accurate SNV Callers for scRNAseq datasets. We therefore strongly recommend you to keep an eye on new developments/tools in the field in order to ensure you receive the best results possible.

Further, we are well aware of the limitations of calling variants from 10X reads (10X uses polyA enrichment - as a result of this you will be mainly sequencing around the Target Enrichment Site (TES), which limits the significance of your findings). However, our focus was not to obtain every single significant SNV, but rather to obtain some cell specific SNVs which could prove useful for further analysis (such as clustering or determining tumor heterogeneity).

## Requirements

- CellRanger version 2.1.1

- BamCleave: https://warwick.ac.uk/fac/sci/systemsbiology/staff/dyer/software/bamcleave/

- Picard Toolkit version 2.20.2:  http://broadinstitute.github.io/picard/

- samtools version 1.9: https://github.com/samtools/

- GATK version 3.8: https://software.broadinstitute.org/gatk/

- SSrGE: https://github.com/lanagarmire/SSrGE


## Step by Step


### 1. Alignment

- CellRanger version 2.1.1

- script: [alignment.sh](https://github.com/niklaslang/scRNAseqVariantCalling/blob/master/alignment.sh)

Alignment of the FASTQ Files using CellRanger version 2.1.1

**CAVE:** Before starting the Alignment you should carefully decide which annotation of the reference genome/transcriptome (Ensembl, NCBI or UCSC) you choose since the number and quality of publicly available and compatible VCF Files, varies greatly among them.

Here, we use GRCh38 (NCBI) with the [variation sets provided by the NCBI](ftp://ftp.ncbi.nih.gov/snp/organisms/human_9606/VCF/)
GATK, however, recommends to you to use the Mills indels or 1KG indels variation sets, which are available through the [GATK Resource Bundle](https://software.broadinstitute.org/gatk/download/bundle) - but only for builds b36, b37, hg18, hg19 and hg38.

More information on which known variant sets to use for which tool can be found [here](https://gatkforums.broadinstitute.org/gatk/discussion/1247/what-should-i-use-as-known-variants-sites-for-running-tool-x).


### 2. Splitting BAM Files

- BamCleave: https://warwick.ac.uk/fac/sci/systemsbiology/staff/dyer/software/bamcleave/

- script: [bamCleave.sh](https://github.com/niklaslang/scRNAseqVariantCalling/blob/master/bamCleave.sh)

Splitting BAM files (CellRanger output) into single cell specific BAM files based on barcodes.
This means one BAM file per cell.

BamCleave identifies cells by the unique cell barcodes within the BAM file. Since there are far more cell barcodes than actual cells, BAM Cleave asks you to specify the number of cells N in advance. BamCleave then reads through the BAM file to find the N cell barcodes with the most reads and then creates one BAM file for each of those N barcodes.
Here, we simply use the number of cells estimated by CellRanger (see the web_summary.html in the CellRanger output folder).


### 3. Preprocessing BAM Files

- Picard Toolkit version 2.20.2:  http://broadinstitute.github.io/picard/

Preprocessing the the BAM Files is far more complex than the previous steps. Even though there's no problem in running all these steps from within one script, the steps vary greatly in terms of runtime and memory requirements. For this reason, we provide a separate script for each step.

Also, we recommend parallel processing for these (and all of the following) steps.
We therefore provide two scripts for each step:

- pp_picard_n.sh: looping over all single cell BAM Files in the input folder and executing sc_picard_n.sh once for every single cell specific BAM File

- sc_picard_n.sh: executing the actual Picard tool required for the respective step

All you have to do is to run the pp_picard_n.sh since it initiates the parallel processing of all BAM Files

In order to ensure that everything runs smoothly, you have to MAKE SURE that the input files, the pp_picard_n.sh as well as the sc_picard_n.sh for each step are ALL IN THE SAME FOLDER.

#### 3.1 Picard AddOrReplaceReadGroups

- parallel processing script: [pp_picard_1.sh](https://github.com/niklaslang/scRNAseqVariantCalling/blob/master/pp_picard_1.sh)
- picard script: [sc_picard_1.sh](https://github.com/niklaslang/scRNAseqVariantCalling/blob/master/sc_picard_1.sh)

#### 3.2 Picard MarkDuplicates

- parallel processing script: [pp_picard_2.sh](https://github.com/niklaslang/scRNAseqVariantCalling/blob/master/pp_picard_2.sh)
- picard script: [sc_picard_2.sh](https://github.com/niklaslang/scRNAseqVariantCalling/blob/master/sc_picard_2.sh)

#### 3.3 Picard BuildBamIndex

- parallel processing script: [pp_picard_3.sh](https://github.com/niklaslang/scRNAseqVariantCalling/blob/master/pp_picard_3.sh)
- picard script: [sc_picard_3.sh](https://github.com/niklaslang/scRNAseqVariantCalling/blob/master/sc_picard_3.sh)

#### 3.4 Picard SortSam

- parallel processing script: [pp_picard_4.sh](https://github.com/niklaslang/scRNAseqVariantCalling/blob/master/pp_picard_4.sh)
- picard script: [sc_picard_4.sh](https://github.com/niklaslang/scRNAseqVariantCalling/blob/master/sc_picard_4.sh)

**CAVE:** MAKE SURE pp_picard_4.sh and sc_picard_4.sh ARE IN THE SAME FOLDER as pp_picard_3.sh and sc_picard_3.sh, since they have identical input files.

#### 3.5 Picard CreateSequenceDictionary

- picard script: [sc_picard_5.sh](https://github.com/niklaslang/scRNAseqVariantCalling/blob/master/sc_picard_5.sh)

This step does not build upon the previous steps. Its output, the sequence dictionary, is required as input for the next step ReorderSam. Hence, we suggest to create the sequence dictionary between at this point.

We provide additional code for downloading and indexing the reference genome (GRCh38). These steps are only necessary, if

- you cannot write to the path of the reference genome (FASTA File and sequence dictionary must be located in the same folder!)
- your reference genome is not indexed yet

#### 3.6 Picard ReorderSam

- parallel processing script: [pp_picard_6.sh](https://github.com/niklaslang/scRNAseqVariantCalling/blob/master/pp_picard_6.sh)
- picard script: [sc_picard_6.sh](https://github.com/niklaslang/scRNAseqVariantCalling/blob/master/sc_picard_6.sh)

### 4. Realignment and Recalibration

- GATK version 3.8: https://software.broadinstitute.org/gatk/

**CAVE:** make sure you work with GATK version 3.8 since there are substantial syntax changes between versions 3.x and 4.x!

The following steps vary greatly in terms of runtime and memory requirements. THE memory parameter specified at the very beginning of each script you provide you with a glimpse idea of the memory dimensions required for the respective steps.

Analog to step 3, we provide recommend parallel propcessing for these (and all of the following) steps and provide two scripts, pp_gatk_n.sh and sc_gatk_n.sh, for each of the n steps.

Again, you have to MAKE SURE that the input files, the pp_picard_n.sh as well as the sc_picard_n.sh for each step are ALL IN THE SAME FOLDER.

#### 4.1 SplitNCigarReads

- parallel processing script:[pp_gatk_1.sh](https://github.com/niklaslang/scRNAseqVariantCalling/blob/master/pp_gatk_1.sh)
- gatk script: [sc_gatk_1.sh](https://github.com/niklaslang/scRNAseqVariantCalling/blob/master/sc_gatk_1.sh)

#### 4.2 RealignerTargetCreator

- parallel processing script:[pp_gatk_2.sh](https://github.com/niklaslang/scRNAseqVariantCalling/blob/master/pp_gatk_2.sh)
- gatk script: [sc_gatk_2.sh](https://github.com/niklaslang/scRNAseqVariantCalling/blob/master/sc_gatk_2.sh)

#### 4.3 IndelRealigner

- parallel processing script:[pp_gatk_3.sh](https://github.com/niklaslang/scRNAseqVariantCalling/blob/master/pp_gatk_3.sh)
- gatk script: [sc_gatk_3.sh](https://github.com/niklaslang/scRNAseqVariantCalling/blob/master/sc_gatk_3.sh)

**CAVE:** MAKE SURE pp_gatk_3.sh and sc_gatk_3.sh ARE IN THE SAME FOLDER as pp_gatk_2.sh and sc_gatk_2.sh, since they have identical input files.

#### 4.4 BaseRecalibrator

- parallel processing script:[pp_gatk_4.sh](https://github.com/niklaslang/scRNAseqVariantCalling/blob/master/pp_gatk_4.sh)
- gatk script: [sc_gatk_4.sh](https://github.com/niklaslang/scRNAseqVariantCalling/blob/master/sc_gatk_4.sh)


#### 4.5 PrintReads

 - parallel processing script:[pp_gatk_5.sh](https://github.com/niklaslang/scRNAseqVariantCalling/blob/master/pp_gatk_5.sh)
 - gatk script: [sc_gatk_5.sh](https://github.com/niklaslang/scRNAseqVariantCalling/blob/master/sc_gatk_5.sh)

**CAVE:** MAKE SURE pp_gatk_5.sh and sc_gatk_5.sh ARE IN THE SAME FOLDER as pp_gatk_4.sh and sc_gatk_4.sh, since they have identical input files.

### 5. Variant Calling

- GATK version 3.8: https://software.broadinstitute.org/gatk/

**CAVE:** make sure you work with GATK version 3.8 since there are substantial syntax changes between versions 3.x and 4.x!

#### 5.1 HaplotypeCaller

- parallel processing script:[pp_gatk_6.sh](https://github.com/niklaslang/scRNAseqVariantCalling/blob/master/pp_gatk_6.sh)
- gatk script: [sc_gatk_6.sh](https://github.com/niklaslang/scRNAseqVariantCalling/blob/master/sc_gatk_6.sh)

#### 5.2

- parallel processing script:[pp_gatk_7.sh](https://github.com/niklaslang/scRNAseqVariantCalling/blob/master/pp_gatk_7.sh)
- gatk script: [sc_gatk_7.sh](https://github.com/niklaslang/scRNAseqVariantCalling/blob/master/sc_gatk_7.sh)

### 6. Computing n_cell x n_snv matrix

- SSrGE: https://github.com/lanagarmire/SSrGE

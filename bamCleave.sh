#!/bin/bash

#presets

#SBATCH --mem=240000
#SBATCH --ntasks=16

#splittng BAM files

#nota bene no.1 : bamCleave can be run by specifying the full path name to the program or ./bamCleave if it is in the current directory

#nota bene no.2 : -t specifies the tag that is used is to indentify the cell barcode. use "CB" for CellRanger BAM files

./bamCleave -b /PATH/TO/INPUT/BAM/FILE -o PATH/TO/OUTPUT -t CB -c 1008

#!/bin/bash

fastqc *.fastq.gz -t 150
chmod +x fastp.sh
./fastp.sh

jellyfish count -C -m 21 -s 1000000000 -t 100 *.fastq -o reads.jf
jellyfish histo -t 150 reads.jf > reads.histo
Rscript genomescopre.R reads.histo 21 251 genomescope

porechop -t 150 -i combined.fastq -o porechop/combined.porechop.fastq

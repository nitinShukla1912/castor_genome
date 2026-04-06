#!/bin/bash
meryl count threads=150 k=21 output meryl-SKI-215 DD-C-SKI215_S40_L001_R1_001.fastq DD-C-SKI215_S40_L001_R2_001.fastq
meryl count threads=150 k=21 output meryl-SKP-84 DD-C-SKP84_S41_L001_R1_001.fastq DD-C-SKP84_S41_L001_R2_001.fastq

export MERQURY=$PWD
./merqury.sh ../meryl-SKI-215/ ../Final.curated.NCBI.SKI-215.fasta merqury-SKI-215
./merqury.sh ../meryl-SKP-84/ ../SKP-84.curated.fasta merqury-SKP-84

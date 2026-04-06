#!/bin/bash
busco -i Final.curated.NCBI.SKI-215.fasta -o busco-SKI-215 -l embryophyta_odb10 -m genome --cpu 150
busco -i SKP-84.curated.fasta -o busco-SKP-84 -l embryophyta_odb10 -m genome --cpu 150

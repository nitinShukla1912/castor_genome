#!/bin/bash
ragtag.py scaffold GCF_019578655.1_ASM1957865v1_genomic.fna genome.nextpolish.fasta -o ragtag-scaffold-nextpolish -t 150
quast.py ragtag.scaffold.fasta -o quast-ragtag_nextpolish -t 150

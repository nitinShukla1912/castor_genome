#!/bin/bash
python -m jcvi.formats.gff bed --type=mRNA --key=Name GCF_019578655.1_ASM1957865v1_genomic.gff -o WT05.bed
python -m jcvi.formats.gff bed --type=mRNA --key=Name SKI-215.complete.genomic.gff -o SKI-215.bed
python -m jcvi.formats.gff bed --type=mRNA --key=Name SKP-84.complete.genomic.gff -o SKP-84.bed

python -m jcvi.formats.fasta format GCF_019578655.1_ASM1957865v1_cds_from_genomic.fna WT05.cds
python -m jcvi.formats.fasta format SKP-84.complete.cds.fna SKP-84.cds
python -m jcvi.formats.fasta format SKI-215.complete.cds.fna SKI-215.cds

python -m jcvi.compara.catalog ortholog WT05 SKI-215 --no_strip_names
python -m jcvi.compara.catalog ortholog SKI-215 SKP-84 --no_strip_names

python -m jcvi.compara.synteny screen --minspan=30 --simple WT05.SKI-215.anchors WT05.SKI-215.anchors.new
python -m jcvi.compara.synteny screen --minspan=30 --simple SKI-215.SKP-84.anchors SKI-215.SKP-84.anchors.new

python -m jcvi.graphics.karyotype seqids1 layout3 --keep-chrlabels -o final14.svg --figsize 12x12

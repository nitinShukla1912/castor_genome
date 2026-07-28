#!/bin/bash
#Functional Annotation

#eggnog-mapper
wget http://eggnog5.embl.de/download/emapperdb-5.0.2/eggnog.taxa.tar.gz
wget http://eggnog5.embl.de/download/emapperdb-5.0.2/eggnog_proteins.dmnd.gz
wget -O eggnog.db.gz http://eggnog5.embl.de/download/emapperdb-5.0.2/eggnog.db.gz
emapper.py --data_dir ~/Castor/db/eggnog --list_taxa
emapper.py -i SKI-215-complete.proteins.faa -o SKI-215 --output_dir ~/Castor/Annotation/eggnog --data_dir ~/Castor/db/eggnog -m diamond --cpu 60 --target_taxa 33090 --override
emapper.py -i SKP-84-complete.proteins.faa -o SKP-84 --output_dir ~/Castor/Annotation/eggnog2/ --data_dir ~/Castor/db/eggnog -m diamond --cpu 60 --target_taxa 33090

#SWISS-Prot
wget https://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot.fasta.gz
gunzip uniprot_sprot.fasta.gz
diamond makedb --in uniprot_sprot.fasta -d swissprot
diamond blastp -q /data/wwgsbtm/Castor/Annotation/SKI-215-complete.proteins.faa -d swissprot  -o SKI-215_swissprot.tsv -e 1e-5 -f 6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore stitle --max-target-seqs 1 --threads 50
diamond blastp -q /data/wwgsbtm/Castor/Annotation/SKP-84-complete.proteins.faa -d swissprot  -o SKP-84_swissprot.tsv -e 1e-5 -f 6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore stitle --max-target-seqs 1 --threads 50

#InterProScan
wget https://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/5.69-101.0/interproscan-5.69-101.0-64-bit.tar.gz
tar -xvzf interproscan-5.69-101.0-64-bit.tar.gz
cd /data/wwgsbtm/Castor/Annotation/interproscan-5.69-101.0
python3 setup.py -f interproscan.properties
./interproscan.sh ../SKI-215-complete.proteins.faa -b functional_annotation/interproscan/SKI-215 -f TSV,GFF3,JSON -goterms  -pa -cpu 150
./interproscan.sh -i ../SKP-84-complete.proteins.faa -b functional_annotation/interproscan/SKP-84 -f TSV,GFF3,JSON -goterms  -pa -cpu 150

#NR Darabase
diamond blastp -q SKI-215-complete.proteins.faa -d ../nr.dmnd -o SKI-215_nr_hits.tsv --outfmt 6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore stitle -e 1e-5 --max-target-seqs 5 --threads 80 
diamond blastp -q SKP-84-complete.proteins.faa -d ../nr.dmnd -o SKP-84_nr_hits.tsv --outfmt 6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore stitle -e 1e-5 --max-target-seqs 5 --threads 80

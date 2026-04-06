#!/bin/bash
HOST_DIR=/home/gbrc/DarshanSir/SecondaryAnalysis
CONT_DIR=/tmp

GENOME=Final.curated.NCBI.SKI-215.fasta
OUT_DIR=$HOST_DIR/HiTE_out_Final.curated.NCBI.SKI-215
mkdir -p $OUT_DIR

docker run --rm -v ${HOST_DIR}:${CONT_DIR} kanghu/hite:3.3.3 python main.py --genome ${CONT_DIR}/${GENOME} --plant 1 --recover 1 --annotate 1 --thread 150 --out_dir ${CONT_DIR}/HiTE_out_Final.curated.NCBI.SKI-215

GENOME=SKP-84.curated.fasta

docker run --rm -v ${HOST_DIR}:${CONT_DIR} kanghu/hite:3.3.3 python main.py --genome ${CONT_DIR}/${GENOME} --plant 1 --recover 1 --annotate 1 --thread 150 --out_dir ${CONT_DIR}/HiTE_out_SKP-84.curated

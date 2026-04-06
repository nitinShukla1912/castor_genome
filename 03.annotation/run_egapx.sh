#!/bin/bash
python3 egapx.py SKI-215-NCBI-Curated.yaml -e docker -w /tmp/S1-porechop/EGAPX/SKI-215-EGAPX/ -o /tmp/S1-porechop/EGAPX/SKI-215-EGAPX/ -v
python3 egapx.py SKP-84-NCBI-Curated.yaml -e docker -w /tmp/S1-porechop/EGAPX/SKP-84-EGAPX/ -o /tmp/S1-porechop/EGAPX/SKP-84-EGAPX/ -v

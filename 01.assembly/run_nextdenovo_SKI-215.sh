#!/bin/bash
echo "/tmp/S1-porechop/combined.porechop.fastq" > S1_input.fofn
./nextDenovo runS1_porechop.cfg


```File Name: S1_input.fofn```
/tmp/S1-porechop/combined.porechop.fastq 
```File Name: runS1_porechop.cfg```
[General]
job_type = local # here we use SGE to manage jobs
job_prefix = nextDenovo
task = all
rewrite = yes
deltmp = yes
parallel_jobs = 10
input_type = raw
read_type = ont # clr, ont, hifi
input_fofn = S1_input.fofn
workdir = /tmp/S1-porechop/out



quast.py SKI-215.nd.asm.fasta -o quast -t 150

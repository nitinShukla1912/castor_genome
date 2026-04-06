#!/bin/bash
./nextPolish Output-S1-Again/run.cfg

./nextPolish Output-S1-Again/run.cfg
[General]
job_type = local
job_prefix = nextPolish
task = default
rewrite = yes
deltmp = yes
rerun = 3
parallel_jobs = 2
multithread_jobs = 10
genome = /tmp/S1-porechop/out/03.ctg_graph/nd.asm.fasta
genome_size = auto
workdir = ./01_rundir
polish_options = -p {multithread_jobs}

[sgs_option]
sgs_fofn = ./sgs.fofn
sgs_options = -max_depth 100 -bwa

[lgs_option]
lgs_fofn = ./lgs.fofn
lgs_options = -min_read_len 1k -max_depth 100
lgs_minimap2_options = -x map-ont
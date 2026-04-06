#!/bin/bash
LOCAL_DB="/mnt/data_dragon/hpcdata/nitin/Castor/Nanopore/Run2/castor_nextdenovo_S2/03.ctg_graph/NextPolish/S1/01_rundir/ragtag-scaffold-nextpolish"
DBP="$LOCAL_DB/gxdb"

python3 fcs.py screen genome --fasta /tmp/S1-porechop/out/03.ctg_graph/NextPolish/Output-S1-Again/01_rundir/ragtag-scaffold-nextpolish/ragtag.scaffold.fasta --out-dir /tmp/S1-porechop/out/03.ctg_graph/NextPolish/Output-S1-Again/01_rundir/ragtag-scaffold-nextpolish/gx_out_S1_New --gx-db "$DBP" --tax-id 3988

seqkit split -i ragtag.scaffold.fasta -O split

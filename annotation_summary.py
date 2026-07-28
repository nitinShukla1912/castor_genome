#!/usr/bin/env python3

import argparse
import pandas as pd

parser = argparse.ArgumentParser(
    description="Summarize eggNOG-mapper and InterProScan annotations"
)

parser.add_argument("--fasta", required=True,
                    help="Protein FASTA file")

parser.add_argument("--eggnog", required=True,
                    help="eggNOG .emapper.annotations")

parser.add_argument("--interpro", required=True,
                    help="InterProScan TSV")

parser.add_argument("--output",
                    default="annotation_summary",
                    help="Output prefix")

args = parser.parse_args()

TOTAL = 0

with open(args.fasta) as f:
    for line in f:
        if line.startswith(">"):
            TOTAL += 1

print(f"\nTotal proteins: {TOTAL}\n")

egg = pd.read_csv(
    args.eggnog,
    sep="\t",
    comment="#",
    header=None,
    names=[
        "query",
        "seed",
        "evalue",
        "score",
        "OG",
        "level",
        "COG",
        "Description",
        "Preferred_name",
        "GO",
        "EC",
        "KEGG_KO",
        "KEGG_Pathway",
        "KEGG_Module",
        "KEGG_Reaction",
        "KEGG_rclass",
        "BRITE",
        "KEGG_TC",
        "CAZy",
        "BiGG",
        "PFAM"
    ]
)

ipr = pd.read_csv(
    args.interpro,
    sep="\t",
    header=None,
    low_memory=False
)

ipr.columns = [
    "Protein",
    "MD5",
    "Length",
    "Database",
    "SignatureAcc",
    "SignatureDesc",
    "Start",
    "End",
    "Score",
    "Status",
    "Date",
    "InterProAcc",
    "InterProDesc",
    "GO",
    "Pathway"
]

def egg_count(column):
    return egg.loc[egg[column] != "-", "query"].nunique()

rows = []

rows.append({
    "Annotation":"Protein-coding genes",
    "Tool":"NCBI EGAPx",
    "Database/Source":"Genome annotation",
    "Proteins":TOTAL,
    "Percent":100.00
})

egg_entries = [

("Proteins with eggNOG annotation",
 "eggNOG-mapper",
 "eggNOG",
 egg["query"].nunique()),

("Gene Ontology (GO)",
 "eggNOG-mapper",
 "Gene Ontology",
 egg_count("GO")),

("KEGG Orthology (KO)",
 "eggNOG-mapper",
 "KEGG",
 egg_count("KEGG_KO")),

("KEGG Pathway",
 "eggNOG-mapper",
 "KEGG",
 egg_count("KEGG_Pathway")),

("EC number",
 "eggNOG-mapper",
 "Enzyme Commission",
 egg_count("EC")),

("COG category",
 "eggNOG-mapper",
 "COG",
 egg_count("COG")),

("Functional description",
 "eggNOG-mapper",
 "eggNOG",
 egg_count("Description")),

("Preferred gene name",
 "eggNOG-mapper",
 "eggNOG",
 egg_count("Preferred_name")),

("CAZy",
 "eggNOG-mapper",
 "CAZy",
 egg_count("CAZy")),

("Pfam",
 "eggNOG-mapper",
 "Pfam",
 egg_count("PFAM"))

]

for ann, tool, db, n in egg_entries:

    rows.append({
        "Annotation":ann,
        "Tool":tool,
        "Database/Source":db,
        "Proteins":int(n),
        "Percent":round(n/TOTAL*100,2)
    })

rows.append({
    "Annotation":"Proteins with InterProScan match",
    "Tool":"InterProScan",
    "Database/Source":"All member databases",
    "Proteins":ipr["Protein"].nunique(),
    "Percent":round(ipr["Protein"].nunique()/TOTAL*100,2)
})

rows.append({
    "Annotation":"InterPro accession",
    "Tool":"InterProScan",
    "Database/Source":"InterPro",
    "Proteins":ipr.loc[
        ipr["InterProAcc"] != "-",
        "Protein"
    ].nunique(),
    "Percent":round(
        ipr.loc[
            ipr["InterProAcc"] != "-",
            "Protein"
        ].nunique()/TOTAL*100,
        2
    )
})

rows.append({
    "Annotation":"Gene Ontology (GO)",
    "Tool":"InterProScan",
    "Database/Source":"Gene Ontology",
    "Proteins":ipr.loc[
        ipr["GO"] != "-",
        "Protein"
    ].nunique(),
    "Percent":round(
        ipr.loc[
            ipr["GO"] != "-",
            "Protein"
        ].nunique()/TOTAL*100,
        2
    )
})

rows.append({
    "Annotation":"Pathway",
    "Tool":"InterProScan",
    "Database/Source":"MetaCyc / Reactome",
    "Proteins":ipr.loc[
        ipr["Pathway"] != "-",
        "Protein"
    ].nunique(),
    "Percent":round(
        ipr.loc[
            ipr["Pathway"] != "-",
            "Protein"
        ].nunique()/TOTAL*100,
        2
    )
})

database_names = {
    "CDD":"CDD",
    "Coils":"Coils",
    "FunFam":"FunFam",
    "Gene3D":"Gene3D",
    "Hamap":"HAMAP",
    "MobiDBLite":"MobiDBLite",
    "NCBIfam":"NCBIfam",
    "PANTHER":"PANTHER",
    "PIRSF":"PIRSF",
    "PRINTS":"PRINTS",
    "Pfam":"Pfam",
    "ProSitePatterns":"ProSite Patterns",
    "ProSiteProfiles":"ProSite Profiles",
    "SFLD":"SFLD",
    "SMART":"SMART",
    "SUPERFAMILY":"SUPERFAMILY"
}

for db in sorted(ipr["Database"].unique()):

    n = ipr.loc[
        ipr["Database"] == db,
        "Protein"
    ].nunique()

    rows.append({
        "Annotation":database_names.get(db,db),
        "Tool":"InterProScan",
        "Database/Source":db,
        "Proteins":int(n),
        "Percent":round(n/TOTAL*100,2)
    })


summary = pd.DataFrame(rows)

summary.to_csv(args.output + ".csv", index=False)
summary.to_excel(args.output + ".xlsx", index=False)

print(summary.to_string(index=False))

print("\nFiles written:")
print(args.output + ".csv")
print(args.output + ".xlsx")

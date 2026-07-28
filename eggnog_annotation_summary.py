#!/usr/bin/env python3

import csv
import sys

if len(sys.argv) != 2:
    print(f"Usage: python {sys.argv[0]} <emapper.annotations>")
    sys.exit(1)

annotation_file = sys.argv[1]

counts = {
    "Total genes": 0,
    "GO": 0,
    "EC": 0,
    "KEGG_ko": 0,
    "KEGG_Pathway": 0,
    "COG_category": 0,
    "Description": 0,
    "Preferred_name": 0,
    "CAZy": 0,
    "PFAMs": 0,
}

header = None

with open(annotation_file) as f:
    for line in f:

        if line.startswith("##"):
            continue

        if line.startswith("#query"):
            header = line.strip().lstrip("#").split("\t")
            col = {name: i for i, name in enumerate(header)}
            continue

        row = line.rstrip().split("\t")

        counts["Total genes"] += 1

        for field in [
            "GOs",
            "EC",
            "KEGG_ko",
            "KEGG_Pathway",
            "COG_category",
            "Description",
            "Preferred_name",
            "CAZy",
            "PFAMs",
        ]:

            value = row[col[field]]

            if value != "-" and value != "":
                if field == "GOs":
                    counts["GO"] += 1
                else:
                    counts[field] += 1

print("\nAnnotation summary")
print("=" * 50)

total = counts["Total genes"]

for key, value in counts.items():

    if key == "Total genes":
        print(f"{key:20s}: {value}")
    else:
        pct = value / total * 100
        print(f"{key:20s}: {value:7d} ({pct:6.2f}%)")
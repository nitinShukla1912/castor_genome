import pandas as pd

cols = [
    "qseqid","sseqid","pident","length","mismatch","gapopen",
    "qstart","qend","sstart","send","evalue","bitscore","stitle"
]

bad = [
    "uncharacterized",
    "hypothetical",
    "predicted protein",
    "unnamed protein",
    "unknown"
]

for sample in ["SKI-215","SKP-84"]:

    df = pd.read_csv(
        f"{sample}_nr_hits.tsv",
        sep="\t",
        names=cols
    )

    df["is_informative"] = ~df["stitle"].str.lower().str.contains(
        "|".join(bad),
        na=False
    )

    best = (
        df.sort_values(
            ["qseqid","is_informative","bitscore"],
            ascending=[True,False,False]
        )
        .groupby("qseqid")
        .first()
        .reset_index()
    )

    best.to_csv(
        f"{sample}_nr_best_hit.tsv",
        sep="\t",
        index=False
    )

    total = best["qseqid"].nunique()
    informative = best["is_informative"].sum()

    print(f"\n{sample}")
    print(f"Proteins with NR hit        : {total}")
    print(f"Informative NR annotation   : {informative}")
    print(f"Hypothetical/uncharacterized: {total-informative}")
    print(f"Annotation rate             : {informative/total*100:.2f}%")
import codecs
import pandas as pd

def clean(filename):
    # load data, omitting the non-UTF-8 currency symbols in COST
    with codecs.open(filename, "r",encoding='utf-8', errors='ignore') as spend_data:
        spending_df = pd.read_csv(spend_data)

    # simplify cost column title
    oldTitle = "COST () charged to Wellcome (inc VAT when charged)"
    spending_df = spending_df.rename(columns={oldTitle:"Cost"})

    # a small number of journals are listed as 999,999.00 - 3.5 orders of magnitude greater than the average.
    # Pretty clearly an error, so we'll remove those rows
    spending_df = spending_df[spending_df["Cost"] != "999999.00"]

    # convert cost to numeric
    spending_df["Cost"] = pd.to_numeric(spending_df["Cost"], errors="coerce")
    
    # remove periods and decapitalize all letters in journal and publisher titles to eliminate inconsistencies
    spending_df["Journal title"].str.replace(".","")
    spending_df["Publisher"].str.replace(".","")
    spending_df["Journal title"] = spending_df["Journal title"].str.lower()
    spending_df["Publisher"] = spending_df["Publisher"].str.lower()

    return spending_df

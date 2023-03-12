#!/usr/bin/env python3

# importing libraries
import pandas as pd
import glob
import os

# define path
input = "/home/hqxx/Desktop/wcd_assignments/input"
output = "/home/hqxx/Desktop/wcd_assignments/output"
file_name = "all_years.csv"

# merge the files
joined_files = os.path.join(input, "*.csv")

# A list of all joined files
joined_list = glob.glob(joined_files)

# concatenate files
df = pd.concat(map(pd.read_csv, joined_list), ignore_index=True)
#print(df)

#export csv file
df.to_csv(output+"/"+file_name)

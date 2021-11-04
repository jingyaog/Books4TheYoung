import pandas as pd
import os, shutil

## read filenames using pandas
df_files = pd.read_excel("/Users/VickiChang/Desktop/Hewins/hewins_books.xlsx")


## set file locations
fileOrigin = "/Users/VickiChang/Desktop/Hewins/corpus/" #file origin
fileDest="/Users/VickiChang/Desktop/Fiction Text Files" #file destination

for ff in df_files['txt'].tolist():
    print(f"Moving file {ff}")
    shutil.move(fileOrigin+ff, fileDest) #shutil to move file
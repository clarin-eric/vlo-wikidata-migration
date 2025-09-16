import sys
import pandas as pd

inFile = sys.argv[1]
outFile = sys.argv[2]

print("Reading", inFile)
df= pd.read_csv(inFile)

print("Writing", outFile)
with open(outFile, 'w') as myfile: 
  myfile.write(df.to_xml())

print("Done")
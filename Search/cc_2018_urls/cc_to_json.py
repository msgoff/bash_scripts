import json
from tqdm import tqdm
import re
from sys import argv

f = open(argv[1])

data = f.read()
rows = re.findall('{.*?}',data)
f = open('{}.json'.format(argv[1]),'w')
for row in tqdm(rows):
    f.write(row)
    f.write('\n')

f.close()

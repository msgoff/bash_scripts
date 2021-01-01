from sys import argv
import  re
from tqdm import tqdm
from time import sleep

#pass one of the json files as the first argument
g = open(argv[1])
data = g.read()
rows  = re.findall('{.*?}',data)

for iy in range(0,len(rows),100):
    f = open('bulk{}'.format(iy),'w')
    #fill in the ip on the Elastic node you will be posting data to
    f.write('curl -X POST \"192.168.4.32:9200/_bulk\" -H \'Content-Type: application/json\' -d\'')
    f.write('\n')
    for ix,row in enumerate(rows[iy:iy+100]):
        if not re.findall('\(|\)',row):
            #create the index string for the job
            start = '{ "index" : { "_index" : "test2", "_type" : "_doc", "_id" :'
            mid = "\"{}\"".format(ix+iy)
            end = '} } '
            indx = start + mid + end
            f.write(indx)
            f.write('\n')
            #write the row of data to be posted 
            query = row
            f.write(query)
            f.write('\n')

    f.write("'")
    f.close()
    

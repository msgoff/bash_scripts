import json

f=open('HN_test','r')
g=open('hn.pl','w')
data=f.read()
lst=[]
strng=''
dct={}
index = 0
def write_file(item):
        g=open('{}.pl'.format(item),'a+')
        try:
                g.write('{}({},"{}").'.format(item,new_dct["id"],new_dct[item]))
                g.write('\n')
        except:
                pass
	g.close()


for line in data.split('\n'):
   if '{' in line:
	strng += line
   elif '}' in line:
	strng += line
	dct[index] = strng
	index +=1
	strng = ''
   else: 
	strng += line


for ix in range(len(dct)):
	try:
		new_dct=json.loads(dct[ix])
        except:
		pass


	[write_file(key) for key in new_dct.keys() if key !="id"]







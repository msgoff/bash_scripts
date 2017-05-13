import re
import os
f=open("incoming_md5s",'r')
data=f.readlines()
g=open("files_to_be_deleted",'w')
md5s_keep = {re.split('\s+',x)[0]:re.split('\s+',x)[1] for x in set(data)}
md5s_all  = {re.split('\s+',x)[0]:re.split('\s+',x)[1] for x in data}
test = (x for x in md5s_all.values() if x not in md5s_keep.values())

for ix in range(100000):
	file_path="/media/Incoming_Storage/"+str(test.next()).replace('./','')	
	print file_path
	try:	
		os.remove(file_path)
	except:
		print "failed on ",file_path

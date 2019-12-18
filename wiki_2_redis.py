import re

f=open('enwiki-latest-pages-articles-multistream.xml')
data=f.read()


resp=re.findall('<page>.*?</page>',data,re.DOTALL)

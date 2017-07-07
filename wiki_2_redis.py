import re
from redis import Redis



r = Redis()
f=open('enwiki-latest-pages-articles-multistream.xml')
data=f.read()


resp=re.findall('<page>.*?</page>',data,re.DOTALL)


#becuase it's fun
f = lambda key, id: {
    re.sub('>|<', '', key): \
        str(re.findall('{}(.*?){}'.format(key, key.replace('<', '</')), resp[id], re.DOTALL))}


def get_keys(id):
    return re.findall('<[a-zA-Z]+>', resp[id])


def dct_2_redis(id):
    dct = {}
    keys = get_keys(id)
    for key in keys:
        if 'page' not in key:
            dct.update(f(key, id))

    r.hmset(id, dct)


#load wiki into redis
gnr8tr = (dct_2_redis(id) for id in range(len(resp)))
while True: gnr8tr.next()

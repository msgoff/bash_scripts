import re
import urllib
import requests
import os

f = open('2018_urls.dat')
urls = [x.replace('\n','') for x in f.readlines() if 'gz' in x]

folders = set()
for url in urls:
    folder = [x for x in re.split('/',url) if 'CC' in x]
    if folder:
        folders.add(folder[0])

for folder in folders:
    if not os.path.exists(folder):
        os.makedirs(folder)



def download_gz(url):
    f_name = re.split('/',url)[-1]
    print f_name
    for folder in folders:
        if folder in url:
             fullfilename = os.path.join(folder,f_name)
    urllib.urlretrieve(url, fullfilename)

for url in urls: 
    download_gz(url)


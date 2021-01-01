mkdir $(cat warc.paths |sort -n|cut -d "/" -f4|sort |uniq)

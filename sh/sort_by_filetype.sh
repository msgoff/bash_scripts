#requires parallel to be installed
parallel echo ::: $(find . -type f |rev |cut -d "." -f1|rev|sort |uniq -c |sort -g|awk '$1 > 1'|awk '{print $2}') > file_types

while read f;do mkdir $f; find . -type f -name "*.$f" -exec cp "{}" $f/ \; ;done < <(cat file_types)

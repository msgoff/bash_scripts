grep import -hir .|sort |uniq -c|sort -n >imports
grep -P "def|lambda" -hir .|sort |uniq -c|sort -n > funcs
grep = -hir .|sort |uniq -c |sort -g > assignments
grep "#" -hir . |sort |uniq -c |sort -g > comments
grep -hirP "@|href|http" .|sort |uniq -c |sort -n > urls_decorators
grep "re\." -hir .|sort |uniq -c |sort -g > regular_expressions
cat *|tr " " "\n"|sort |uniq -c |sort -g > word_freq

#words and related words that you care about goes in grep_file
#one directory up
#this search is done on text files

while read f;
	do grep -Hocif ../grep_file  $f; 
	done < <(ls *.txt)|
		rev |awk -F: '$1 > 0 { print $1,$2}'|
		rev|sort -k 2




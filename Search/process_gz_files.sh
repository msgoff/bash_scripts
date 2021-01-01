#!/bin/bash

#gets the urls out of the warc file downloaded from common crawl ec2 instance
get_urls()
{
xzgrep -P "(href|http)" "$1" |
	tr "<" "\n"|
	grep http|
	tr " " "\n"|
	grep http |
	tr "= ,{();\\" "\n"|
	tr -d '"' |
	tr -d "'" |
	grep -P "http://|https://"|
	awk 'length($0)<120'|                    #accept urls less than 120 chars long
	sort|uniq -c |sort -n > "$1_URLS"
}


#finds all of the warc files that have not been accessed in the last 5 min and is greater than 900M
#this is a reasonable check that the file is approximately the correct size and is not currently being downloaded

readarray X < <(find . -amin +5 -size +900M)


#loop over the array
for f in ${X[@]};
	do 
		$(folder=$(pwd)/$(echo $f|cut -d "/" -f2);
		cd $folder
		file_name=$(echo $f|cut -d "/" -f3-)
		echo $file_name
		time get_urls $file_name
		rm $folder/$file_name
		cd ..) & done 




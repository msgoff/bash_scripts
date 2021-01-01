
download_warc(){
url=https://commoncrawl.s3.amazonaws.com/"$1"
wget -a wget_log_file $url 
}

while read f; do
	folder=$(echo $(pwd)/$(echo $f|cut -d "/" -f4));
	cd $folder;
	echo $(pwd);
	download_warc $f;
	cd ..;done < <(cat warc.paths |sort -n)




get_warc(){
	
	folder=$(echo $(pwd)/$(echo $f|cut -d "/" -f4));
	cd $folder;
	echo $(pwd);
	url=https://commoncrawl.s3.amazonaws.com/"$1"
	echo $url
	wget  $url;
	cd ..;
}

export -f get_warc
parallel get_warc {} ::: < <(echo $1 )



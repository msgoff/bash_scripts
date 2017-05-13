path=$(pwd);
while read f;
	do url="https://github.com/$f";
	name=$(echo $f|cut -d "/" -f1);
	
	if [ ! -x $path/$name ];
	then 
		mkdir $path/$name;
	fi;
	
	cd $path/$name;
	git clone $url;
	done < <(cat repos_to_clone )


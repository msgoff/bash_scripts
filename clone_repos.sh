while read f;do url="https://github.com/$f";name=$(echo $f|cut -d "/" -f1);echo $name $url;if [ ! -x $name ];then mkdir $name;fi;path=$(pwd);cd $path/$name;git clone $url ;done < <(cat repos_to_clone )


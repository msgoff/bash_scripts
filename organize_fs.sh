mkdir ~/Desktop/"$1"
mlocate .|grep -i "\.$1$" |xargs -I {} cp {} ~/Desktop/"$1"

mkdir ~/Desktop/"$1"
mlocate *."$1" |xargs -I {} cp {} ~/Desktop/"$1"

mkdir ~/Desktop/"$1"
mlocate .|grep -i "\.$1$" |xargs -I {} cp {} ~/Desktop/"$1"
#for the top 100 most common files on the system
#mlocate .|rev |cut -d "." -f1 |rev|sort|uniq -c|sort -g |sed -re 's/^\s+//g'| awk '{print $2}'|tail -n 100|xargs -I {} ./organize_fs.sh {} 

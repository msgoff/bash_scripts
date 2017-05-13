echo "Input Full Source Directory path: "
read source
echo $source
echo "Inpuce Destination Path: "
read dest
echo $dest
cd $source
file_name=$(pwd|rev|cut -d"/" -f1|rev)"_md5s_"$(date|sed -re 's/\s+/_/g')
echo $file_name
find "$source" -type f |xargs -P 0 md5sum | tee "/tmp/s_md5s"
find "$dest" -type f |xargs -P 0 md5sum | tee "/tmp/d_md5s" 

cat /tmp/s_md5s | sort|uniq -c | sort -n > /tmp/s_md5s_stats
cat /tmp/d_md5s | sort|uniq -c | sort -n > /tmp/d_md5s_stats

cat /tmp/s_md5s | sort|uniq -c | sort -n |sed -re 's/^\s+//g'| cut -d" " -f2>/tmp/s_md5s_set
cat /tmp/d_md5s | sort|uniq -c | sort -n |sed -re 's/^\s+//g'| cut -d" " -f2>/tmp/d_md5s_set  


rm /tmp/md5s_to_merge
for line in $(cat /tmp/s_md5s_set);do resp=$(grep -xc $line /tmp/d_md5s_set);if [ $resp == 0 ]; then echo $line>>/tmp/md5s_to_merge;echo $resp;fi;done

cat /tmp/md5s_to_merge|sort | uniq > /tmp/md5s_to_merge_set

rm /tmp/files_to_merge
for line in $(cat /tmp/md5s_to_merge_set);do grep $line /tmp/s_md5s >> /tmp/files_to_merge;done

mkdir staging
for line in $(cat /tmp/files_to_merge|cut -d" " -f2-|sed -re 's/^\s+//g');
do 
cp $line staging;
done





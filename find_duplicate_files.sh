find_dups(){
echo "Input Directory"
read source
find $source -type f -exec md5sum "{}" >> /tmp/file_checksums \;

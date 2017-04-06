source /media/data/Github/user_defined_functions
filename="$1"
readarray X < <(grep  -nP "^{|^}" $filename|grep  {|cut -d ":" -f1)
readarray Y < <(grep  -nP "^{|^}" $filename|grep  }|cut -d ":" -f1)
for ((i=1;i<=${#X[@]};i++));do
sed -n "$(echo ${X[$i]}),$(echo ${Y[$i]})p" $filename > /tmp/match
readarray keys < <(cat /tmp/match | cut -d ":" -f1 |tr -d '{}"')

readarray values < <(cat /tmp/match | cut -d ":" -f2- |tr -d '{}"')
len=${#keys[@]}

columns=$(echo \( ${keys[@]} \)| sed -re "s/ /,/g"|sed -re "s/'',?//g"|sed -re 's/\(,/\(/'|sed -re 's/,\)$/\)/g' );
echo $columns 
	

text_in_keys=$(echo ${keys[@]}|grep -ic "text" )
echo $text_in_keys
text_index=$(echo ${keys[@]}|grep -oP ".*?text"|grep -o ' '|wc -l)

if [ $text_in_keys == 1 ];then
	echo 55555555555555555555
	values[$(($text_index+1))]=$(echo ${values[$(($text_index+1))]}|sed -re 's/,/____/g'),
fi


echo ${#keys[@]}
echo ${#values[@]}
#echo ${values[$(($text_index+1))]}
echo  $(echo ${values[@]}|sed -re "s/, /','/g"|tr '][' '}{')
postgres "insert into hn_stories ($(echo ${keys[@]}|tr ' ' ',')) values ('$(echo ${values[@]}|sed -re "s/, /','/g"|tr '][' '}{')') ";

done







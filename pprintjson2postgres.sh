source /media/data/Github/user_defined_functions
filename="$1"
readarray X < <(grep  -nP "^{|^}" $filename|grep  {|cut -d ":" -f1)
readarray Y < <(grep  -nP "^{|^}" $filename|grep  }|cut -d ":" -f1)
for i in {1..10};do
sed -n "$(echo ${X[$i]}),$(echo ${Y[$i]})p" $filename > /tmp/match
readarray keys < <(cat /tmp/match | cut -d ":" -f1 |tr -d '{}"')

readarray values < <(cat /tmp/match | cut -d ":" -f2- |tr -d '{}"')
len=${#keys[@]}

columns=$(echo \( ${keys[@]} \)| sed -re "s/ /,/g"|sed -re "s/'',?//g"|sed -re 's/\(,/\(/'|sed -re 's/,\)$/\)/g' );
echo $columns 
#strng=''
#strng2=''
#for ((j=1;j<=${#values[@]};j++));do
#	if [ $j == 1 ];then 
#		strng=$(echo  \(\' ${values[j]} \'|sed -re "s/, '/',/g"|sed -re "s/\(' /\('/g")
#	else
#		strng2=$(echo $strng2 \'${values[$j]}\'|sed -re "s/, '/',/g")
#		echo $strng2		
#	fi
	


#done
for ((j=1;j<=${#keys[@]};j++));do 
echo ${keys[1]},${values[1]}
postgres "insert into hn_stories ($(echo ${keys[@]}|tr ' ' ',')) values ('$(echo ${values[@]}|sed -re "s/, /','/g")') ";

done

done






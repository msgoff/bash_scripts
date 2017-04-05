#/* while read f;do file_name=$(echo $f|sed -re 's/^\.\///g');bash json2postgres.sh $file_name;done <xaa */

source /media/data/Github/user_defined_functions
while read -r line;do
	date=$(echo $1|tr -d "./json");
	echo $date
	clean_json=$(echo $line|sed -re 's/\//\/\//g')
	postgres "insert into github_archive values ('$date','$clean_json') "	
	done< <(cat "$1"|tr -d "'" |grep -P "^{\"id.*?}}$")


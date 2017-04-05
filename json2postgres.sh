source /media/data/Github/user_defined_functions
while read -r line;do
	date=$(echo $1|tr -d "./json");
	echo $date

	#https://stackoverflow.com/questions/3337936/remove-non-ascii-characters-from-csv
	clean_json=$(echo $line|sed 's/[\d128-\d255]//g') #remove non ascii
	
	postgres "insert into github_archive values ('$date','$clean_json') "	
	done< <(cat "$1"|tr -d "'" |grep -P "^{\"id.*?}}$")


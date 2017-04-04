while read -r line;
	do  postgres "insert into github_test values ('$line')"; 
	done < <(cat "$1"|tr -d "'" |grep -P "^{\"id.*?}}$")


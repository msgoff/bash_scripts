echo "choose folder name"
read folder_name
mkdir $folder_name
echo "search term 1"
read search_term_1


echo "search term 2"
read search_term_2


while read f;
	do pdf_name=$(echo $f|sed -re 's/txt$/pdf/g'); 
	mv "$pdf_name" $folder_name/;mv "$f" $folder_name/;
	done < <(grep -Hi $search_term_1 *.txt|grep -i $search_term_2|cut -d ":" -f1|sort |uniq )


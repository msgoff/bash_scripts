grun Python3 file_input -tree "$1" |
	sed 's/\\n))/\n\n\n/g'|
	sed -f sed_file|
	grep -i import|
	sed -r 's/import_stmt|import_from|import_name|dotted_as_names?|dotted_name|import_as_names?//g'|
	sed -r 's/(\( ){2,}//g'|
	sed -r 's/\(stmt //g'|
	sed -r 's/\(file_input//g'|
	sed -r 's/\){2,}//g'|
	sed 's/from ( /(from /g';


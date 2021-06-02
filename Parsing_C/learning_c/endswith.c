#include <stdbool.h>
#include <stdio.h>
#include <string.h>

bool ends_with(const char *string, const char *ending);

int main(int argc, char* argv[]){

	printf("%d",ends_with("asdf","dg"));
	return 0;
}

bool ends_with(const char *string, const char *ending){
	int string_len = strlen(string);
	int ending_len = strlen(ending);

	if ( string_len < ending_len ){
		return false;
	} else {
		int i = string_len-1;
		int j = ending_len-1;
		while( (j >= 0) && ( i >= 0) ){
		if ( string[i] != ending[j] ){
			return false;
		}
			i--;
			j--;	
		}

	}
	return true;
}

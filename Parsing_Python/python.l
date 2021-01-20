%{
#include <stdio.h>
#include "sds.h"
%}

%s start_state
%s import
%s function_definition


LP "("
RP ")"
NL "\n"
COLON ":"
RETURN "return"
FROM_IMPORT	"from"[ ]+
ID [a-zA-Z][_0-9a-zA-Z.]+
IMPORT "import"[ ]+
COMMA ","
WS [ ]+
AS [ ]+"as"[ ]+
DEF "def"[ ]+

%%

{FROM_IMPORT} BEGIN(import);
<import>{ID}{WS}+ {
	sds s = sdsnew(yytext);
	sdstrim(s," ");
	printf("FROM:%s:",s);
	sdsfree(s);
}


<import>{IMPORT}({ID}|({COMMA}{ID})+) { 
	sds s = sdsnew(yytext);
	sdstrim(s," ");
	sdsrange(s,6,-1);
	sdstrim(s," ");
	printf("IMPORT:%s:",s);
	sdsfree(s);
}

<import>{AS}{ID}|({COMMA}{ID}{AS}{ID})+ { 
	sds s = sdsnew(yytext);
	sdstrim(s," ");
	sdsrange(s,2,-1);
	sdstrim(s," ");
	printf("AS:%s:",s);
	sdsfree(s);

BEGIN(start_state); 
}

{DEF} { 
	sds s = sdsnew(yytext);
	sdstrim(s," ");
	sdsrange(s,3,-1);
	sdstrim(s," ");
	printf("FUNCTION_DEF:%s:",s);
	sdsfree(s);
BEGIN(function_definition);
}

<function_definition>{ID}{WS}* {
	sds s = sdsnew(yytext);
	sdstrim(s," ");
	printf("NAME:%s:",s);
	sdsfree(s);
}

<function_definition>{LP}({ID}({COMMA}{ID})*)?{RP}{COLON} {
	sds s = sdsnew(yytext);
	sdstrim(s," ");
	sdsrange(s,1,-3);
	printf("PARAMETERS:%s:",s);
	sdsfree(s);
BEGIN(start_state); 
}






.	{ BEGIN(start_state); };
%%


int
main(int argc, char **argv) {
  if (argc > 1) {
    FILE *file;
    file = fopen(argv[1], "r");
    if (!file) {
      fprintf(stderr, "could not open  %s\n", argv[1]);
      exit(1);
    }
    yyin = file;
  }
  yylex();
  //printf("%d",line_no);
  return 0;
}


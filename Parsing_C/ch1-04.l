%{
#include "sds.h"
#include "sdsalloc.h"

  enum {
    LOOKUP = 0, /* default - looking rather than defining. */
    INCLUDE,
    COMMENT,
  };

  int state;

  int add_word(int type, char *word);
  int lookup_word(char *word);
  int line_no = 0;
  int col_number = 0;
  int char_offset = 0;
%}

%%
.	{ char_offset++; col_number++; }
\n { line_no++; printf("%d\n",line_no);state = LOOKUP; char_offset++; col_number=0;  } /* end of line, return to default state */

^#include { printf("%d",col_number); state = INCLUDE; char_offset+=yyleng; col_number+=yyleng; }
"<"[a-zA-Z]+".h>" {
  printf("col_number:%d",col_number);
  char_offset+=yyleng;
  col_number+=yyleng;
  printf("include:%s\n", yytext);
  
  /* a normal word, define it or look it up */
  if (state != LOOKUP) {
    /* define the current word */
    add_word(state, yytext);
  } else {
    switch (lookup_word(yytext)) {
    case INCLUDE:
      printf("%s: include", yytext);
      break;
    default:
      printf("%s:  don't recognize", yytext);
      break;
    }
  }
}


"int argc" { 
	printf("col_number:%d",col_number);
	char_offset+=yyleng; 
	col_number+=yyleng; 
}


"char *argv[]" { 
	printf("\nargv:line_number:%d,col_number:%d\n",line_no,col_number);
	char_offset+=yyleng; 
	col_number+=yyleng; 
}

[^a-zA-Z0-9]int[ \t]+"main(" {
	printf("\nmain_function:line_number:%d,col_number:%d\n",line_no,col_number);
	char_offset+=yyleng; 
	col_number+=yyleng; 
  
  printf("MAIN_FUNCTION:"); 
  sds s = sdsnew(yytext);
  sdstrim(s," \n(");
  printf("%s",s);
  sdsfree(s);
}


"//".*	{ 

	printf("%d",col_number);
	char_offset+=yyleng; 
	col_number+=yyleng; 
	printf("COMMENT:%s",yytext);}

"/*".*?"*/"	{ 

	printf("%d",col_number);
	char_offset+=yyleng; 
	col_number+=yyleng; 
        printf("COMMENT:%s",yytext);}


[^a-zA-Z0-9]return[ \t]+[0-9] {
      
	printf("%d",col_number);
	char_offset+=yyleng; 
	col_number+=yyleng; 

printf("return_statement:");
	sds s = sdsnew(yytext);
  	sdstrim(s," \n(");
        sdsrange(s,6,10);
  	sdstrim(s," ");
	printf("%s",s);
	sdsfree(s);	
}

[^a-zA-Z0-9]int[ \t]+[a-zA-Z]+[ \t]+"="[ \t]+[0-9]+ {
  
	printf("%d",col_number);
	char_offset+=yyleng; 
	col_number+=yyleng; 

printf("TYPE_INT_ASSIGNED_VALUE:"); 
  sds s = sdsnew(yytext);
  sdstrim(s," \n(");
  sdsrange(s,4,20);
  printf("%s",s);
  sdsfree(s);
}

"(".*?")"	{
	
	printf("%d",col_number);
	char_offset+=yyleng; 
	col_number+=yyleng; 
		printf("expression:%s",yytext);
}






%%
/*
"puts" 			{ printf("PUTS "); } 
"auto"			{ printf("AUTO "); }
"const"			{ printf("CONST "); }
"continue"		{ printf("CONTINUE "); }
"default"		{ printf("DEFAULT "); }
"do"			{ printf("DO "); }
"double"		{ printf("DOUBLE "); }
"else"			{ printf("ELSE "); }
"enum"			{ printf("ENUM "); }
"goto"			{ printf("GOTO "); }
"long"			{ printf("LONG "); }
"register"		{ printf("REGISTER "); }
"restrict"		{ printf("RESTRICT "); }
"return"		{ printf("RETURN "); }
"short"			{ printf("SHORT "); }
"signed"		{ printf("SIGNED "); }
"sizeof"		{ printf("SIZEOF "); }
"static"		{ printf("STATIC "); }
"struct"		{ printf("STRUCT "); }
"switch"		{ printf("SWITCH "); }
"typedef"		{ printf("TYPEDEF "); }
"union"			{ printf("UNION "); }
"unsigned"		{ printf("UNSIGNED "); }
"void"			{ printf("VOID "); }
"volatile"		{ printf("VOLATILE "); }
"while"			{ printf("WHILE \n"); }
"("			{ printf("LPAREN \n"); }
")"			{ printf("RPAREN \n"); }
"{"			{ printf("LBRACE \n"); }
"}"			{ printf("RBRACE \n"); }
"..."			{ printf("ELLIPSIS "); }
">>="			{ printf("RIGHT_ASSIGN "); }
"<<="			{ printf("LEFT_ASSIGN "); }
"+="			{ printf("ADD_ASSIGN "); }
"-="			{ printf("SUB_ASSIGN "); }
"*="			{ printf("MUL_ASSIGN "); }
"/="			{ printf("DIV_ASSIGN "); }
"%="			{ printf("MOD_ASSIGN "); }
"&="			{ printf("AND_ASSIGN "); }
"^="			{ printf("XOR_ASSIGN "); }
"|="			{ printf("OR_ASSIGN "); }
">>"			{ printf("RIGHT_OP "); }
"<<"			{ printf("LEFT_OP "); }
"++"			{ printf("INC_OP "); }
"--"			{ printf("DEC_OP "); }
"->"			{ printf("PTR_OP "); }
"&&"			{ printf("AND_OP "); }
"||"			{ printf("OR_OP "); }
"<="			{ printf("LE_OP "); }
">="			{ printf("GE_OP "); }
"=="			{ printf("EQ_OP "); }
"!="			{ printf("NE_OP "); }
[\n]+ ;

[^a-zA-Z0-9]int[ \t]+"argc" {
  printf("int argc"); 
  sds s = sdsnew(yytext);
  sdstrim(s," \n(");
  printf("%s\n",s);
  sdsfree(s);
}

[^a-zA-Z0-9]int[ \t]+[a-zA-Z]+ {
  printf("TYPE_INT:"); 
  sds s = sdsnew(yytext);
  sdstrim(s," \n(");
  printf("%s\n",s);
  sdsfree(s);
}



[^a-zA-Z0-9]char[ \t]+"*"?[ \t]*[a-zA-Z]+"[]"? {
  printf("TYPE_CHAR:"); 
  sds s = sdsnew(yytext);
  sdstrim(s," \n(");
  printf("%s\n",s);
  sdsfree(s);
}


*/

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
  printf("%d",line_no);
  return 0;
}

/* define a linked list of words and types */
struct word {
  char *word_name;
  int word_type;
  struct word *next;
};

//"int"[ \t]+"main" { printf("main_function");}
struct word *word_list; /* first element in word list */

extern void *malloc();

int add_word(int type, char *word) {
  struct word *wp;

  if (lookup_word(word) != LOOKUP) {
    printf("!!! warning: word %s already defined \n", word);
    return 0;
  }

  /* word not there, allocate a new entry and link it on the list */

  wp = (struct word *)malloc(sizeof(struct word));

  wp->next = word_list;

  /* have to copy the word itself as well */

  wp->word_name = (char *)malloc(strlen(word) + 1);
  strcpy(wp->word_name, word);
  wp->word_type = type;
  word_list = wp;
  return 1; /* it worked */
}

int lookup_word(char *word) {
  struct word *wp = word_list;

  /* search down the list looking for the word */
  for (; wp; wp = wp->next) {
    if (strcmp(wp->word_name, word) == 0)
      return wp->word_type;
  }

  return LOOKUP; /* not found */
}



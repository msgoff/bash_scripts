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
  int line_no = 1;
  int col_number = 1;
  int char_offset = 0;
%}

WS [ \t]
LOWER [a-z]+
UPPER [A-Z]+
INT "0"|[1-9][0-9]*
TYPE_DECL_INT [ \t]*int[ \t\n]+
INCLUDE_PREFIX {WS}*"#"{WS}*"include"{WS}+
ALPHA_NUMERIC [a-zA-Z0-9]
STAR "*"
UNDERSCORE "_"
LBRACKET "["
RBRACKET "]"
SEMICOLON ";"

%%
[ ]     { char_offset+=1; col_number+=1; }
\t	{ char_offset+=4;col_number+=4; }
.	{ char_offset++; col_number++; }
\n { line_no++;state = LOOKUP; char_offset++; col_number=1;  } /* end of line, return to default state */

{INCLUDE_PREFIX}["]({ALPHA_NUMERIC}+|"/"|"_")".h"["] {
  printf("include:line_no:%d:col_number:%d:%s\n",line_no,col_number,yytext);
  char_offset+=yyleng;
  col_number+=yyleng;
  }

{INCLUDE_PREFIX}[<]({ALPHA_NUMERIC}+|"/"|"_")".h"[>] {
  printf("include:line_no:%d:col_number:%d:%s\n",line_no,col_number,yytext);
  char_offset+=yyleng;
  col_number+=yyleng;
  }


"int argc" { 
  printf("argc:line_no:%d:col_number:%d:%s\n",line_no,col_number,yytext);
  char_offset+=yyleng;
  col_number+=yyleng;
}


"char *argv[]" { 
  printf("argv:line_no:%d:col_number:%d:%s\n",line_no,col_number,yytext);
  char_offset+=yyleng;
  col_number+=yyleng;
}


{TYPE_DECL_INT}"main(" {
  printf("main_function:line_no:%d:col_number:%d:%s\n",line_no,col_number,yytext);
  char_offset+=yyleng;
  col_number+=yyleng;
}


"//".*	{ 
  printf("comment:line_no:%d:col_number:%d:%s\n",line_no,col_number,yytext);
  char_offset+=yyleng;
  col_number+=yyleng;
  col_number+=1;
}
"char"{WS}*{STAR}{0,2}{WS}*{LOWER}({ALPHA_NUMERIC}|"_")+({LBRACKET}{INT}{RBRACKET})* {
  printf("char_typec:line_no:%d:col_number:%d:%s\n",line_no,col_number,yytext);
  char_offset+=yyleng;
  col_number+=yyleng;
  col_number+=1;
}



[^a-zA-Z0-9]return[ \t]+{INT} {
  if (col_number > 1) {col_number+=1;}
  printf("return_function:line_no:%d:col_number:%d:%s\n",line_no,col_number,yytext);
  char_offset+=yyleng;
  col_number+=yyleng;
}


[^a-zA-Z0-9]int[ \t]+[a-zA-Z]+[ \t]+"="[ \t]+{INT} {
  if (col_number > 1) {col_number+=1;}
  sds s = sdsnew(yytext);
  sdstrim(s," \n(");
  sdsrange(s,4,20);
  printf("int_assigned_value:line_no:%d:col_number:%d:%s\n",line_no,col_number,s);
  char_offset+=yyleng;
  col_number+=yyleng;
  sdsfree(s);
}


"(".*?")"	{
  //if (col_number > 1) {col_number+=1;}
  printf("expression:line_no:%d:col_number:%d:%s\n",line_no,col_number,yytext);
  char_offset+=yyleng;
  col_number+=yyleng;
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



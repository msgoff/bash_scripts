%{

//https://github.com/gcc-mirror/gcc/blob/master/gcc/gengtype-lex.l

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

  void print_location(char *ID);

%}

LOWER [a-z]+
UPPER [A-Z]+
DIGIT [0-9]
NONZEROINT [1-9][0-9]*
ZERO "0"
FLOAT ({ZERO}|{NONZEROINT}+)"."{DIGIT}+f
DOUBLE ({ZERO}|{NONZEROINT}+)"."{DIGIT}+


TYPE_DECL_INT [ \t]*int[ \t\n]+
INCLUDE_PREFIX {WS}*"#"{WS}*"include"{WS}+
STAR "*"
UNDERSCORE "_"
LBRACKET "["
RBRACKET "]"
SEMICOLON ";"

CID	[[:alpha:]_][[:alnum:]_]*
WS	[[:space:]]+
HWS	[ \t\r\v\f]*
IWORD	short|long|(un)?signed|char|int|uint64_t|int64_t|bool|size_t|float|double
ITYPE	{IWORD}({WS}{IWORD})*


%%
[ ]     { char_offset+=1; col_number+=1; }
\t	{ char_offset+=4;col_number+=4; }
.	{ char_offset++; col_number++; }
\n { line_no++;state = LOOKUP; char_offset++; col_number=1;  } /* end of line, return to default state */


{ITYPE}({WS}+{STAR}{0,2}{WS}*|{WS}*{STAR}{0,2}{WS}+){CID}({LBRACKET}({NONZEROINT}+|""){RBRACKET})* {
	print_location("type_def");}

{INCLUDE_PREFIX}["]([:alnum:]+|"/"|"_")".h"["] {
	print_location("include");}

{INCLUDE_PREFIX}[<]([:alnum:]+|"/"|"_")".h"[>] {
	print_location("include");}

{TYPE_DECL_INT}"main(" {
	print_location("main_function");}

"//".*	{ 
	print_location("comment");}

[^a-zA-Z0-9]return[ \t]+{DIGIT} {
  if (col_number > 1) {col_number+=1;}
	print_location("return_statement");}

[^a-zA-Z0-9]float[ \t]+[a-zA-Z]+[ \t]+"="{WS}+{FLOAT}({WS}*","{WS}*{FLOAT})* {
  if (col_number > 1) {col_number+=1;}
  sds s = sdsnew(yytext);
  sdstrim(s," \n(");
  sdsrange(s,6,20);
  printf("float_assigned_value:line_no:%d:col_number:%d:%s\n",line_no,col_number,s);
  char_offset+=yyleng;
  col_number+=yyleng;
  sdsfree(s);}

[^a-zA-Z0-9]double[ \t]+[a-zA-Z]+[ \t]+"="{WS}+{DOUBLE}({WS}*","{WS}*{DOUBLE})* {
  if (col_number > 1) {col_number+=1;}
  sds s = sdsnew(yytext);
  sdstrim(s," \n(");
  sdsrange(s,6,20);
  printf("double_assigned_value:line_no:%d:col_number:%d:%s\n",line_no,col_number,s);
  char_offset+=yyleng;
  col_number+=yyleng;
  sdsfree(s);}

[^a-zA-Z0-9]int[ \t]+[a-zA-Z]+[ \t]+"="[ \t]+({ZERO}|{NONZEROINT}+) {
  if (col_number > 1) {col_number+=1;}
  sds s = sdsnew(yytext);
  sdstrim(s," \n(");
  sdsrange(s,4,20);
  printf("int_assigned_value:line_no:%d:col_number:%d:%s\n",line_no,col_number,s);
  char_offset+=yyleng;
  col_number+=yyleng;
  sdsfree(s);}


"(".*?")"	{
	print_location("expression");}


">>="			{ print_location("RIGHT_ASSIGN"); }
"<<="			{ print_location("LEFT_ASSIGN"); }
"+="			{ print_location("ADD_ASSIGN"); }
"-="			{ print_location("SUB_ASSIGN"); }
"*="			{ print_location("MUL_ASSIGN"); }
"/="			{ print_location("DIV_ASSIGN"); }
"%="			{ print_location("MOD_ASSIGN"); }
"&="			{ print_location("AND_ASSIGN"); }
"^="			{ print_location("XOR_ASSIGN"); }
"|="			{ print_location("OR_ASSIGN"); }
">>"			{ print_location("RIGHT_OP"); }
"<<"			{ print_location("LEFT_OP"); }
"++"			{ print_location("INC_OP"); }
"--"			{ print_location("DEC_OP"); }
"->"			{ print_location("PTR_OP"); }
"&&"			{ print_location("AND_OP"); }
"||"			{ print_location("OR_OP"); }
"<="			{ print_location("LE_OP"); }
">="			{ print_location("GE_OP"); }
"=="			{ print_location("EQ_OP"); }
"!="			{ print_location("NE_OP"); }

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

void print_location(char *ID){
  printf("%s:line_no:%d:col_number:%d:%s\n\n",ID,line_no,col_number,yytext);
  char_offset+=yyleng;
  col_number+=yyleng;
}


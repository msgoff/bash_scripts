%{

  enum {
    LOOKUP = 0, /* default - looking rather than defining. */
    INCLUDE,
    COMMENT,
  };

  int state;

  int add_word(int type, char *word);
  int lookup_word(char *word);
  void filter_yytext(char filter[], char *yytext, int yyleng);
  char filter[] = {'\n', '(', '\t'};
%}

%%

\n { state = LOOKUP; } /* end of line, return to default state */

^#include { state = INCLUDE; }

"<"[a-zA-Z]+".h>" {
  printf("include:%s\n", yytext);
  /* a normal word, define it or look it up */
  if (state != LOOKUP) {
    /* define the current word */
    add_word(state, yytext);
  } else {
    switch (lookup_word(yytext)) {
    case INCLUDE:
      printf("%s: include\n", yytext);
      break;
    default:
      printf("%s:  don't recognize\n", yytext);
      break;
    }
  }
}

[^a-zA-Z0-9]int[ \t]+[a-zA-Z]+ {
  printf("TYPE_INT:");
  filter_yytext(filter, yytext, yyleng);
  printf("\n");
}

[^a-zA-Z0-9]return[ \t]+[0-9] {
      printf("return_statement:");
      char filter[] = {'r', 'e', 't', 'u', 'n'};
      filter_yytext(filter, yytext, yyleng);
    }

"/*".*?"*/" {
  printf("COMMENT:%s\n", yytext);
}

"//".* { printf("COMMENT:%s\n", yytext); }
"void" { printf("VOID "); }
"while" { printf("WHILE "); }
"..." { printf("ELLIPSIS "); }
">>=" { printf("RIGHT_ASSIGN "); }
"<<=" { printf("LEFT_ASSIGN "); }
"+=" { printf("ADD_ASSIGN "); }
"-=" { printf("SUB_ASSIGN "); }
"*=" { printf("MUL_ASSIGN "); }
"/=" { printf("DIV_ASSIGN "); }
"%=" { printf("MOD_ASSIGN "); }
"&=" { printf("AND_ASSIGN "); }
"^=" { printf("XOR_ASSIGN "); }
"|=" { printf("OR_ASSIGN "); }
">>" { printf("RIGHT_OP "); }
"<<" { printf("LEFT_OP "); }
"++" { printf("INC_OP "); }
"--" { printf("DEC_OP "); }
"->" { printf("PTR_OP "); }
"&&" { printf("AND_OP "); }
"||" { printf("OR_OP "); }
"<=" { printf("LE_OP "); }
">=" { printf("GE_OP "); }
"==" { printf("EQ_OP "); }
"!=" { printf("NE_OP "); }
[\n]+ ;
. /* ignore anything else */;

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

//needs work
void filter_yytext(char filter[], char *yytext, int yyleng) {
  int i = 0;
  int j = 0;
  int ignore_char = 0;
  int x = sizeof(&filter);
  int y = sizeof(int);
  int array_length = x / y;
  char last_seen = 'z';

  for (i = 0; i < yyleng; i++) {
    ignore_char = 0;
    for (j = 0; j < array_length; j++) {
      if (yytext[i] == filter[j]) {
        ignore_char = 1;
      }
    }
    if (ignore_char == 0) {
        printf("%c", yytext[i]);
      }
    }
  }


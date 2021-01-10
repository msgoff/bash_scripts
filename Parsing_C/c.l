%{
#include <stdio.h>
%}

%%
[^a-z]int[^a-z]		{ printf("INT "); }
"\("			{ printf("LPAREN "); }	
\)			{ printf("RPAREN "); }
\{			{ printf("LBRACE "); }
\}			{ printf("RBRACE "); }
char			{ printf("CHAR "); }
\[			{ printf("LBRAC "); } 
\]			{ printf("RBRAC "); }
=			{ printf("EQ "); }
,			{ printf("COMMA "); }
;			{ printf("SEMICOLON "); }	
for			{ printf("FOR "); }
typedef[ ]enum		{ printf("TYPEDEF_ENUM "); } 
void			{ printf("VOID "); } 
typedef[ ]struct	{ printf("TYPDEF_STRUCT "); } 
swtich\(		{ printf("SWITCH "); } 
if  			{ printf("IF "); }  
\+			{ printf("ADD "); }  
return 			{ printf("RETURN "); } 
-> 			{ printf("ARROW "); } 
^#include.*?>		{ printf("INCLUDE\n"); }
'\n'			{ printf("\n"); }	
printf			{ printf("PRINT "); }	
EXIT_SUCCESS		{ printf("RETURN_MESSAGE "); } 
\".*?\"			{ printf("STRING "); } 
"puts" 			{ printf("PUTS "); } 
"auto"			{ printf("AUTO "); }
"_Bool"			{ printf("BOOL "); }
"break"			{ printf("BREAK "); }
"case"			{ printf("CASE "); }
"char"			{ printf("CHAR "); }
"_Complex"		{ printf("COMPLEX "); }
"const"			{ printf("CONST "); }
"continue"		{ printf("CONTINUE "); }
"default"		{ printf("DEFAULT "); }
"do"			{ printf("DO "); }
"double"		{ printf("DOUBLE "); }
"else"			{ printf("ELSE "); }
"enum"			{ printf("ENUM "); }
"extern"		{ printf("EXTERN "); }
"float"			{ printf("FLOAT "); }
"for"			{ printf("FOR "); }
"goto"			{ printf("GOTO "); }
"if"			{ printf("IF "); }
"_Imaginary"		{ printf("IMAGINARY "); }
"inline"		{ printf("INLINE "); }
"int"			{ printf("INT "); }
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
"while"			{ printf("WHILE "); }
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




%%

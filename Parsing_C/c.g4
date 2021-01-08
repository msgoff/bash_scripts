grammar c;


L_PAREN          : '(' ;
R_PAREN          : ')' ;
L_SQUARE         : '[' ;
R_SQUARE         : ']' ;
EQUAL            : '=' ;
DOT              : '.' ;   
COMMA            : ',' ;


INT:	[1-9][0-9]*;


expression:
	keyword+ 
	;



keyword:
	'auto'
	|'break'
	|'case'
	|'const'
	|'continue'
	|'default'
	|'goto'
	|'enum'
	|'for'
	|'return'
	|'signed'
	|'sizeof'
	|'auto'
	|'break'
	|'case'
	|'char'
	|'const'
	|'continue'
	|'default'
	|'do'	
	|'double'
	|'else'
	|'enum'
	|'extern'
	|'float'
	|'goto'
	|'if'
	|'int'
	|'long'
	|'return'
	|'short'
	|'signed'
	|'sizeof'
	|'struct'
	|'switch'
	|'typedef'
	|'union'	
	|'unsigned'
	|'void'
	;

assignment_operators:
	'>>='    //RIGHT
	|'<<='    //LEFT
	|'+='    //ADD
	|'-='    //SUB
	|'*='    //MUL
	|'/='    //DIV
	|'%='    //MOD
	|'&='    //AND
	|'^='    //XOR
	|'|='    //OR
	;

relational_operator:
	|'>>'			//RIGHT
	|'<<'			//LEFT
	|'++'			//INC
	|'--'			//DEC
	|'->'			//PTR
	|'&&'			//AND
	|'||'			//OR
	|'<='			//LE
	|'>='			//GE
	|'=='			//EQ
	|'!='			//NE
	;

include:
	'#include <stdio.h>
	;


WS: [ \t\n] -> skip;

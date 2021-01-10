grammar c;


L_PAREN: 
	'(' 
	;

R_PAREN:
	')'
	;

L_SQUARE: 
	'[' 
	;

R_SQUARE:
	 ']'
	 ;

EQUAL: 
	'=' 
	;

DOT: 
	'.' 
	;   

COMMA: 
	'' 
	;


INT:	[1-9][0-9]*;


expression:
	keyword+ 
	;

selection_statement: 
	IF '(' expression ')' statement
	| IF '(' expression ')' statement ELSE statement
	| SWITCH '(' expression ')' statement
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
	;
comment:
	'/*.*?*/';

unary_operator: 
	'&'
	| '*'
	| '+'
	| '-'
	| '~'
	| '!'
	;

type_specifier:
	'void'
	| 'char'
	| 'short'
	| 'int'
	| 'long'
	| 'float'
	| 'double'
	| 'signed'
	| 'unsigned'
	| 'bool'
	| 'complex'
	;

assignment_operators:
	'>>='    
	|'<<='    
	|'+='    
	|'-='    
	|'*='    
	|'/='    
	|'%='    
	|'&='    
	|'^='    
	|'|='    
	;

relational_operator:
	'>>'			
	|'<<'			
	|'++'			
	|'--'			
	|'->'			
	|'&&'			
	|'||'			
	|'<='			
	|'>='			
	|'=='			
	|'!='			
	;

misc:
	'<unistd.h>'
	|'<math.h>'
	| 'FILE'
	| 'while'
	| '#include <strings.h>'
	| '#include <ctype.h>'
	| '#include <string.h>'
	| '#undef'
	| 'atoi'
	| '#include <stdlib.h>'
	| '#include <stdio.h>'
	| '#define'
	| 'main(int argc char *argv[])'
	| 'printf'
	| '#include'
	| 'main()'
	| '#include <gmp.h>'
	| '<assert.h>'
	| '%lf'
	| '%ld'
	| 'srand'
	| 'calloc'
	| 'alloc'
	| 'fclose()'
	| '<limits.h>'
	| 'stdout'
	| 'fclose'
	| 'rand()'
	| '<sys/stat.h>'
	| '<fcntl.h>'
	| 'static'
	| 'argv'
	| 'stderr'
	| '**'
	| '<std '
	| '%s'
	| '%d'
	| 'malloc'
	| '<stdlib.h>'
	| 'free'
	| '#ndef'
	;

include:
	'#include <stdio.h>'
	;


WS: 
	' '
	|'\t'
	|'\n'
	;

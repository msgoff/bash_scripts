grammar C;

file:	(func | var | INCLUDE | DeclRefExpr )+
    ;

func:	type_specifier LOWER '(' type_specifier ')' '\n'?
    |   type_specifier LOWER '(' type_specifier ')' '{' '\n'
    |   type_specifier LOWER '(' type_specifier ')' '\n' '{'
    |   func (DeclRefExpr+| ReturnStmt)
    ;

DeclRefExpr:
    'printf(' STRING ')'';';

var :	'extern'? type_specifier ID ';' ;

INCLUDE:
    '#include' [ \t]* '<' LOWER '.h>' [ \t]* '\r'? '\n';

fragment
STRING : '"' .*? '"' ;


LINE_COMMENT
    : '//' ~('\n'|'\r')* '\r'? '\n'
    ;


ReturnStmt:
    'return EXIT_SUCCESS;' '\n'* '}'
    | 'return' 'EXIT_SUCCESS' ';' '\n'* '}'
    | 'return' INT ';' '\n'* '}'

    ;

assignment_operator:
    '='
    |'*='
    |'/='
    |'%='
    |'+='
    |'-='
    |'<<='
    |'>>='
	| '&='
	| '^='
	| '|='
	;

type_specifier
	: 'void'
	| 'char'
	| 'short'
	| 'int'
	| 'long'
	| 'float'
	| 'double'
	| 'signed'
	| 'unsigned'
	;

LOWER:
    [a-z]+;

ID:	[a-zA-Z]+ ;

INT :   '0' | [1-9][0-9]*;

WS  :   [ \t\n\r]+ -> channel(HIDDEN) ;

SL_COMMENT
    :   '//' .*? '\r'? '\n' -> channel(HIDDEN)
    ;

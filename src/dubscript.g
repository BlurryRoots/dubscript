grammar dubscript;

/*conditional_expression
: logical_or_expression ('?' expression ':' conditional_expression)?
;

logical_or_expression
: logical_and_expression ('||' logical_and_expression)*
;

logical_and_expression
: inclusive_or_expression ('&&' inclusive_or_expression)*
;

primary_expression
: IDENTIFIER
| constant
| '(' expression ')'
;*/

program
: block
| EOF;

block
: (statement ';')*
;

statement
: expression ':' '{' block '}'
;

expression
: conditional_expression
;

conditional_expression
: or_expression
;

or_expression
: and_expression (OR and_expression)*
;

and_expression
: equality_expression (AND equality_expression)*
;

equality_expression
:  relational_expression ((NE | EQ) relational_expression)*
;

relational_expression
:  basic_expression ((LE | LT | GE | GT) basic_expression)*
;

basic_expression
: IDENTIFIER
| constant
| '(' expression ')'
;

constant
: '-'? (HEX_LITERAL | REAL_LITERAL | INTEGER_LITERAL)
| STRING_LITERAL
| TRUE | FALSE
;

AND
: '&';
OR
: '|';

EQ
: '=';
NE
: '\\=';

GT
: '>';
GE
: '>=';
LT
: '<';
LE
: '<=';

TRUE
: 'true';
FALSE
: 'false';

STRING_LITERAL
: '\'' ~('\'')* '\''
;

INTEGER_LITERAL
: DIGIT+
;
REAL_LITERAL
: DIGIT+ ('.' DIGIT+)
;
HEX_LITERAL
: HEXDIGIT+
;

ESCAPE_SEQUENCE
: '\\' ('t' | 'n' | 'r' | '\'' | '\\');

IDENTIFIER
: LETTER (LETTER | DIGIT)*;

fragment
LETTER
: '$'
| CHAR
| '_';

DIGIT
: '0'..'9';
HEXDIGIT
: ('0'..'9' | 'a'..'f' | 'A'..'F')
;

CHAR
: 'A'..'Z'
| 'a'..'z';

WHITESPACE
: (' ' | '\r' | '\t' | '\u000C' | '\n') -> skip
;

/*program
: statement* EOF;

statement
: 
(   define
|   is_defined)
DELIMITER;

define
: KEYWORD_DEFINE ID (INTEGER | REAL);

undefine
: KEYWORD_UNDEFINE ID;

is_defined
: KEYWORD_IS_DEFINED ID;

REAL
: '-'? DIGIT+ '.' DIGIT+;

INTEGER
: '-'? DIGIT+;

KEYWORD_DEFINE
: 'def!';

KEYWORD_UNDEFINE
: 'undef!';

KEYWORD_IS_DEFINED
: 'def?';

ID
: ('_' | CHAR) (CHAR | '_' | DIGIT)*;

LOG_NEQ
: '\=';
LOG_EQ
: '=';
LOG_OR
: '|';
LOG_AND
: '&';

DELIMITER
: ';';

PATTERN_OPERATOR
: ':';

SBLOCK
: '{';
EBLOCK
: '}';

SPAREN
: '(';
EPAREN
: ')';

CHAR
: 'a'..'z'|'A'..'Z';

DIGIT
: '0'..'9';*/
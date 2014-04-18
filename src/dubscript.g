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
: statement*
| EOF;

block
: '{' statement* '}'
;

statement
: expression ';'
| conditinal_statement ';'
| KEYWORD_DEFINE IDENTIFIER expression ';'
| KEYWORD_UNDEFINE IDENTIFIER ';'
;

conditinal_statement
: expression pattern_block+
;
pattern_block
: ':' pattern* block
;

pattern
: expression
;

expression
: conditional_expression
| KEYWORD_IS_DEFINED IDENTIFIER
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

KEYWORD_DEFINE
: 'def!';

KEYWORD_UNDEFINE
: 'rm!';

KEYWORD_IS_DEFINED
: 'def?';

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
: '\"' ~('\"')* '\"'
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
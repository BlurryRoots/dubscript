grammar dubscript;

program
: statement*
| EOF
;

block
: '{' statement* '}'
;

statement
: ( expression
  | conditinal_statement
  | define_statement
  | undefine_statement
  | set_statement
  | return_statement
  ) ';'
;

define_statement
: KEYWORD_DEFINE IDENTIFIER expression
;
set_statement
: KEYWORD_SET IDENTIFIER expression
;
undefine_statement
: KEYWORD_UNDEFINE IDENTIFIER
;
return_statement
: KEYWORD_RETURN expression
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
: artithmetic_expression
| conditional_expression
| list_expression
| map_expression
| lamnda_expression
| KEYWORD_IS_DEFINED IDENTIFIER
| member_expression
;

object_expression
: IDENTIFIER
| list_expression
| '(' expression ')'
;

member_expression
:  object_expression '.' IDENTIFIER expression*
;

map_expression
: '<' pair_expression* '>'
;
pair_expression
: '(' expression expression ')'
;

list_expression
: '[' expression* ']'
;

lamnda_expression
: '(' IDENTIFIER* ')' '->' block
;

artithmetic_expression
: sum_exression
;
sum_exression
: product_expression ((PLUS | MINUS) product_expression)*
;
product_expression
: basic_expression ((MULTIPLY | DIVISION) basic_expression)*
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
: relational_expression ((NE | EQ) relational_expression)*
;
relational_expression
: basic_expression ((LE | LT | GE | GT) basic_expression)*
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
: 'def!'
;
KEYWORD_SET
: 'set!'
;
KEYWORD_IS_DEFINED
: 'def?'
;
KEYWORD_UNDEFINE
: 'rm!'
;
KEYWORD_RETURN
: 'return'
;

PLUS
: '+'
;
MINUS
: '-'
;
MULTIPLY
: '*'
;
DIVISION
: '/'
;

AND
: '&'
;
OR
: '|'
;

EQ
: '='
;
NE
: '\\='
;

GT
: '>'
;
GE
: '>='
;
LT
: '<'
;
LE
: '<='
;

TRUE
: 'true'
;
FALSE
: 'false'
;

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
: '0x' HEXDIGIT+
;

ESCAPE_SEQUENCE
: '\\' ('t' | 'n' | 'r' | '\'' | '\\')
;

IDENTIFIER
: LETTER (LETTER | DIGIT)*
;

fragment
LETTER
: '$'
| CHAR
| '_'
;

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

MULTILINE_COMMENT
: ('/' '*' .*? '*' '/') -> skip
;
LINE_COMMENT
: '/' '/' ~('\u000C' | '\r' | '\n')* -> skip
;
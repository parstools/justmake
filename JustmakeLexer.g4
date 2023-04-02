/*
 * [Apache License, Version 2.0]
 *  Copyright (c) 2023 Andrzej Borucki */

lexer grammar JustmakeLexer;

Whitespace
    :   [ \t]+
        -> skip
    ;

Newline
    :   (   '\r' '\n'?
        |   '\n'
        )
    ;

BlockComment
    :   '/*' .*? '*/'
        -> skip
    ;

LineComment
    :   '//' ~[\r\n]*
        -> skip
    ;

StringLiteral
    :   '"' SCharSequence? '"'
    ;

// Separators
LPARENT:             '(';
RPARENT:             ')';
LBRACE:             '{';
RBRACE:             '}';
LSQUARE:            '[';
RSQUARE:            ']';
SEMI:               ';';
COMMA:              ',';
DOT:                '.';
COLON:              ':';

// Operators
ASSIGN:             '=';
ADD:                '+';
MUL:                '*';

FN
    : 'fn'
    ;

Identifier
    :   AsciiLetter
        (   Nondigit
        |   Digit
        )*
    ;

JoinLines
    : ' '* '\\' ' '* Newline
       -> skip
    ;

fragment
AsciiLetter
    :   [a-zA-Z]
    ;

fragment
Nondigit
    :   [a-zA-Z_]
    ;

fragment
SCharSequence
    :   SChar+
    ;

fragment
SChar
    :   ~["\\\r\n\t]
    |   EscapeSequence
    ;

fragment
EscapeSequence
    :   SimpleEscapeSequence
    |   HexadecimalEscapeSequence
    ;

fragment SimpleEscapeSequence
	: '\\n'
	| '\\r'
	| '\\t'
	| '\\\\'
	| '\\"'
	;

Integer
    : NonzeroDigit Digit*
    ;

fragment
HexadecimalEscapeSequence
    :   '\\x' HexadecimalDigit+
    ;


fragment
Digit
    :   [0-9]
    ;

fragment
NonzeroDigit
    :   [1-9]
    ;

fragment
HexadecimalDigit
    :   [0-9a-fA-F]
    ;

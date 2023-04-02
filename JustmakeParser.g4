/*
 * [Apache License, Version 2.0]
 *  Copyright (c) 2023 Andrzej Borucki */

parser grammar JustmakeParser;

options { tokenVocab = JustmakeLexer; }

document
    :  statements EOF
    ;

statements
    : statement (Newline+ statement)* Newline*
    ;

statement
    : assignment
    | methodCall
    | funcDef
    ;

funcDef
    : FN LPARENT parameterList? RPARENT funcBlock
    ;

funcBlock
    : LBRACE statements RBRACE
    ;


parameterList
    : parameter (COMMA parameter)*
    ;

parameter
    :   Identifier
    ;

methodCall
    : variableAccess LPARENT argumentList? RPARENT
    ;

variableAccess
    : variableAccess DOT field
    | field
    ;

field
    : Identifier
    ;

argumentList
    : expression (COMMA expression)*
    ;

expression
    : expression ADD term
    | term
    ;

term
    : StringLiteral
    | listInPlace
    | variableAccess
    | methodCall
    ;

listInPlace
    : LSQUARE listElements? RSQUARE
    ;

listElements
    : listElement (COMMA listElements)*
    ;

listElement
    : variable
    | StringLiteral
    | listInPlace
    ;

variable
    : Identifier
    ;

assignment
    : variableAccess ASSIGN expression
    ;

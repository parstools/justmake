/*
 * [Apache License, Version 2.0]
 *  Copyright (c) 2023 Andrzej Borucki */

parser grammar JustmakeParser;

options { tokenVocab = JustmakeLexer; }

document
    :  statements EOF
    ;

commands
    : command (Newline+ command)* Newline*
    ;

statements
    : statement (Newline+ statement)* Newline*
    ;

command
    : assignment
    | methodCall
    | if_statement
    | return_statement
    ;

statement
    : command
    | funcDef
    ;

return_statement
    : RETURN expression
    ;

funcDef
    : FN Identifier LPARENT parameterLists RPARENT funcResult? funcBlock
    ;

parameterLists
    : parameterList
    | defaultParameterList
    | parameterList COMMA defaultParameterList
    |
    ;

funcBlock
    : LBRACE Newline statements RBRACE
    ;

funcResult
    : Arrow type
    ;

type
    : LIST
    ;

parameterList
    : parameter (COMMA parameter)*
    ;

defaultParameterList
    : defaultParameter (COMMA defaultParameter)*
    ;

parameter
    :   Identifier
    ;

defaultParameter
    :   Identifier ASSIGN simpleTerm
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

condition
    : expression relationalOperator expression
    ;

relationalOperator
    : EQ | NEQ | LT | LTE | GT | GTE
    ;

simpleTerm
    : StringLiteral
    | Integer
    ;

term
    : simpleTerm
    | listInPlace
    | variableAccess
    | methodCall
    ;

listInPlace
    : LSQUARE listElements? RSQUARE
    ;

listElements
    : expression (COMMA Newline? expression)*
    ;

variable
    : Identifier
    ;

assignment
    : variableAccess ASSIGN expression
    ;

if_statement
    : IF condition Newline commands (ELSEIF condition Newline commands)? (ELSE Newline commands)? ENDIF
    ;

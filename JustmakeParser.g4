/*
 * [Apache License, Version 2.0]
 *  Copyright (c) 2023 Andrzej Borucki */

parser grammar JustmakeParser;

options { tokenVocab = JustmakeLexer; }

document
    : statement (Newline+ statement)* Newline* EOF
    ;

statement
    : Identifier Integer
    ;

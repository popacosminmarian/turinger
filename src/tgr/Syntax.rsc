module tgr::Syntax

/*
 * Concrete syntax for Turinger.
 */

start syntax Program = TM* tms Simulation* simulations;

syntax TM = "TM" Str name ":" "{" "init" Str init Trans* trs "}";

syntax Trans = Str source Char read Char replace Dir dir Str target;

syntax Dir = "l" | "L" | "r" | "R" | "*";

syntax Simulation = "simulate" Str tm "(" InputChar* input ")" Int steps "show-every" Int skip 
				  |  "simulate" Str tm "(" InputChar* input ")" Int steps;

// Helpers and lexicals
lexical Int = [0-9]+ !>> [0-9];
lexical Bool = "true" | "false";
lexical Char = [A-Za-z0-9_*];
lexical InputChar = Char \ "*";
lexical Str = [A-Za-z][A-Za-z0-9_\-]*;
lexical LAYOUT = [\t-\n\r\ ] | @category="Comment" "@" ![@]+ "@";
layout LAYOUTLIST = LAYOUT*  !>> [\t-\n\r\ @];
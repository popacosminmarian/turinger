module tgr::Syntax

/*
 * Define concrete syntax for CCL. The language's specification is available in the PDF (Section 3)
*/


start syntax Program = TM* tms Simulation* simulations;

syntax TM = "TM" Str name "{" Trans* trs "}";

syntax Trans = Str source Char read Char replace Dir dir Str target;

syntax Dir = "l" | "L" | "r" | "R" | "*";

syntax Simulation = "simulate" Str tm "(" Input input ")" Int steps;

syntax Input = Char* \ "*";

// Helpers and lexicals
lexical Int = [0-9]+ !>> [0-9];
lexical Bool = "true" | "false";
lexical Char = [A-Za-z0-9_*];
lexical Str = [A-Za-z][A-Za-z0-9_\-]*;
lexical LAYOUT = [\t-\n\r\ ] | @category="Comment" "@" ![@]+ "@";
layout LAYOUTLIST = LAYOUT*  !>> [\t-\n\r\ @];
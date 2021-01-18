module tgr::Syntax

/*
 * Define concrete syntax for CCL. The language's specification is available in the PDF (Section 3)
*/


start syntax Program = TM* tms Main main;

syntax TM = "TM" Str name "{" Trans* trans "}";

syntax Trans = Str source CharOrStar read CharOrStar replace Dir dir Str target;
syntax CharOrStar = Char | "*";
syntax Dir = "l" | "L" | "r" | "R" | "*";

syntax Main = "main" "{" Simulation* simulations "}";

syntax Simulation = "simulate" Str tm "(" Char* input ")" Int steps;

// Helpers and lexicals
lexical Int = [0-9]+;
lexical Bool = "yes" | "no";
lexical Char = [A-Za-z0-9_*];
lexical Str = [A-Za-z][A-Za-z0-9_\-]*;
lexical LAYOUT = [\t-\n\r\ ];
layout LAYOUTLIST = LAYOUT*  !>> [\t-\n\r\ ];
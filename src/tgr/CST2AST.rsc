module tgr::CST2AST

import tgr::AST;
import tgr::Syntax;

/*
 * -Implement a mapping from concrete syntax trees (CSTs) to abstract syntax trees (ASTs)
 * - Hint: Use switch to do case distinction with concrete patterns 
 * - Map regular CST arguments (e.g., *, +, ?) to lists 
 * - Map lexical nodes to Rascal primitive types (bool, int, str)
 */
 
 AProgram cst2ast(start[Program] sf) {
 	Program p = sf.top;
 	AProgram result = program([cst2ast(p) | (TM tm <- p.tms)], [cst2ast(p) | (Sim s <- p.sims)]);
 	return result;
 }
 
 ATM cst2ast(TM t) {
 	return tm("<t.name>", "<t.init>", [cst2ast(p) | (Trans tr <- t.trans)]);
 }
 
 ASim cst2ast(Sim s) {
 	return sim("<s.tm>", "<s.input>", toInt("<s.steps>"));
 }
 
 ATrans cst2ast(Trans tr) {
 	return trans("<tr.source>", "<tr.source>", "<tr.replace>", "<tr.dir>", "<tr.target>");
 }
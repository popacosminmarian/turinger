module tgr::CST2AST

import String;
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
 	AProgram result = program([cst2ast(tm) | (TM tm <- p.tms)], [cst2ast(s) | (Simulation s <- p.simulations)]);
 	return result;
 }
 
 ATM cst2ast(TM t) {
 	return tm("<t.name>", "<t.init>", [cst2ast(tr) | (Trans tr <- t.trs)]);
 }
 
 ASim cst2ast(Simulation s) {
 	return sim("<s.tm>", "<s.input>", toInt("<s.steps>"));
 }
 
 ATrans cst2ast(Trans tr) {
 	return trans("<tr.source>", "<tr.source>", "<tr.replace>", "<tr.dir>", "<tr.target>");
 }
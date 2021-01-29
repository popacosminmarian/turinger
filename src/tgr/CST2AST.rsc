module tgr::CST2AST

import String;
import tgr::AST;
import tgr::Syntax;

/*
 * Mapping from concrete syntax tree to abstract syntax tree
 */

AProgram cst2ast(start[Program] sf) {
	Program p = sf.top;
	AProgram result = program([cst2ast(tm) | (TM tm <- p.tms)], [cst2ast(s) | (Simulation s <- p.simulations)]);
	return result;
}

ATM cst2ast(TM t) {
	return tm("<t.name>", "<t.init>", {cst2ast(tr) | (Trans tr <- t.trs)});
}

ASim cst2ast((Simulation)`simulate <Str tm>(<InputChar* input>) <Int steps> show-every <Int showevery>`) {
	return sim("<tm>", "<input>", toInt("<steps>"), toInt("<showevery>"));
}

ASim cst2ast((Simulation)`simulate <Str tm>(<InputChar* input>) <Int steps>`) {
	return sim("<tm>", "<input>", toInt("<steps>"), 1);
}

ATrans cst2ast(Trans tr) {
	return trans("<tr.source>", "<tr.read>", "<tr.replace>", "<tr.dir>", "<tr.target>");
}
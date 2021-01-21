module tgr::Compile

import tgr::AST;
import List;
import IO;

void compile(AProgram p) {
	tms = p.tms;
	sims = p.simulations;
	if (size(tms) > 0) {
		for(int i <- [0 .. size(tms)]) {
			println(tms[i]);
		}
	}
	if (size(sims) > 0) {
		for(int i <- [0 .. size(sims)]) {
			println(sims[i]);
		}
	}
}
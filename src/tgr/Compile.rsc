module tgr::Compile

import tgr::AST;
import util::Math;
import Set;
import List;
import IO;
import Boolean;

str compile(AProgram p) {
	tms = p.tms;
	sims = p.simulations;
	
	str compiledProgram = "";
	
	// Add turing machines
	if (size(tms) > 0) {
		for(int i <- [0 .. size(tms)]) {
			compiledProgram += buildTM(tms[i]);
		}
	}
	
	// Add simulations
	if (size(sims) > 0) {
		for(int i <- [0 .. size(sims)]) {
			compiledProgram += buildSim(sims[i]);
		}
	}
	
	return compiledProgram;
}

str buildTM(ATM tm) {
	// Initialize TM function
	str tmFunc = "def " + tm.name + "(inputtape, steps):\n";
	tmFunc += "    length = len(inputtape) + 2\n";
	tmFunc += "    tape = [\'_\']*length\n";
	tmFunc += "    i = 1\n";
	tmFunc += "    tapehead = 1\n";
	tmFunc += "    for s in inputtape:\n";
	tmFunc += "        tape[i] = s\n";
	tmFunc += "        i += 1\n";
	tmFunc += "    state = \"" + tm.init + "\"\n";
	tmFunc += "    step = 1\n";
	tmFunc += "    while (step \<= steps and state != \"accept\" and state != \"reject\"):\n";
	tmFunc += "        print \"Step \" + str(step - 1) + \":\"\n";
	tmFunc += "        print \"State \" + state\n";
	tmFunc += "        for x in range(len(tape)):\n";
	tmFunc += "            if x == tapehead:\n";
	tmFunc += "                print \"\>\",\n";
	tmFunc += "            print tape[x],\n";
	tmFunc += "        print \"\\n\"\n";
	tmFunc += "        step += 1\n\n";
	
	// Increase length of tape if necessary
	tmFunc += "        if tapehead == 0:\n";
	tmFunc += "            tape.insert(0, \"_\")\n";
	tmFunc += "            tapehead += 1\n";
	tmFunc += "        if tapehead == len(tape) - 1:\n";
	tmFunc += "            tape.append(\"_\")\n";
	tmFunc += "            tapehead -= 1\n\n";
	
	// Store base case transitions to put them at the end
	str baseCases = "";
	
	// Add all transitions as if-statements
	if (size(tm.transitions) > 0) {
		trsList = toList(tm.transitions);
		for (int i <- [0 .. size(tm.transitions)]) {
			tuple[str tr, bool baseCase] transitionFunction = buildTransition(trsList[i]);
			if (!transitionFunction.baseCase) {
				tmFunc += transitionFunction.tr;
			}
			else {
				baseCases += transitionFunction.tr;
			};
		}
	}
	
	// Add the base cases at the end
	tmFunc += baseCases;
	
	// Print last case
	tmFunc += "    print \"Step \" + str(step - 1) + \":\"\n";
	tmFunc += "    print \"State \" + state\n";
	tmFunc += "    for x in range(len(tape)):\n";
	tmFunc += "        if x == tapehead:\n";
	tmFunc += "            print \"\>\",\n";
	tmFunc += "        print tape[x],\n";
	tmFunc += "    print \"\\n\\n\"\n";
	
	return tmFunc;
}

tuple[str tr, bool baseCase] buildTransition(ATrans tr) {
	tuple[str tr, bool baseCase] result = <"", false>;
	str indent = "        ";
	str trCond = indent + "if state == \"" + tr.source + "\":\n";
	indent += "    ";
	if (tr.read != "*") {
		trCond += indent + "if tape[tapehead] == \"" + tr.read + "\":\n" ;
		indent += "    ";
	}
	else {
		result.baseCase = true;
	};
	
	if (tr.replace != "*") {
		trCond += indent + "tape[tapehead] = \"" + tr.replace + "\"\n";
	};
	
	trCond += indent + "state = \"" + tr.target + "\"\n";
	
	if (tr.dir == "l" || tr.dir == "L") {
		trCond += indent + "tapehead -= 1\n";
	}
	
	if (tr.dir == "r" || tr.dir == "R") {
		trCond += indent + "tapehead += 1\n";
	}
	
	trCond += indent + "continue\n";
	
	result.tr = trCond;
	
	return result;
}

str buildSim(ASim sim) {
	// Print GREEN TM name, input, strings
	str simCall = "print \'\\033[1m\' + \'\\033[92m\' + \"Turing Machine " + sim.tm + " with initial tape " 
					+ sim.input + " for " + toString(sim.steps) + " steps\" + \'\\033[0m\' + \"\\n\"\n";
	simCall += sim.tm + "(\"" + sim.input + "\", " + toString(sim.steps) + ")\n";
	return simCall;
}
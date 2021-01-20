module tgr::Check

import tgr::AST;
import IO;
import Exception;
import String;
import List;
import Set;
import Type;

/*
 * -Implement a well-formedness checker for the CCL language. For this you must use the AST. 
 * - Hint: Map regular CST arguments (e.g., *, +, ?) to lists 
 * - Hint: Map lexical nodes to Rascal primitive types (bool, int, str)
 * - Hint: Use switch to do case distinction with concrete patterns
 */


// Main check function
bool checkProgram(AProgram program) {
	println("-- CHECKING PROGRAM --");
	return checkTMNames(program)
		&& checkSimulatedTMs(program)
		&& checkTMFinalStates(program)
		&& succes();
}

// Check TM name uniqueness
bool checkTMNames(AProgram program) {
	// TM names list
	list[str] names = getTMNames(program);
	
	// Report duplicates, if they exist
	if (size(names) - size(dup(names)) > 0) {
		error("duplicate TM names: " + toString(names - dup(names)));
		return false;
	}
	
	println("No duplicate TM names found.");
	return true;
}

// Check that all simulated TMs exist
bool checkSimulatedTMs(AProgram program) {
	// TM names list
	list[str] names = getTMNames(program);
	
	// Simulated TM names list
	list[str] simNames = getSimTMNames(program);
	
	// Report non-existent TMs
	if (size(simNames - names) > 0) {
		error("non-existent TMs: " + toString(simNames - names));
		return false;
	}
	
	println("No non-existent TM names found.");
	return true;
}

// Check that all TMs have an accept (and reject) state
bool checkTMFinalStates(AProgram program) {
	for (/ATM tm := program.tms) {
		// States of current TM
		set[str] states = getAllTMStates(tm);
		
		// Check final states
		if ("accept" in states) {
			if ("reject" in states) {
				println("TM " + tm.name + " has accept and reject states.");
			} else {
				println("TM " + tm.name + " has accept state.");
			}
		} else {
			error("TM " + tm.name + " has no accept state");
			return false;
		}
	}
	return true;
}




/* ----- HELPER METHODS ----- */

set[str] getAllTMStates(ATM tm) {
	set[str] states = {tm.init};
	for (/ATrans trans := tm.transitions) {
		states = states + trans.source;
		states = states + trans.target;
	}
	return states;
}

// Get TM names
list[str] getTMNames(AProgram program) {
	list[str] names = [];
	for (/ATM tm := program.tms) {
		names = names + tm.name;
	}
	return names;
}

// Get simulated TM names
list[str] getSimTMNames(AProgram program) {
	list[str] names = [];
	for (/ASim sim := program.simulations) {
		names = names + sim.tm;
	}
	return names;
}

bool succes() {
	println("Check successful!\n");
	return true;
}

// Method for printing errors
void error(str msg) {
	println("ERROR: " + msg + "\n");
}
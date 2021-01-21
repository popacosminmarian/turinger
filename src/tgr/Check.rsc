module tgr::Check

import tgr::AST;
import IO;
import Exception;
import String;
import List;
import Set;
import Type;


/*
 * ----- MAIN WELL_FORMEDNESS CHECKER METHOD -----
 */
bool checkProgram(AProgram program) {
	log("-- CHECKING PROGRAM --");
	return checkTMNames(program)
		&& checkSimulatedTMs(program)
		&& checkTMFinalStates(program)
		&& checkTMDet(program)
		&& checkTMOutTrans(program)
		&& checkTMDefTrans(program)
		&& succes();
}


/*
 * ----- CHECKER METHODS -----
 */

// Check TM name uniqueness
bool checkTMNames(AProgram program) {
	// TM names list
	list[str] names = getTMNames(program);
	
	// Report duplicates, if they exist
	if (size(names) - size(dup(names)) > 0) {
		error("duplicate TM names: " + toString(names - dup(names)));
		return false;
	}
	
	log("No duplicate TM names found.");
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
	
	log("No non-existent TM names found.");
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
				log("TM " + tm.name + " has accept and reject states.");
			} else {
				log("TM " + tm.name + " has accept state.");
			}
		} else {
			error("TM " + tm.name + " has no accept state");
			return false;
		}
	}
	
	log("All TMs have accept (and/or reject) states.");
	return true;
}

// Check that all TMs are deterministic ((source, read) is PK for transitions)
bool checkTMDet(AProgram program) {
	for (/ATM tm := program.tms) {
		// Get first duplicate pair from tm
		tuple[str, str] dup = getFirstDupSourceReadPair(tm);
		
		// Check if TM is nondet
		if (dup != <"OK", "OK">) {
			error("TM " + tm.name + ": state " + dup[0] + " handles symbol \'" + dup[1] + "\' twice");
			return false;
		}
	}
	
	log("All TMs are deterministic.");
	return true;
}

// Check that all non-final states have outbound transitions
bool checkTMOutTrans(AProgram program) {
	for (/ATM tm := program.tms) {
		// Get state with no default transition
		set[str] states = getStatesNoOut(tm);
		
		// Check if TM is has non-default transition
		if (states != {}) {
			error("TM " + tm.name + ": states " + toString(states) + " have no outbound transitions");
			return false;
		}
	}
	
	log("All non-final states have outbound transitions.");
	return true;
}

// Check that all TMs have default transitions (for non-specified input characters)
bool checkTMDefTrans(AProgram program) {
	for (/ATM tm := program.tms) {
		// Get state with no default transition
		set[str] states = getStatesNoDef(tm);
		
		// Check if TM is has non-default transition
		if (states != {}) {
			error("TM " + tm.name + ": states " + toString(states) + " have no default transitions");
			return false;
		}
	}
	
	log("All TMs have default transitions.");
	return true;
}




/* 
 * ----- HELPER METHODS -----
 */

// Get states with no default transitions (e.g.: state * * * otherState)
set[str] getStatesNoDef(ATM tm) {
	set[str] statesWithDefault = {};
	set[str] states = getAllTMStates(tm);
	for (/ATrans trans := tm.transitions) {
		if (trans.read == "*") {
			statesWithDefault = statesWithDefault + trans.source;
		}
	}
	return states - statesWithDefault - {"accept", "reject"};
}

// Get non-final states with no outbound transitions
set[str] getStatesNoOut(ATM tm) {
	set[str] statesWithOut = {};
	set[str] states = getAllTMStates(tm);
	for (/ATrans trans := tm.transitions) {
		statesWithOut = statesWithOut + trans.source;
	}
	return states - statesWithOut - {"accept", "reject"};
}

// Get first (source, read) pair that appears twice
tuple[str, str] getFirstDupSourceReadPair(ATM tm) {
	list[tuple[str, str]] keys = [];
	for (/ATrans trans := tm.transitions) {
		if (<trans.source, trans.read> in keys) {
			return <trans.source, trans.read>;
		} else {
			keys = keys + <trans.source, trans.read>;
		}
	}
	return <"OK", "OK">;
}

// Get TM states
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

// Log a string; change the println() to whatever is needed
void log(str msg) {
	println(msg);
}

// Only logs if all checks successful
bool succes() {
	log("Check successful!\n");
	return true;
}

// Method for logging errors
void error(str msg) {
	log("ERROR: " + msg + "!\n");
}
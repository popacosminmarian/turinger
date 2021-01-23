module tgr::AST

/*
 * Abstract syntax for Turinger.
 */

public data AProgram = program(list[ATM] tms, list[ASim] simulations);

public data ATM = tm(str name, str init, set[ATrans] transitions);

public data ATrans = trans(str source, str read, str replace, str dir, str target);

public data ASim = sim(str tm, str input, int steps);

anno loc AProgram@location;
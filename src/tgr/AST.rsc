module tgr::AST

public data AProgram = program(list[ATM] tms, list[ASim] simulations);

public data ATM = tm(str name, list[ATrans] transitions);

public data ATrans = trans(str source, str source, str replace, str dir, str target);

public data ASim = sim(str tm, str input, int steps);
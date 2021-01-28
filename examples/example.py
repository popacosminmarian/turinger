def first_tm(inputtape, steps):
    length = len(inputtape) + 2
    tape = ['_']*length
    i = 1
    tapehead = 1
    for s in inputtape:
        tape[i] = s
        i += 1
    state = "l0"
    step = 1
    while (step <= steps and state != "accept" and state != "reject"):
        print("Step " + str(step - 1) + ":"
)        print("State " + state
)        for x in range(len(tape)):
            if x == tapehead:
                print(">",
)            print(tape[x],
)        print("\n"
)        step += 1

        if tapehead == 0:
            tape.insert(0, "_")
            tapehead += 1
        if tapehead == len(tape) - 1:
            tape.append("_")
            tapehead -= 1

        if state == "l1":
            if tape[tapehead] == "_":
                tape[tapehead] = "1"
                state = "accept"
                tapehead -= 1
                continue
        if state == "l2":
            if tape[tapehead] == "_":
                tape[tapehead] = "0"
                state = "reject"
                tapehead += 1
                continue
        if state == "l0":
            if tape[tapehead] == "_":
                tape[tapehead] = "1"
                state = "l1"
                tapehead += 1
                continue
        if state == "l1":
            state = "l2"
            continue
        if state == "l0":
            state = "l2"
            continue
        if state == "l2":
            state = "l2"
            continue
    print("Step " + str(step - 1) + ":"
)    print("State " + state
)    for x in range(len(tape)):
        if x == tapehead:
            print(">",
)        print(tape[x],
)    print("\n\n"
)def second_tm(inputtape, steps):
    length = len(inputtape) + 2
    tape = ['_']*length
    i = 1
    tapehead = 1
    for s in inputtape:
        tape[i] = s
        i += 1
    state = "a0"
    step = 1
    while (step <= steps and state != "accept" and state != "reject"):
        print("Step " + str(step - 1) + ":"
)        print("State " + state
)        for x in range(len(tape)):
            if x == tapehead:
                print(">",
)            print(tape[x],
)        print("\n"
)        step += 1

        if tapehead == 0:
            tape.insert(0, "_")
            tapehead += 1
        if tapehead == len(tape) - 1:
            tape.append("_")
            tapehead -= 1

        if state == "a0":
            if tape[tapehead] == "1":
                tape[tapehead] = "_"
                state = "accept"
                tapehead -= 1
                continue
        if state == "a0":
            state = "reject"
            continue
    print("Step " + str(step - 1) + ":"
)    print("State " + state
)    for x in range(len(tape)):
        if x == tapehead:
            print(">",
)        print(tape[x],
)    print("\n\n"
)def third_tm(inputtape, steps):
    length = len(inputtape) + 2
    tape = ['_']*length
    i = 1
    tapehead = 1
    for s in inputtape:
        tape[i] = s
        i += 1
    state = "l0"
    step = 1
    while (step <= steps and state != "accept" and state != "reject"):
        print("Step " + str(step - 1) + ":"
)        print("State " + state
)        for x in range(len(tape)):
            if x == tapehead:
                print(">",
)            print(tape[x],
)        print("\n"
)        step += 1

        if tapehead == 0:
            tape.insert(0, "_")
            tapehead += 1
        if tapehead == len(tape) - 1:
            tape.append("_")
            tapehead -= 1

        if state == "l3":
            if tape[tapehead] == "_":
                tape[tapehead] = "1"
                state = "l2"
                tapehead += 1
                continue
        if state == "l2":
            if tape[tapehead] == "1":
                tape[tapehead] = "_"
                state = "l3"
                tapehead -= 1
                continue
        if state == "l2":
            if tape[tapehead] == "0":
                tape[tapehead] = "W"
                state = "accept"
                continue
        if state == "l0":
            state = "l2"
            continue
        if state == "l2":
            state = "l3"
            continue
        if state == "l3":
            state = "l2"
            continue
    print("Step " + str(step - 1) + ":"
)    print("State " + state
)    for x in range(len(tape)):
        if x == tapehead:
            print(">",
)        print(tape[x],
)    print("\n\n"
)print('\033[1m' + '\033[92m' + "Turing Machine third_tm with initial tape 1001 for 100 steps" + '\033[0m' + "\n"
)third_tm("1001", 100
)print('\033[1m' + '\033[92m' + "Turing Machine third_tm with initial tape 101 for 3 steps" + '\033[0m' + "\n"
)third_tm("101", 3
)
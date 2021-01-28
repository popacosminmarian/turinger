def anbncn(inputtape, steps):
    length = len(inputtape) + 2
    tape = ['_']*length
    i = 1
    tapehead = 1
    for s in inputtape:
        tape[i] = s
        i += 1
    state = "s0"
    step = 1
    while (step <= steps and state != "accept" and state != "reject"):
        print("Step " + str(step - 1) + ":")
        print("State " + state)
        for x in range(len(tape)):
            if x == tapehead:
                #print(">")
                break
        print(tape)
        print("\n")
        step += 1

        if tapehead == 0:
            tape.insert(0, "_")
            tapehead += 1
        if tapehead == len(tape) - 1:
            tape.append("_")
            tapehead -= 1

        if state == "s1":
            if tape[tapehead] == "_":
                state = "reject"
                continue
        if state == "s2":
            if tape[tapehead] == "a":
                state = "reject"
                continue
        if state == "s2":
            if tape[tapehead] == "_":
                state = "reject"
                continue
        if state == "s1":
            if tape[tapehead] == "c":
                state = "reject"
                continue
        if state == "s0":
            if tape[tapehead] == "b":
                state = "reject"
                continue
        if state == "s0":
            if tape[tapehead] == "c":
                state = "reject"
                continue
        if state == "s2":
            if tape[tapehead] == "b":
                tape[tapehead] = "b"
                state = "s2"
                tapehead += 1
                continue
        if state == "s2":
            if tape[tapehead] == "x":
                tape[tapehead] = "x"
                state = "s2"
                tapehead += 1
                continue
        if state == "s2":
            if tape[tapehead] == "c":
                tape[tapehead] = "x"
                state = "s3"
                tapehead -= 1
                continue
        if state == "s1":
            if tape[tapehead] == "a":
                tape[tapehead] = "a"
                state = "s1"
                tapehead += 1
                continue
        if state == "s1":
            if tape[tapehead] == "x":
                tape[tapehead] = "x"
                state = "s1"
                tapehead += 1
                continue
        if state == "s1":
            if tape[tapehead] == "b":
                tape[tapehead] = "x"
                state = "s2"
                tapehead += 1
                continue
        if state == "s0":
            if tape[tapehead] == "x":
                tape[tapehead] = "x"
                state = "s4"
                tapehead += 1
                continue
        if state == "s0":
            if tape[tapehead] == "a":
                tape[tapehead] = "_"
                state = "s1"
                tapehead += 1
                continue
        if state == "s4":
            if tape[tapehead] == "x":
                tape[tapehead] = "x"
                state = "s4"
                tapehead += 1
                continue
        if state == "s3":
            if tape[tapehead] == "_":
                tape[tapehead] = "_"
                state = "s0"
                tapehead += 1
                continue
        if state == "s3":
            if tape[tapehead] == "c":
                tape[tapehead] = "c"
                state = "s3"
                tapehead -= 1
                continue
        if state == "s3":
            if tape[tapehead] == "b":
                tape[tapehead] = "b"
                state = "s3"
                tapehead -= 1
                continue
        if state == "s3":
            if tape[tapehead] == "a":
                tape[tapehead] = "a"
                state = "s3"
                tapehead -= 1
                continue
        if state == "s3":
            if tape[tapehead] == "x":
                tape[tapehead] = "x"
                state = "s3"
                tapehead -= 1
                continue
        if state == "s4":
            if tape[tapehead] == "c":
                state = "reject"
                continue
        if state == "s4":
            if tape[tapehead] == "a":
                state = "reject"
                continue
        if state == "s4":
            if tape[tapehead] == "b":
                state = "reject"
                continue
        if state == "s4":
            if tape[tapehead] == "_":
                state = "accept"
                continue
        if state == "s0":
            if tape[tapehead] == "_":
                state = "accept"
                continue
        if state == "s0":
            state = "reject"
            continue
        if state == "s2":
            state = "reject"
            continue
        if state == "s1":
            state = "reject"
            continue
        if state == "s4":
            state = "reject"
            continue
        if state == "s3":
            state = "reject"
            continue
    print("Step " + str(step - 1) + ":")
    print("State " + state)
    for x in range(len(tape)):
        if x == tapehead:
            #print(">")
            break
    print(tape)
    print("\n\n")
print('\033[1m' + '\033[92m' + "Turing Machine anbncn with initial tape aaabbbccc for 100 steps" + '\033[0m' + "\n")
anbncn("aaabbbccc", 100)
# print('\033[1m' + '\033[92m' + "Turing Machine anbncn with initial tape abbbcccc for 100 steps" + '\033[0m' + "\n")
# anbncn("abbbcccc", 100)
# print('\033[1m' + '\033[92m' + "Turing Machine anbncn with initial tape invalid for 100 steps" + '\033[0m' + "\n")
# anbncn("invalid", 100)

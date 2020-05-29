
# Diccionarios


def checkKey(key, dictc):       
    if key in dictc: 
        return 1
    else:
        return 0


registros = {
    "$zero": [0, 0],
    "$one": [1, 0],
    "$t0": [8, 1],
    "$t1": [9, 1],
    "$t2": [10, 1],
    "$t3": [11, 1],
    "$t4": [12, 1],
    "$t5": [13, 1],
    "$t6": [14, 1],
    "$t7": [15, 1],
    "$a0": [4, 1],
    "$a1": [5, 1],
    "$a2": [6, 1],
    "$a3": [7, 1],
    "$t8": [24, 1],
    "$t9": [25, 1],
    "$gp": [28, 0],
    "$sp": [29, 0],
    "$s8": [30, 0],
    "$k0": [26, 0],
    "$v0": [2, 0],
    "$v1": [3, 0],
    "$s0": [16, 1],
    "$s1": [17, 1],
    "$s2": [18, 1],
    "$s3": [19, 1],
    "$s4": [20, 1],
    "$s5": [21, 1],
    "$s6": [22, 1],
    "$s7": [23, 1],
}

funcs = {
    "andi": ["rt", "rs", "c"],  # real -> rs rt c
    "ori": ["rt", "rs", "c"],  # real -> rs rt c
    "sub": ["rs", "rt", "rd"],  # real -> rs rt rd
    "mult": ["rs", "rt", "rd"],  # real -> rs rt rd
    "div": ["rs", "rt", "rd"],  # real -> rs rt rd
    "xor": ["rs", "rt", "rd"],  # real -> rs rt rd
    "nor": ["rs", "rt", "rd"],  # real -> rs rt rd

    "li": ["pseudo"],  # pseudo
    "clear": ["pseudo"],  # pseudo
    "blt": ["pseudo"],  # especial
    "b": ["pseudo"],  # especial
    "bgt": ["pseudo"],  # especial
    "beg": ["pseudo"],  # especial
    "bel": ["pseudo"],  # especial

    "nop": ["pseudo"],  # especial    
    "sw": ["rt", "bo"],  # especial
    "lw": ["rt", "bo"],  # especial
    "addi": ["rt", "rs", "c"],  # real -> rs rt c
    "slti": ["rt", "rs", "c"],  # real -> rs rt c
    "j": ["o"],  # especial
    "or": ["rd", "rs", "rt"],  # real -> rs rt rd
    "slt": ["rd", "rs", "rt"],  # real -> rs rt rd
    "beq": ["rs", "rt", "of"],  # real -> rs rt
    "add": ["rs", "rt", "rd"]  # real -> rs rt rd
}

funcs_noSpecial_noR = {
    "addi": ["001000", 5, 5, 16],
    "andi": ["001100", 5, 5, 16],
    "slti": ["001010", 5, 5, 16],
    "ori": ["001101", 5, 5, 16],
    "beq": ["000100", 5, 5, 16],
    "lw": ["110001", 5, 5, 16],
    "sw": ["101011", 5, 5, 16],
    "j": ["000010", 26],
}

# Listas

funcs_rtype = [
    "and", "or", "add", "sub", "nop", "mult", "div", "slt", "nor", "xor"
] 

funcs_rtype_func = ["100100", "100101", "100000", "100010", "000000", "011000", "011010", "101100", "100111", "100110"
]

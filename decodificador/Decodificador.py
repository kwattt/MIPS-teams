import re
import Diccionarios as dic

# Variables globales


maxlines = 256  # Tamaño del archivo
ftotal = 1  # Conteo para el archivo
tfile = None  # Archivo de salida

cfile = None  # Archivo seleccionado
rlines = []  # Líneas reales del código

scriptlines_1 = []  # Instrucciones convertidas a listas de python con parámetros.
scriptlines_2 = []  # Lista con posiciones correctas de salto/branch.
scriptlines_3 = []  # Lista con parámetros corregidos.

jpositions = []  # Posiciones para saltos/brancheos

# Funciones para manejo de binarios


def fullbin(number, clen):
    return ("0" * (clen - len(str(number)))) + str(number)


def dec_to_bin(number):
    return int(bin(number)[2:])


def dbin(number, clen):
    if(number == -1):
        return "x" * clen
    return fullbin(dec_to_bin(number), clen)

# Selección de archivo


def selectfile():
    global cfile
    fName = str(input("Nombre del archivo: "))
    print("")

    try:
        cfile = open(fName, 'r')
    except FileNotFoundError:
        print("> [ERROR] No se encontró el archivo indicado, ¿está en la misma carpeta?")
        exit()


def torealcode():
    global rlines

    lines = cfile.readlines()
    cline = 1

    for line in lines:
        strippedline = line.strip()
        if strippedline:
            rlines.append([strippedline, cline])
        cline += 1


selectfile()  # Cargar archivo
torealcode()  # Eliminar espacios de las lineas

# Instrucciones


def addinstruction(params, nops=1):
    scriptlines_1.append(params)
    for __ in range(nops):
        scriptlines_1.append(["nop"])


def toinstruction():

    for linex in rlines:

        line = linex[0].lower()  # convertir a minúscula para evitar problemas

        rexpr = r"[;#]"

        rpam = re.split(rexpr, line)  # Separamos lineas de comentarios
        rpam = rpam[0].split(" ")  # Separamos parámetros, eliminamos comentarios

        try:
            lastchar = rpam[0][-1]  # Último char de la linea.
        except IndexError:  # Si sólo es un comentario saltar linea.
            continue

        while("" in rpam):  # Remover los espacios de la linea
            rpam.remove("")

        if(lastchar == ":"):  # Si es una sección del código es una función.
            scriptlines_1.append(rpam)

        else:

            # Checamos si la instrucción existe

            if not dic.checkKey(rpam[0], dic.funcs):
                print("> [ERROR] Nemonico no existente en la linea %i (%s ?)" % (linex[1], rpam[0]))
                # Añadir error de que no existe nemonico
                exit()

            # Checamos que no acceda a un registro inexistente.

            if len(rpam) > 1:  # Si tiene uno o más parámetros.
                if rpam[1][0] != ".":  # Si no es una sección.

                    if rpam[1] not in dic.registros:  # Si es un registro existente.
                        print("> [ERROR] Escribiste un registro inexistente en la linea %i (esperados: %s)" % (linex[1], dic.funcs[rpam[0]]))
                        exit()

            # Checar que tenga los parámetros solicitados.

            funcscriptlines_3 = dic.funcs[rpam[0]]
            paramNumber = len(rpam) - 1
            paramReal = len(funcscriptlines_3)

            if paramNumber != paramReal:  # Que cumpla con los parámetros solicitados
                if funcscriptlines_3[0] != "pseudo":
                    print("> [ERROR] No cumple con los parámetros esperados en la linea %i (esperados: %s)" % (linex[1], dic.funcs[rpam[0]]))
                    exit()

            if funcscriptlines_3[0] == "pseudo":

                # DEFINICIÓN DE PSEUDOINSTRUCCIONES

                if rpam[0] == "li":
                    addinstruction(["or", "$0", "$0", rpam[1]])
                    addinstruction(["addi", "$0", rpam[1], rpam[2]])

                elif rpam[0] == "blt":
                    addinstruction(["slt", rpam[1], rpam[2], "$a0"])
                    addinstruction(["beq", "$one", "$a0", rpam[3]])

                else:
                    print("> [ERROR] Nemonico no existente en la linea %i (esperados: %s)" % (linex[1], [rpam[0]]))
                    exit()

            else:

                # DEFINICIÓN DE INSTRUCCIONES

                if rpam[0] == "sw":
                    reg = re.match(r"\W*\$\d+\(\$\w+\)\s*", rpam[2])
                    if reg:
                        separado = rpam[2].split("$")
                        arg2 = separado[1].split("(")[0]
                        arg1 = separado[2].split(")")[0]
                        addinstruction(["sw", "$" + arg1, rpam[1], "$" + arg2])

                    else:

                        print("> [ERROR] No cumple con los parámetros esperados en la linea %i (esperados: %s)" % (linex[1], dic.funcs[rpam[0]]))
                        exit()

                elif rpam[0] == "lw":
                    reg = re.match(r"\W*\$\d+\(\$\w+\)\s*", rpam[2])
                    if reg:
                        separado = rpam[2].split("$")
                        arg2 = separado[1].split("(")[0]
                        arg1 = separado[2].split(")")[0]
                        addinstruction(["lw", "$" + arg1, rpam[1], "$" + arg2])

                    else:
                        print("> [ERROR] No cumple con los parámetros esperados en la linea %i (esperados: %s)" % (linex[1], dic.funcs[rpam[0]]))
                        exit()

                elif rpam[0] == "addi":
                    addinstruction(["addi", rpam[2], rpam[1], rpam[3]])
                elif rpam[0] == "ori":
                    addinstruction(["ori", rpam[2], rpam[1], rpam[3]])
                elif rpam[0] == "andi":
                    addinstruction(["andi", rpam[2], rpam[1], rpam[3]])
                elif rpam[0] == "j":
                    addinstruction(["j", rpam[1]])
                elif rpam[0] == "or":
                    addinstruction(["or", rpam[2], rpam[3], rpam[1]])
                elif rpam[0] == "beq":
                    addinstruction(["beq", rpam[1], rpam[2], rpam[3]])
                elif rpam[0] == "add":
                    addinstruction(["add", rpam[2], rpam[3], rpam[1]])
                elif rpam[0] == "slt":
                    addinstruction(["slt", rpam[2], rpam[3], rpam[1]])
                elif rpam[0] == "sub":
                    addinstruction(["sub", rpam[2], rpam[3], rpam[1]])
                elif rpam[0] == "div":
                    addinstruction(["div", rpam[2], rpam[3], rpam[1]])
                elif rpam[0] == "mult":
                    addinstruction(["mult", rpam[2], rpam[3], rpam[1]])
                elif rpam[0] == "xor":
                    addinstruction(["xor", rpam[2], rpam[3], rpam[1]])
                elif rpam[0] == "nor":
                    addinstruction(["nor", rpam[2], rpam[3], rpam[1]])


def calculatepositions():
    global scriptlines_2

    PC = -1

    for line in scriptlines_1:
        PC += 1
        fpam = line[0]

        if(fpam[-1] == ":"):
            scriptlines_2.append(["nop"])
            jpositions.append([PC, fpam])

        else:
            if fpam == "beq":
                scriptlines_2.append(line)
                scriptlines_2.append(["nop"])
                jpositions.append([PC, fpam, line[3], 0])
            else:
                scriptlines_2.append(line)


def removechars():
    global scriptlines_3

    for line in scriptlines_2:
        templist = [line[0]]

        for pam in line[1::]:
            regr = re.search(r"\$\d+", pam)

            if regr:  # Es una constante
                templist.append(int(pam[1::]))

            else:
                if dic.checkKey(pam, dic.registros):
                    templist.append(dic.registros[pam][0])

                else:
                    if pam[0] == ".":  # Ajustar posiciones de salto/brancheo
                        for zon in jpositions:
                            if pam == zon[1][:-1]:
                                if line[0] == "beq":
                                    for zonx in jpositions:
                                        if zonx[1] == "beq":
                                            if len(zonx) > 3:
                                                if zonx[3] == 0:
                                                    zonx[3] = 1
                                                    jpositions[jpositions.index(zonx)] = zonx
                                                    templist.append(zon[0] - zonx[0])
                                                    break
                                else:
                                    templist.append(zon[0])
                                    break
                    else:
                        print("> [ERROR] Ingresaste un parámetro inexistente en la linea ?? (esperados: %s)" % (dic.funcs[line[0]]))
                        exit()

        scriptlines_3.append(templist)


# Funciones para el manejo de archivo

def tofile(arg):
    global ftotal

    lx = len(arg)
    bruh = int(lx / 8)

    for i in range(0, bruh):
        tfile.write(arg[i * 8:(i * 8) + 8] + "\n")
        print(arg[i * 8:(i * 8) + 8])
        ftotal += 1


def closefile():
    global ftotal

    if ftotal < maxlines:
        while ftotal < maxlines - 1:
            tfile.write("0\n")
            ftotal += 1
    tfile.write("0\n0")

    tfile.close()


def converttobinary():
    global tfile, scriptlines_3

    tfile = open("instr.mem", 'w')

    for line in scriptlines_3:
        binval = ''
        opcode = line[0].lower()
        if opcode in dic.funcs_rtype:
            if opcode == "nop":
                binval += dbin(0, 32)
            else:
                binval += dbin(0, 6)
                binval += dbin(line[1], 5)
                binval += dbin(line[2], 5)
                binval += dbin(line[3], 5)
                binval += dbin(0, 5)
                binval += dic.funcs_rtype_func[dic.funcs_rtype.index(line[0].lower())]
        else:
            if dic.checkKey(opcode, dic.funcs_noSpecial_noR):
                funcinfo = dic.funcs_noSpecial_noR["%s" % opcode]
                if(len(funcinfo) == 4):
                    binval += funcinfo[0]
                    binval += dbin(line[1], funcinfo[1])
                    binval += dbin(line[2], funcinfo[2])
                    binval += dbin(line[3], funcinfo[3])
                elif(len(funcinfo) == 2):
                    binval += funcinfo[0]
                    binval += dbin(line[1], funcinfo[1])

            else:  # Error raro?
                pass

        print(binval)

        tofile(binval)

    closefile()


toinstruction()
calculatepositions()
removechars()
converttobinary()
print("\n>> [CORRECTO] Se terminó la decodificación de manera exitosa.")

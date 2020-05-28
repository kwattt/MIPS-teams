import re
import Diccionarios as dic

# Variables globales


maxlines = 1024  # Tamaño del archivo
ftotal = 1  # Conteo para el archivo
tfile = None  # Archivo de salida

cfile = None  # Archivo seleccionado
rlines = []  # Líneas reales del código

scriptlines_1 = []  # Instrucciones convertidas a listas de python con parámetros.
scriptlines_2 = []  # Lista con posiciones correctas de salto/branch.
scriptlines_3 = []  # Lista con parámetros corregidos.
jpositions = []  # Posiciones para saltos/brancheos
lpositions = []

# Funciones para manejo de binarios


def dbin(number, clen, c2=0):
    if number < 0:
        return bin(number % (1 << clen))[2::]
    else: 
        return "0" * (clen - len(bin(number % (1 << clen))[2::])) + bin(number % (1 << clen))[2::]

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
    cline = 0

    for line in lines:
        strippedline = list(line.strip())

        if strippedline:
            while("," in strippedline):  # Remover las comas de la linea
                strippedline.remove(",")
            strippedline = "".join(strippedline)
            rlines.append([strippedline, cline])

        cline += 1

# Instrucciones


def addinstruction(linex, params, nops=2):
    scriptlines_1.append([linex, params])
    for __ in range(nops):
        scriptlines_1.append([linex, ["nop"]])


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
            scriptlines_1.append([linex[1], rpam])

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
                if rpam[0] == "nop":
                    addinstruction(linex[1], ["nop"], 0)

                elif rpam[0] == "bge":
                    addinstruction(linex[1], ["slt", rpam[1], rpam[2], "$a0"])
                    addinstruction(linex[1], ["beq", "$zero", "$a0", rpam[3]])
                    addinstruction(linex[1], ["beq", rpam[1], rpam[2], rpam[3]])

                elif rpam[0] == "ble":
                    addinstruction(linex[1], ["slt", rpam[2], rpam[1], "$a0"])
                    addinstruction(linex[1], ["beq", "$zero", "$a0", rpam[3]])
                    addinstruction(linex[1], ["beq", rpam[1], rpam[2], rpam[3]])

                elif rpam[0] == "blt":
                    addinstruction(linex[1], ["slt", rpam[2], rpam[1], "$a0"])
                    addinstruction(linex[1], ["beq", "$zero", "$a0", rpam[3]])

                elif rpam[0] == "bgt":
                    addinstruction(linex[1], ["slt", rpam[1], rpam[2], "$a0"])
                    addinstruction(linex[1], ["beq", "$zero", "$a0", rpam[3]])

                elif rpam[0] == "b":
                    addinstruction(linex[1], ["beq", "$zero", "$zero", rpam[3]])

                elif rpam[0] == "clear":
                    addinstruction(linex[1], ["or", "0", "0", rpam[1]])

                elif rpam[0] == "li":
                    addinstruction(linex[1], ["addi", "$zero", rpam[1], rpam[2]],2)

                else:
                    print("> [ERROR] Nemonico no existente en la linea %i (esperados: %s)" % (linex[1], [rpam[0]]))
                    exit()

            else:

                # DEFINICIÓN DE INSTRUCCIONES

                if rpam[0] == "sw":
                    reg = re.match(r"(\d+?)\(\$(\w+?)\)", rpam[2])
                    if reg:

                        arg2 = str(reg.group(1))
                        arg1 = str(reg.group(2))
                        addinstruction(linex[1], ["sw", "$" + arg1, rpam[1], arg2], 2)
                    else:

                        print("> [ERROR] No cumple con los parámetros esperados en la linea %i (esperados: %s)" % (linex[1], dic.funcs[rpam[0]]))
                        exit()

                elif rpam[0] == "lw":
                    reg = re.match(r"(\d+?)\(\$(\w+?)\)", rpam[2])
                    if reg:

                        arg2 = str(reg.group(1))
                        arg1 = str(reg.group(2))
                        addinstruction(linex[1], ["lw", "$" + arg1, rpam[1], arg2], 2)

                    else:
                        print("> [ERROR] No cumple con los parámetros esperados en la linea %i (esperados: %s)" % (linex[1], dic.funcs[rpam[0]]))
                        exit()

                elif rpam[0] == "addi":
                    addinstruction(linex[1], ["addi", rpam[2], rpam[1], rpam[3]],2)
                elif rpam[0] == "ori":
                    addinstruction(linex[1], ["ori", rpam[2], rpam[1], rpam[3]],2)
                elif rpam[0] == "andi":
                    addinstruction(linex[1], ["andi", rpam[2], rpam[1], rpam[3]],2)
                elif rpam[0] == "j":
                    addinstruction(linex[1], ["j", rpam[1]], 2)
                elif rpam[0] == "or":
                    addinstruction(linex[1], ["or", rpam[2], rpam[3], rpam[1]])
                elif rpam[0] == "beq":
                    addinstruction(linex[1], ["beq", rpam[1], rpam[2], rpam[3]],4)
                elif rpam[0] == "add":
                    addinstruction(linex[1], ["add", rpam[2], rpam[3], rpam[1]])
                elif rpam[0] == "slt":
                    addinstruction(linex[1], ["slt", rpam[2], rpam[3], rpam[1]])
                elif rpam[0] == "sub":
                    addinstruction(linex[1], ["sub", rpam[2], rpam[3], rpam[1]])
                elif rpam[0] == "div":
                    addinstruction(linex[1], ["div", rpam[2], rpam[3], rpam[1]])
                elif rpam[0] == "mult":
                    addinstruction(linex[1], ["mult", rpam[2], rpam[3], rpam[1]])
                elif rpam[0] == "xor":
                    addinstruction(linex[1], ["xor", rpam[2], rpam[3], rpam[1]])
                elif rpam[0] == "nor":
                    addinstruction(linex[1], ["nor", rpam[2], rpam[3], rpam[1]])


def calculatepositions():
    global scriptlines_2

    PC = -1

    for line in scriptlines_1:
        PC += 1

        fpam = line[1][0]

        if(fpam[-1] == ":"):
            scriptlines_2.append([line[0], ["nop"]])
            lpositions.append([PC, fpam[:-1]]) # .end

        else:
            if fpam == "beq":
                scriptlines_2.append(line)
                jpositions.append([PC, fpam, 0])
            else:
                scriptlines_2.append(line)

def removechars():
    global scriptlines_3

    for line in scriptlines_2:
        templist = [line[1][0]]
        for pam in line[1][1::]:

            regr = re.search(r"(^-?\d+(.\d+)?$ ?)", pam)

            if regr:  # Es una constante
                templist.append(int(regr.group(1)))

            else:
                if dic.checkKey(pam, dic.registros):
                    templist.append(dic.registros[pam][0])
                else:

                    if pam[0] == ".":  # Ajustar posiciones de salto/brancheo

                        if line[1][0] == "j":
                            for lepos in lpositions:
                                if lepos[1] == pam:
                                    templist.append(lepos[0])
                                    break

                        elif line[1][0] == "beq":
                            for zonx in jpositions:
                                if zonx[2] == 0:
                                    zonx[2] = 1
                                    jpositions[jpositions.index(zonx)] = zonx
                                    for lepos in lpositions:
                                        if lepos[1] == pam:
                                            templist.append(lepos[0] - zonx[0])
                                            break
                                    break
                        else:
                            print("> [ERROR] Ingresaste un parámetro inexistente en la linea %i (>%s) (esperados: %s)" % (line[0], pam, dic.funcs[line[1][0]]))
                            exit()
    
        scriptlines_3.append([line[0], templist])
# Funciones para el manejo de archivo


def tofile(arg):
    global ftotal

    lx = len(arg)
    bruh = int(lx / 8)

    for i in range(0, bruh):
        tfile.write(arg[i * 8:(i * 8) + 8] + "\n")
        #print(arg[i * 8:(i * 8) + 8])
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
        linea = line[0]
        line = line[1]
        print("%d "%linea, line)
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
                    try:
                        binval += dbin(line[3], funcinfo[3])
                    except IndexError:
                        print("> [ERROR] Estás accediendo a una label incorrecta con un salto/branch en la linea %i" % (linea))
                        exit()
                elif(len(funcinfo) == 2):
                    binval += funcinfo[0]
                    binval += dbin(line[1], funcinfo[1])
                else:  # Error raro?
                    print("Error no clasificado")
                    exit()
            else:  # Error raro?
                print("Error no clasificado")
                exit()
        #print(binval)
        tofile(binval)

    closefile()


selectfile()  # Cargar archivo
torealcode()  # Eliminar espacios de las lineas
toinstruction()  # Convertir a instrucciones
calculatepositions()  # Calcular posiciones de labels
removechars()  # Convertir la sintaxis de ensamblador a decimal y mover posiciones
converttobinary()  # Convertir a binario
print("\n>> [CORRECTO] Se terminó la decodificación de manera exitosa.")

import re
import Diccionarios as dic

# Variables globales

cfile = None  # Archivo seleccionado
rlines = []  # Líneas reales del código

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

    try:
        cfile = open(fName, 'r')
    except FileNotFoundError:
        print("No se encontró el archivo indicado, ¿está en la misma carpeta?")
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

        if(lastchar != ":"):  # Si no es una sección del código es una función.

            # Checamos si la instrucción existe

            if not dic.checkKey(rpam[0], dic.funcs):
                print("[ERROR] Nemonico no existente en la linea %i (%s ?)" % (linex[1], rpam[0]))
                # Añadir error de que no existe nemonico
                exit()

            # Checamos que no se escriba en un registro inaccesible.

            if len(rpam) > 1:  # Si tiene uno o más parámetros.
                if rpam[1][0] != ".":  # Si no es una sección.

                    if rpam[1] in dic.registros:  # Si es un registro existente.
                        pass


toinstruction()
import re
from Diccionarios import * 

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


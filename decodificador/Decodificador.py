import re 
import os # For testing

from Diccionarios import * 


## Funciones para manejo de binarios

def fullbin(x, c):
    return ("0"*(c-len(str(x))))+str(x)

def dec_to_bin(x):
    return int(bin(x)[2:])

def dbin(x,c):
    if(x == -1): return "x"*c
    return fullbin(dec_to_bin(x), c)


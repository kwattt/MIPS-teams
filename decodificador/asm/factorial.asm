main:
    li $t0 10 # Factorial del 5

    # restar 1 a 5 xq blq = a<b

    li $s0 1 
    sub $t0 $t0 $s0 

    # Continuamos

    li $t1 1 # Numero inicial 
    li $t3 1 # factorial
    li $t2 1 # Loop var

.loop: 
    blt $t0 $t1 .end

    addi $t1 $t1 1 # $t0 = $t1 + 0
    mult $t3 $t1 $t3

    j .loop 
.end:
    sw $t3 0($zero) # guardar factorial en memoria
    lw $t3 0($zero) # leer
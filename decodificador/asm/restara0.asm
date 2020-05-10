main:
    li $t0 10
    li $t1 1

.loop:

    blt $t0 $t1 .end
    
    addi $t0 $t0 -1

    j .loop

.end:
    li $t0 93 
    sw $t0 0($zero)
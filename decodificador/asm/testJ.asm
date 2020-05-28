.inicio:
    addi $t0 $zero 1337 #reg 8 -> 1337
    j .salto2

.salto1:
    addi $t0 $t0 -724 #reg 8 -> 606
    j .final

.salto2:
    addi $t0 $t0 -7 #reg 8 -> 1300
    j .salto1

.final: 
    addi $t0 $t0 -605 # reg 8 -> 1
    sw $t0 0($zero) # mem[0] -> 1 

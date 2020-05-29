.inicio:
nop
addi $t0 $zero 10 # reg 8 -> decimal debe ser 10
addi $t5 $zero 3 # reg 12 -> decimal debe ser 3
slti $t1 $t5 10 # reg 9 -> slti 5 3
andi $t2 $zero 10 # reg 10 -> decimal debe ser 0
ori $t3 $zero 10  # reg 11 -> decimal debe de ser 1
sw $t0 0($zero) # guardar reg 8 (10) en mem[0]
lw $t4 0($zero) # guardar mem[0] (10) en reg 12
beq $zero $zero .inicio # brincar al inicio xq 0 == 0 
nop 
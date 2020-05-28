.main:
    li $t0 5 # lado 1
    li $t1 5 # lado 2
    li $t2 5 # lado 3
    sub $t4 $t0 $t1
    sub $t5 $t0 $t2
    beq $t4 $zero .f1 

    .iso:

    sub $t6 $t1 $t2 

    beq $t4 $zero .isoceles  # a == b
    beq $t5 $zero .isoceles  # a == c
    beq $t6 $zero .isoceles  # b == c
    
    # si no entonces es escaleno
    j .escaleno

    .f1:   
    beq $t5 $zero .equilatero 

    j .iso 

.equilatero:
    li $t3 1 
    j .end 

.isoceles:
    li $t3 2 
    j .end

.escaleno:
    li $t3 3  

.end:
    sw $t3 0($zero) # guardar tipo de triangulo
.main:

    li $t0 10 # lado 1
    li $t1 20 # lado 2
    li $t2 10 # lado 3

    # 0 == 1 && 0 == 2 -> equilatero

    # equilatero <- 
    sub $t4 $t0 $t1
    sub $t5 $t0 $t2 
    # si amas son 0 entonces equilatero
    
    beq $t4 $zero .f1 

    # si no son iguales entonces probemos un isoceles
    # a==b||a==c||b==c  

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
    j .end 


.end:
    sw $t3 0($zero) # guardar tipo de triangulo
    # 1 -> equilatero
    # 2 -> isoceles
    # 3 -> escaleno
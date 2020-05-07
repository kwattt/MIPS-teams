main:
    li $t5 85
    li $t4 33
    li $t3 94
    li $t2 55
    li $t0 105
    li $t6 58
    li $t7 43
    li $t8 39
    li $t1 69

    sw $t5 0($zero) 
    sw $t4 1($zero) 
    sw $t3 2($zero) 
    sw $t2 3($zero) 
    sw $t1 4($zero) 
    sw $t6 5($zero) 
    sw $t7 6($zero) 
    sw $t8 7($zero) 
    sw $t0 8($zero) 
    li $t9 8 # total de nums

.sort:
    add $t0 $zero $zero # i = 0

    .loop1:
        addi $t1 $t9 -1 # n - 1 
        add $t2 $t0 $zero # index = i
        addi $t3 $t0 1 # j = i+1 
        
        .loop2: 
            nop
            lw $t4 0($t3) # arr[j]
            lw $t5 0($t2) # arr[index]

            # if arr[j] < arr[index]
            blt $t4 $t5 .change 
            j .addj
            .change: 
                add $t2 $zero $t3 # index = j

            .addj:
                addi $t3 $t3 1 # j = j +1 
                blt $t3 $t9 .loop2 # mientras j < n 

        .swap:
            lw $t4 0($t2) # arr[index]
            lw $t5 0($t0) # arr[i]

            add $a1 $zero $t4 # temp = arr[index] 

            sw $t5 0($t2) # arr[index] = arr[i]
            sw $a1 0($t0) # arr[i] = temp

        .add_i: 
            addi $t0 $t0 1 # i = i + 1 
            blt $t0 $t1 .loop1 # mientras i < n - 1 

.end:
    lw $t1 0($zero)
    lw $t1 1($zero)
    lw $t1 2($zero)
    lw $t1 3($zero)
    lw $t1 4($zero)
    lw $t1 5($zero)
    lw $t1 6($zero)
    lw $t1 7($zero)
    lw $t1 8($zero)

# based on https://www.geeksforgeeks.org/selection-sort/
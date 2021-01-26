.data
cells: .ascii "         "
str1: .asciiz "Welcome to tic tac toe: "
str2: .asciiz "The board is:\n"
str3: .asciiz "The winner is: "
str4: .asciiz "Choose position: "
str5: .asciiz "Oopsie, invalid input"
p1: .byte 'X'
p2: .byte 'O'
.text


# this code is somehow so bad it not only fails, but causes spim to crash
main:
    li $v0, 4
    la $a0, str1
    syscall

gloop:
    jal print

    li $v0, 4
    la $a0, str3
    syscall

    lb $t1, p1
    jal choose

    jal print

    li $v0, 4
    la $a0, str3
    syscall

    lb $t1, p2
    jal choose


    b gloop

    b exit


# Prints out the board
print:
    li $t1, 9
    la $a0, str2
    li $v0, 4
    syscall
    la $t0, cells
newline:
    li $v0, 11
    li $a0, '\n'
    syscall

    li $t2, 3
    b continue
loop:
    lb $a0, ($t0)
    li $v0, 11
    syscall

    addiu $t0, $t0, 1
    addi $t1, $t1, -1
    addi $t2, $t2, -1

    beq $t2, $0, newline
continue:
    bne $t1, $0, loop

    jr $ra

# Get user move choice

error:
    li $v0, 4
    la $a0, str5
    syscall
choose:
    #inefficient, resetting of constants, fix somewhere.
    li $v0, 4
    la $a0, str4
    syscall
    li $v0, 5
    syscall

    li $t2, 8
    bgt $v0, $t2, error
    blt $v0, $0, error
    
    lb $t3, cells($v0)
    li $t4, ' '
    bne $t3, $t4, error

    sb $t1, cells($v0)
    jr $ra




# Set character in cells.



exit:
    li $v0, 10
    syscall
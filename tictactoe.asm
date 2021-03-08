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
mainloop:
    jal print

    # load first player
    lb $t1, p1
    jal choose

    jal print

    #jal checkwin
    #beq $v0, $0, end

    # load second player
    lb $t1, p2
    jal choose

    #jal checkwin
    #beq $v0, $0, end

    b mainloop

end:
    li $v0, 4
    la $a0, str3
    syscall

    li $v0, 4
    move $a0, $t1
    syscall

    # return to kernel
    jr $ra

#-------------------print----------------------
# Input: None -> Prints the board
# Uses:
# t1
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
#-------------------print----------------------

# Get user move choice
# BUG here, resulting in constant win
checkwin:
    # set offsets of $t1, $t2, $t3
    # current address of $t0
    # is v0 is 0, then someone has won

    #00 04 08
    #12 16 20
    #24 28 32

    #diagonal left->right
    addiu $t1, $0, 0
    addiu $t2 ,$0, 16
    addiu $t3, $0, 32

    jal threequals

    addiu $t1, $0, 8
    addiu $t2 ,$0, 16
    addiu $t3, $0, 24

    jal threequals

    jr $ra
threequals:
    lb $t1, cells($t1)
    lb $t2, cells($t2)
    lb $t3, cells($t3)
    beq $t1, $t2, twoequal
    jr $ra
twoequal:
    beq $t2, $t3, allequal
    li $v0, 1
    jr $ra
allequal:
    li $v0, 0
    jr $ra

# Get user's next move
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
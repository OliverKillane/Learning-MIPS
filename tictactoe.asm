.data
cells: .ascii "123456789"
str1: .asciiz "Welcome to tic tac toe"
str2: .asciiz "The board is:\n"
str3: .asciiz "The winner is"
.text


# this code is somehow so bad it not only fails, but causes spim to crash
main:
    li $v0, 4
    la $a0, str1
    syscall
    jal print

    li $v0, 4
    la $a0, str3
    syscall

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



# Set character in cells.



exit:
    li $v0, 10
    syscall
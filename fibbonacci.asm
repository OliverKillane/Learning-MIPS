# my attempt at fibbonacci in MIPS

# $16 <- last last number
# $17 <- last number
# $18 <- current number
# $19 <- number of iterations to go.

.data
str1:    .asciiz "\nWhich fibonnaci number:  "
str2:    .asciiz "\nAnswer is:  "

.text
main:
    li $v0, 4
    la $a0, str1
    syscall

    li $v0, 5
    syscall
    move $19, $v0

    addi $16, $0, 1
    addi $17, $0, 1
    addi $18, $0, 1

    ble	$19, 2, ret
    addi $19, $19, -2
    jal fib

fib:
    addi $19, $19, -1
    move $16, $17
    move $17, $18
    add $18, $16, $17
    beq	$19, 0, ret
    jal fib

ret:
    li $v0, 4
    la $a0, str2
    syscall

    li $v0, 1
    move $a0, $18
    syscall

    jal main



    
    
    
    
    

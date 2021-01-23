# my attempt at fibbonacci in MIPS

# $t1 <- last last number
# $t2 <- last number
# $t3 <- current number
# $t4 <- number of iterations to go.

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
    move $t4, $v0

    addi $t1, $0, 1
    addi $t2, $0, 1
    addi $t3, $0, 1

    ble	$t4, 2, ret
    addi $t4, $t4, -2
    jal fib

fib:
    addi $t4, $t4, -1
    move $t1, $t2
    move $t2, $t3
    add $t3, $t1, $t2
    beq	$t4, 0, ret
    jal fib

ret:
    li $v0, 4
    la $a0, str2
    syscall

    li $v0, 1
    move $a0, $t3
    syscall

    jal main



    
    
    
    
    

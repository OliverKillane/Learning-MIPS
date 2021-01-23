    .data
str1: .asciiz "\nEnter n:  "
str2: .asciiz "\nn! = "
    .text
main:
    li $v0, 4   # print string
    la $a0, str1
    syscall
    li $v0, 5   # read int
    syscall
    move 	$t0, $v0		# $t0 = v01
    addi	$t1, $0, 1		# $t1 = 1
    jal fact
    
fact:
    beq		$t0, $0, end
    mult	$t1, $t0		
    mflo	$t1				
    addi	$t0, $t0, -1	
    jal fact
    
printresult:
    li $v0, 4
    la $a0, str2    
    syscall
    li $v0, 1       
    move $a0, $t1   
    syscall        
    jal main
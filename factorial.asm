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
    move 	$19, $v0		# $19 = v01
    addi	$20, $0, 1		# $20 = 1
    jal fact
    
fact:
    beq		$19, $0, end	# if $19 == 0 then target
    mult	$20, $19		# $20 * $19 = Hi and Lo registers
    mflo	$20				# copy Lo to $20
    addi	$19, $19, -1	# $19 = $19 - 1
    jal fact
    
printresult:
    li $v0, 4
    la $a0, str2    # print string
    syscall
    li $v0, 1       # print int
    move $a0, $20   
    syscall        
    jal main
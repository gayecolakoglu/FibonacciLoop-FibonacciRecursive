.data
msg1: .asciiz "Enter the sequence number : "
str1: .asciiz "F("
str2: .asciiz  ") = "

.text

#print msg
li $v0,4
la $a0,msg1
syscall 

# Getting user input
li $v0,5
syscall 

add $a0,$v0,$zero   # Moving the integer input to a0 register
add $a2, $a0, $zero #save input value to a2

jal F #call F
add $a1, $v0, $zero #save return value to a1

# Printing str1
li $v0,4
la $a0, str1
syscall

# Printing input
li $v0,1
add $a0, $a2, $zero
syscall

# Printing str2
li $v0,4
la $a0, str2
syscall

# Printing result
li $v0,1
add $a0, $a1, $zero
syscall


# End Program
li $v0 10
syscall

F:
# a0=n
# if (n==0) return 0;
# if (n==1) return 1;
# return( F(n-1) + F(n-2) );

addi $sp $sp -12 # Make room for 3 elements in stack
sw $ra 0($sp)
sw $s0 4($sp)
sw $s1 8($sp)

add $s0 $a0 $zero

addi $t1 $zero 1  # return value for terminal condition
beq $s0 $zero return0 # Go to return0 if n = 0
beq $s0 $t1 return1   # Go to return1 if n = 1

addi $a0 $s0 -1  # set args for recursive call to f(n-1)
jal F
add $s1 $zero $v0     #s1 = F(n-1)

addi $a0 $s0 -2     # set args for recursive call to f(n-2)
jal F               # v0 = F(n-2)
add $v0 $v0 $s1     # v0=F(n-2)+$s1

exitF:
lw $ra 0($sp)       #read registers from stack
lw $s0 4($sp)
lw $s1 8($sp)
addi $sp,$sp,12       #bring back stack pointer
jr $ra

return0 :     
li $v0,0  # return 0
j exitF
 
return1:
li $v0,1	  # return 1
j exitF

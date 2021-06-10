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
li $v0,10
syscall

F:
#a0=n
# if (n==0) return 0;
# if (n==1) return 1;
  
#    int x($t1),y($t2),z($t3),i($t4);
#    for (x=0,y=0,z=1,i=1;i<a;i++) {
#        x=y+z;
#        y=z;
#        z=x;   }   

#    return(x);
    
addi $t0,$zero,1 # t0 =1

beq $a0,$zero,return0 # if f==0 return 0
beq $a0,$t0,return1   # if f==1 return1

add $t1,$zero,$zero   # t1 = 0
add $t2,$zero,$zero   # t2 = 0
addi $t3,$zero,1      # t3 = 1
addi $t4,$zero,1      # t4 = 1

loop:
#bge $t4,$a0,endloop
slt $t5, $t4, $a0  # t4 > a0 , t5 =0
beq $t5, $zero, endloop  # $t5 == 0 if t4 >= a0
add $t1,$t2,$t3    #  x = y+z
add $t2,$zero,$t3  #  y=z
add $t3,$zero,$t1  #  z=x
addi $t4,$t4,1     #  i++
j loop

endloop:
add $v0,$zero,$t1
jr $ra

return0:
add $v0,$zero,$zero
jr $ra

return1:
addi $v0,$zero,1
jr $ra

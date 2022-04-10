.data
userInput: .space 1200 #allocating 1200 bytes for the string b/c 1 character = 1 byte plus 2 extra bytes
newline: .asciiz "\n"
errorMessage: .asciiz "Not recgonized"

#getting user's input as text
addi $v0, $0, 8 # system call code for reading a string in MIPS is 8
la $a0, userInput # a0 register set to the location in memory to which the computer will record the input
li $a1, 1000 # i want to read 1000 characters 
syscall 

# finding X, M and N
li, $t1,2992633 # loading my id to the register t1
li, $t2, 11 # loading the number 11 to the register t2
div $t1,$t2 # dividing my id number by the number 11
mfhi $t3 # storing the modulo portion to the register t3
li $t4, 26 # loading the number 26 to register t4
add $t5,$t4,$t3 # adding the modulo of my id and 26 and storing it in the t5 register
li $t6, 10 # loading the number 10 to the t6 register
sub $t1,$t5,$t6 # loading the value of N-10 to register t7

# remove leading and trailing blackspace characters and tab characters (BS = 8, HT = 9, VT = 11, S-32) similar to Trim(char[])

begin:
# lb $t2, $t0($a0)
# changing the syntax of this line 
add $t2, $t0, $a0
lb $t2, ($t2)
# iterate the counter
addi $t0,$t0,1 

beq $t2,32,remove # removing space (SP)
beq $t2,8,remove # removing blank space (BS)
beq $t2,9,remove # removing horizontal tab (HT)
beq $t2,11,remove # removing vertical tab (VT)


remove:

finished

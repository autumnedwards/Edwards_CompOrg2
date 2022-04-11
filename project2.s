.data
userInput: .space 1000 #allocating 1200 bytes for the string b/c 1 character = 1 byte plus 2 extra bytes
4characterarray: .space 4
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

#storing the boundary values for the range 
addi $t4, $0, 48
addi $t5, $0, 57
addi $t6, $0, 65
addi $t8, $0, 97
#adding the lower bound for uppercase to M to get the range
add $t7, $t6, $t1

#adding the lower bound for uppercase to M to get the range
add $t9, $t8, $t1


# remove leading and trailing blackspace characters and tab characters (BS = 8, HT = 9, VT = 11, S-32) similar to Trim(char[])

begin:
# lb $t2, $t0($a0)
# changing the syntax of this line 
add $t2, $t0, $a0
lb $t2, ($t2)


beq $t2,32,bypass # removing space (SP)
beq $t2,9,bypass # removing horizontal tab (HT)
beq $t2,11,bypass # removing vertical tab (VT)
j characters

remove:
# iterate the counter
addi $t0,$t0,1 
j begin


characters:
#sb $t3, 4characterarray($t1)

ble $t3,$t5,Pnumber #if the value of t2 is less than or equal to 57 go to possible number
blt $t3,$t7,Puppercase #if the value of t2 is less than 87 or equal to go to possible uppercase
blt $t3,$t9,Plowercase #if the value of t2 is less than or equal to 119 go to possible lowercase
bge $t3, $t9, invalid #if the value of t2 is greater than 118 go to return zero

Pnumber:
bge $t3,$t4,integer
blt $t3, $t4, invalid 

Puppercase:
bge $t3,$t6,uppercase
blt $t3, $t6, invalid

Plowercase:
bge $t3,$t8,lowercase 
blt $t3, $t8, invalid



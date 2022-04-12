.data
userInput: .space 1000 #allocating 1200 bytes for the string b/c 1 character = 1 byte plus 2 extra bytes
characterarray: .space 4
newline: .asciiz "\n"
errorMessage: .asciiz "Not recgonized"

.text
main:
#getting user's input as text
addi $v0, $0, 8 # system call code for reading a string in MIPS is 8
la $a0, userInput # a0 register set to the location in memory to which the computer will record the input
li $a1, 1000 # i want to read 1000 characters 
syscall 

move $s7, $a0

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
addi $s4, $0, 48
addi $t5, $0, 57
addi $t6, $0, 65
addi $t8, $0, 97
#adding the lower bound for uppercase to M to get the range
add $t7, $t6, $t1

#adding the lower bound for uppercase to M to get the range
add $t9, $t8, $t1


# remove leading and trailing blackspace characters and tab characters (BS = 8, HT = 9, VT = 11, S-32) similar to Trim(char[])
li $t0,0
li $t2, 0

begin:
beq $t2, 1000, characters
# lb $t2, $t0($a0)
# changing the syntax of this line 
lb $t0, 0($s7)

#check the 1st bit of the string
#li $v0, 1
#move $a0,$t2
#syscall


beq $t0,32,bypass # removing space (SP)
beq $t0,9,bypass # removing horizontal tab (HT)
beq $t0,11,bypass # removing vertical tab (VT)
j characters

bypass:
# iterate the counters
addi $s7,$t0,1 
addi $t2, $t2, 1
j begin

#loading zero into my counter
li $t1, 0

characters:
li $s4, 0
li $s5, 0

checkCharacters:

beq $s4, 4, trailingCharacters

beq $t0,32,trailingCharacters
beq $t0,9,trailingCharacters
beq $t0,11,trailingCharacters
 # 10 is /n character, 0 is null
beq $t0,10,printSum
beq $t0,0,printSum

sb $t0, characterarray($s5)
addi $s4, $s4, 1
addi $t2, $t2, 1
addi $s5, $s5, 1
addi $s7, $t0, 1
lb $t0, 0($s7)
j checkCharacters

Checkvalues:

ble $t0,$t5,Pnumber #if the value of t2 is less than or equal to 57 go to possible number
blt $t0,$t7,Puppercase #if the value of t2 is less than 87 or equal to go to possible uppercase
blt $t0,$t9,Plowercase #if the value of t2 is less than or equal to 119 go to possible lowercase
bge $t0, $t9, invalid #if the value of t2 is greater than 118 go to return zero

Pnumber:
bge $t0,$s4,integer
blt $t0, $s4, invalid 

Puppercase:
bge $t0,$t6,uppercase
blt $t0, $t6, invalid

Plowercase:
bge $t0,$t8,lowercase 
blt $t0, $t8, invalid

integer:
addi $t0, $t0, -48 #subtracts 48 to get integer from 0-9
j sum 

uppercase: 
addi $t0, $t0, -55 #subtracts 55 to get values from 10-32 for uppercase letters
j sum

lowercase:
addi $t0, $t0, -87 #subtracts 87 to get values from 10-32 for lowercase letters 
j sum


sum:
add $t4, $t4, $t3
addi $t0, $t0,1

#increment $t1
addi $t1, $t1, 1

#check to see if the loop should stop
bne $t1,4,characters 

trailingCharacters:
beq $t2, 1000, Checkvalues
# lb $t2, $t0($a0)
add $t2, $t0, $a0
lb $t2, ($t2)

beq $t2,32,bypass2 # removing space (SP)
beq $t2,9,bypass2 # removing horizontal tab (HT)
beq $t2,11,bypass2 # removing vertical tab (VT)

 # 10 is /n character, 0 is null
beq $t2,10,Checkvalues
beq $t2,0,Checkvalues
 
printSum:
li $v0, 1
move $a0,$t4
syscall 
j exit

invalid:
la $a0, errorMessage
li $v0, 4
syscall

exit:
li $v0, 10 #system call for exit
syscall 

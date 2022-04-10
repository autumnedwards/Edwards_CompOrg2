.data
userInput: .space 1200 #allocating 1200 bytes for the string b/c 1 character = 1 byte plus 2 extra bytes
newline: .asciiz "\n"
errorMessage: .asciiz "Not recgonized"

#getting user's input as text
addi $v0, $0, 8 # system call code for reading a string in MIPS is 8
la $a0, userInput # a0 register set to the location in memory to which the computer will record the input
li $a1, 1000 # i want to read 1000 characters 
syscall 

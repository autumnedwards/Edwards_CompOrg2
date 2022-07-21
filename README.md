# Edwards_CompOrg2

Assume your Howard ID as a decimal integer is X. Let N = 26 + (X % 11) where % is the modulo operation, and M = N – 10.
You will write a MIPS program that reads a string of up to 1000 characters from user input.

	• Remove leading and trailing blank spaces and tab characters.
  
  • If the string has zero characters or more than 4 characters or has at least one illegal character 
    (a character outside the set described below), the program prints the message of "Invalid input".
    
  • If the string has only the characters from '0' to '9' and from 'a' to β and from 'A' to Δ,the program 
    prints out the unsigned decimal integer corresponding to the base-N number represented by the string. 
    β stands for the M-th lower case letter and Δ stands for the M-th upper case letter in the English alphabet. In a base-N number, both 'a' and 'A' correspond to the decimal integer of 10, both 'b' and 'B' to 11, and so on, and both β and Δ correspond to N – 1.
  
  • The program must exit after processing one single user input.
  
  • The conversion from the input string to a decimal number must be done in a subprogram, where the memory address 
    of the input string is passed into the subprogram via a register, and the decimal number is returned via a register. 
    The number must be printed outside the subprogram.

.text

main:	addi $s0, $zero, -3	# First number to multiplication, in main use 's' registers. s0=0+NUM1.
	addi $s1, $zero, -4	# Second number to multiplication, in main use 's' registers. s1=0+NUM2.

	add $a0, $s0, $zero     # First Argument for function, for arguments use 'a' registers. a0=s1+0=s1=NUM1.
	add $a1, $s1, $zero     # Second Argument for function, for arguments use 'a' registers. a1=s2+0=s2=NUM2.

	jal check_arguments	# Jump and link to LABEL multiplication_for_two. PC=PC+4.
 

# In functions use 'a' registers for arguments, 't' registers as temporary and 'v' registers for return values to main function.
 

check_arguments: slt $t7, $a1, $zero	                      # If Second number(COUNTER) is negative ?                     
		 beq $t7, $zero, multiplication_for_two_nums 
		 sub $a0, $zero, $a0 		 
		 sub $a1, $zero, $a1
	         
		 


multiplication_for_two_nums:	addi $a1, $a1, -1
				add $t0, $zero, $zero             # Create the SUM and give the value 0. SUM=t0=0+0=0.
				add $t1, $zero, $zero             # Create the COUNTER for for loop and give the value 0. COUNTER=t1=0+0=0.
				jal star_of_for_loop	  	  # Jump and link to LABEL star_of_for_loop. PC=PC+4.

star_of_for_loop:    slt $t6, $a1, $t1
		     bne $t6, $zero, end_of_for_loop      # If COUNTER is greater or equal than the NUM2 JUST go to LABEL end_of_for.
	             add $t0, $t0, $a0                    # Add NUM1 with NUM1. Multiplication is repeated additions. NUM1+NUM1+...+NUM1, NUM2 times. 
	             addi $t1, $t1, 1                     # COUNTER (Step) increase by 1. COUNTER=COUNTER+1=t1+1.
	             jal star_of_for_loop 		  # Jump and link to LABEL star_of_for_loop. PC=PC+4.

end_of_for_loop:	add $v0, $t0, $zero		  # All funtion must returns values to main with v registers. 
			jr $ra                            # Return address for go to main. Jumps to the address contained in the specified register.


# FOOTNOTES:

# IF ONE OF TWO NUMBERS IS NEGATIVE OR ZERO GIVE IT FIRST !!! ex1.
# ex1 5*(-3)=(-3)*5 .

# IF THE TWO NUMBERS IS NEGATIVE MAKE THEM POSSITIVE(sub $a1, $zero, $a1 | sub $a0, $zero, $a0 @ multipli) AND AFTER MULTIPLICATION RETURN THE RESULT TO AGAIN NEGATIVE (sub $t0, $zero, $t0 @ end_loop) !!! ex2.
# ex2 (-5)*(-3)=-(+5*+3) .

.data 
 banner: .asciiz "#######################################\n"
 header: .asciiz "###Calculate Greatest common divisor###\n"
 ask_for_a: .asciiz "\nPlease, give first number:\n"
 ask_for_b: .asciiz "\nPlease, give second number:\n" 
 results: .asciiz "\nThe GCD (Greatest Common Divisor) is :" 
 goodbye: .asciiz "\nGoodbye !!!\n\n" 
 arithmos: .byte 100
 
.text
 
 main:  li $v0, 4          		# Show message.
	la $a0, banner
	syscall
		
	li $v0, 4			# Show message.
	la $a0, header
	syscall
		
	li $v0, 4			# Show message.
	la $a0, banner
	syscall
		
	li $v0, 4			# Show message.
	la $a0, ask_for_a
	syscall
		
	li $v0, 5			# First number.
	la $a0, arithmos
	li $a1, 100
	syscall
	move $t0, $v0 			# t0=>First number.
	
	li $v0, 4 			# Show message.
	la $a0, ask_for_b
	syscall
		
	li $v0, 5 			# Second number.
	la $a0, arithmos
	li $a1, 100
	syscall
	move $t1, $v0 			# t1=>Second number.
		
	add $a0,$zero,$t0 		# a0=>First number.
	add $a1,$zero,$t1		# a1=>Second number.
		
	jal gcd 			# Jump and link to LABEL gcd.
	add $t3, $zero, $v0 		# t3=>v0. 'Save' my return value.
		
	li $v0, 4 			# Show message.
	la $a0, results
	syscall
 
	li $v0, 1			# Show number.
	move $a0, $t3
	syscall
		
	li $v0, 4 			# Show message.
	la $a0, goodbye
	syscall

	li $v0, 10 			# EXIT.
	syscall

		
######################## FUNCTION #############################
############ IN GENERAL CREATE LOOP, NOT FEEDBACK ############

		
gcd:		bne $a1,$zero, not_zero		# If (a1 != 0) then goto LABEL not_zero.
		beq $a1,$zero, is_zero		# If (a1 == 0) then goto LABEL is_zero. Loop until a1==0.


not_zero:	blt $a1,$a0,first_greater 	# If (a1>a0) then goto LABEL first_greater.
		j second_greater		# Else (a1<a0) then goto LABEL second_greater


first_greater:	sub $a0,$a0,$a1 		# a0=a0-a1.
		j gcd				# Jump to LABEL gcd.
 

second_greater:	sub $a1,$a1,$a0			# a1=a1-a0.
		j gcd				# Jump to LABEL gcd.


is_zero:	add $v0, $zero, $a0		# All funtion must have RETURN VALUE a 'v' register.
		jr $ra				# Return to main function.
	
		
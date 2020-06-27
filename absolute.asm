# Alexandros Plessias
# AM: 2025201100068
# cst11068@uop.gr

.data 
 banner: .asciiz "#######################################\n"
 header: .asciiz "###### Calculate Absolute Price #######\n"
 ask_for_num: .asciiz "\nPlease give the number you want to convert:\n"
 results: .asciiz "\nThe Absolute Price is: " 
 goodbye: .asciiz "\nGoodbye !!!\n\n" 
 number: .byte 100
 
.text
 
 main:  li $v0, 4       		# Show message.
	la $a0, banner
	syscall
		
	li $v0, 4			# Show message.
	la $a0, header
	syscall
		
	li $v0, 4			# Show message.
	la $a0, banner
	syscall
		
	li $v0, 4			# Show message.
	la $a0, ask_for_num
	syscall
		
	li $v0, 5			# Take the number.
	la $a0, number
	li $a1, 100
	syscall

	move $t0, $v0 			# t0=>Is the number.	
	add $a0,$zero,$t0 		# a0=>The argument.
		
	jal absolute 			# Jump and link to LABEL absolute.
	add $t1, $zero, $v0 		# t1=>v0. 'Save' my return value.
		
	li $v0, 4 			# Show message.
	la $a0, results
	syscall
 
	li $v0, 1			# Show number.
	move $a0, $t1
	syscall
		
	li $v0, 4 			# Show message.
	la $a0, goodbye
	syscall

	li $v0, 10 			# Exit.
	syscall

		
######################## FUNCTION #############################

# The absolute price of a possitive or zero number is the same number.
# The absolute price of a negative number is the opposite of the number.

		
absolute:	move $v0,$zero
		bge $a0,$zero, is_posstive	# if   (a0 >= 0) then goto LABEL is_posstive.
		j is_negative			# else (a0 < 0) then goto LABEL is_negative.

is_negative:	sub $a0,$zero,$a0 		# a0=0-(-)=+.
		j absolute			# Jump to LABEL absolute.

is_posstive:	add $v0, $zero, $a0		# All funtion must have RETURN VALUE a 'v' register.
		jr $ra				# Return to main function.
	
		
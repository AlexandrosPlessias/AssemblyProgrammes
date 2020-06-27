.data 
 banner: 	 .asciiz "#############################################################\n"
 header: 	 .asciiz "###### Convert Upper case to Lower case (for strings) #######\n"
 ask_for_string: .asciiz "\nPlease give the String you want to convert:\n"
 lower_msg: 	 .asciiz "\nThe Lower case is:\n" 
 goodbye: 	 .asciiz "\nGoodbye !!!\n\n" 
 string: 	 .space 150 		#150 Bytes it's OK, (1 byte == 1 char
 
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
	la $a0, ask_for_string
	syscall
		
	la $a0,string			# Start.
	li $a1,150			# Size of string.
	li $v0,8
	syscall
		
	jal manage_lower_upper 		# Jump and link to LABEL 'manage_lower_upper'.
	
	li $v0, 4			# Show message.
	la $a0, lower_msg
	syscall	

	li $v0, 4			# Show message.
	la $a0, string
	syscall

	li $v0, 4 			# Show message.
	la $a0, goodbye
	syscall

	li $v0, 10 			# Exit.
	syscall

		
######################## FUNCTION #############################
# Input the adress of string. Output the changed string.
# Check all chars of string and search for Uppercase(65-90) and convert them to Lowercase(+32),
# except the first character, if is Lowercase(97-122) and convert them to Uppercase(-32).
		
manage_lower_upper :	li $v0, 0	# Initialize $V0.
			la $t0, string 	# Load the address of strING into $t0.  
			li $t1, 0 	# Adress position (initialize 0).
			li $t2, 65 	# Ascii code 65 is A.
			li $t3, 90	# Ascii code 90 is Z.
			li $t4, 97	# Ascii code 97 is a.
			li $t5,	122	# Ascii code 122 is z.
			li $t6, 32	# The absolute difference between uppercase and lowercase is 32

			lb $t1, 0($t0) 			# Load the first byte from address in $t0
			bge $t1, $t4, max_than_97	# if ($t1 >= 97) [element >= a] goto LABEL max_than_97
			j pre_loop

max_than_97: 		ble $t1, $t5, upper		# AND if ($t1 <= 122)[element <= z] the first num is lower.
			j pre_loop

upper:			sub $t1, $t1,$t6		# Lowercase - 32 = upper.
			sb $t1, 0($t0)  		# Store the changed byte($t1) at ($t0).
			j pre_loop

pre_loop:		add $t0,$t0, 1			# Increase the address by 1.

			
loop: 			lb $t1, 0($t0)  		# Load the byte from address[string($t0)] to $t1.  
			beq $t1, $zero, end  		# if ($t1 == 0) then goto LABEL 'end'.

   			bge $t1, $t2, max_than_65  	# if ($t1 >= 65)[element >= A].

continue:		add $t0, $t0, 1      		# Increase the address by 1. 
  			j loop


max_than_65: 		ble $t1, $t3, lower		# AND if ($t1 <= 65)[element <= Z].
			j continue

lower: 			add $t1, $t1,$t6		# Uppercase + 32 = lower.
			sb $t1, 0($t0)  		# Store the changed byte($t1) at ($t0).
			j continue

end:			jr $ra
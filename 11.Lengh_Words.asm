.data 
 banner: .asciiz "#####################################################################\n"
 header: .asciiz "###### Calculate the Length and Number Of Words in the string #######\n"

 ask_for_string: .asciiz "\nPlease give the String you want to exam:\n"
 string: .space 150 								#150 Bytes it's OK
 length_msg: .asciiz "\nThe Length is: " 
 word_msg: .asciiz "\nThe Word is: " 
 goodbye: .asciiz "\n\nGoodbye !!!\n\n" 

 
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
		
	jal manage_string 		# Jump and link to LABEL 'manage_string' .
	add $t1, $zero, $v0 		#  'Save' my return value(Length), t1=>v0.
	add $t2, $zero, $v1		# 'Save' my return value(Word), t2=>v1.
		
	li $v0, 4 			# Show message.
	la $a0, length_msg
	syscall
 
	li $v0, 1			# Show Length.
	move $a0, $t1
	syscall


	li $v0, 4 			# Show message.
	la $a0, word_msg
	syscall

	li $v0, 1			# Show Word.
	move $a0, $t2
	syscall

		
	li $v0, 4 			# Show message.
	la $a0, goodbye
	syscall

	li $v0, 10 			# Exit.
	syscall

		
######################## FUNCTION #############################
# Input the Global string. Output $v0 & $v1.
# Check all chars of string and search for 'space'(words) and '0'(length).
		
manage_string:	li $v0, 0	# Initialize $V0.
		la $t0, string 	# Load the address of strING into $t0.  
		li $t1, 0    	# The length counter is $t1 (initialize 0). 
		li $t3, 0	# The word counter is  $t3 (initialize 0)
		li $t4,32

loop_length: 	lb $t2, 0($t0)  		# Load the byte from address[string($t0)] to $t2.  
   		beq $t2, $zero, end  		# If ($t2 == 0) then goto LABEL end.  
   		add $t0, 1      		# Increase the address by 1.
		beq $t2, $t4, loop_word		# If ($t2 == 32) [Ascii code 32 is space].
continue:	add $t1, $t1, 1 		# Increase the length counter by 1.  
  		j loop_length

loop_word:	add $t3, $t3, 1			# Increase word counter by 1.
		j continue

end:		addi $t1, $t1, -1		# Decrease the length counter by 1 (Loop run 1 extra time).
		addi $t3, $t3, 1		# Increase word counter by 1 (eg. 2 space have 3 word,so +1).

		add $v0 ,$zero ,$t1		# Register $v0 return the length.
		add $v1 ,$zero ,$t3		# Register $v1 return the words.

		jr $ra
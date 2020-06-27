title search_array_proc (Ergasia_5_a.asm) 
; Check user input if is in limit and search for it in array.

 include Irvine32.inc 
	; Globals.
	max_limit	 equ  10d
	min_limit  equ -10d
	array_size equ  10d
  
 .data 
	tableContent	sdword -5d, 5d, -6d, -7d, 9d, -6d, 10d, -3d, 5d, -6d
	enterMsg		byte "Enter a value (-10 to +10): ",0
	wrongMsg		byte "Input out of limits, please try again.",0
	foundMsg		byte "The value has been found at address (offset): ",0
	notFoundMsg	byte "The value hasn't been found.", 0

	returned_value dword ?
	
.code 

;-------------------------------------------------------------------------------------------------
SearchArray proc 
; Search if a value exist or not in any array.
; Recieves: First param Search Value, Second param for Array Size, 
; third param for Offset of first element of array and fourth param for returned_value.
; Returns:  If value exist EAX = Offset of element else EAX = 0.
;-------------------------------------------------------------------------------------------------
	enter 4,0			; Create stack frame (push ebp ; mov ebp,esp ; sub esp,4) ; 0*4 localVar , 0 nestingLevel
	
	push esi			; Store Key.	
	push ecx			; Size of array
	push edx			; Offset of first element of array

	mov [ebp-4],eax		; Local var EQU search element.
	push eax			; Save search element.

	push ebx			; Current element adress.
	
	mov edx, [ebp+20]	; Offset of first element of array
	mov ecx, [ebp+16]	; Size of array
	mov esi, [ebp+12]	; Key

	dec ecx				; start from size array -1.

	scan:
		;check all elements but not first.
		mov ebx, ecx		; ebx = current_size
		shl ebx, 2d			; ebx = ebx << 2 = ebx *4 = current_size *4 (e.g. 5*4 =20)
		add ebx, edx		; ebx = ebx + edx =  (current_size *4) + (Offset of first element of array)= addr of each element.

		cmp esi, [ebx]		; Compare esi, [ebx] (effect Sign, Zero and Overflow Flags).
			je find			; Jump if not equal(cmp_left_op!=cmp_right_op) goto L5

	loop scan				; Goto label:scan . Dicrease ecx by 1 when == 0 finish.
	
		;check first elements only.
		mov ebx, ecx		; ebx = 0
		add ebx, edx		; ebx = ebx + edx =  0 + (Offset of first element of array)= addr of first element.
	
		cmp esi, [ebx]		; Compare eax, esi (effect Sign, Zero and Overflow Flags).
			je find			; Jump if not equal(cmp_left_op!=cmp_right_op) goto L5

		;dont find case
		mov eax,[ebp+8]		; Overwrite eax.
		mov ecx ,0d			; Overwrite ecx.
		mov [eax], ecx		; [ebp+8] = 0.

	finish:
		pop ebx
		mov eax, [ebp-4]
		pop eax
		pop edx
		pop ecx
		pop esi
		 
		leave			; Free stack frame (mov esp,ebp ; pop ebp)
		ret 16			; Goto main in line after call.

	find:
		mov eax,[ebp+8]	; Overwrite eax.
		mov [eax], ebx	; [ebp+8] = ebx.
		jmp finish		;  Goto label:finish.

SearchArray endp



main proc

	mov eax, green + (black*16)		; From Lec_04 (29).
	call setTextColor				; From Lec_04 (29).

	getInput:	
		mov edx, offset enterMsg	; edx = enterMsg.
		call WriteString			; Show enterMsg (edx = enterMsg).		
		call ReadInt				; eax = input integer from user.

		cmp eax, min_limit			; Compare eax, min_limit (effect Sign, Zero and Overflow Flags).
			jl offLimit				; Jump if less(cmp_left_op<cmp_right_op) goto offLimit.	; inputUser < min_limit.
	
		cmp eax, max_limit			; Compare eax, max_limit (effect Sign, Zero and Overflow Flags).	
			jg offLimit				; Jump if greater(cmp_left_op>cmp_right_op) goto offLimit.	; inputUser > min_limit.
		

		push offset tableContent	; Argument by reference.
		push array_size				; Argument by value.
		push eax					; Argument by value.
		push offset returned_value	; Argument by reference.

		call SearchArray			; Recieves: eax, ecx, edx & Return: eax.

		; Not Found case.
		cmp returned_value, 0		; Compare eax, 0 (effect Sign, Zero and Overflow Flags).
			je notFound				; Jump if equal(cmp_left_op=cmp_right_op) goto notFound
	
		; Found case.
		mov edx, offset foundMsg	; edx = foundMsg.
		call WriteString			; Show enterMsg (edx = foundMsg).
		mov eax, returned_value		
		call WriteHex				; Show eax in hexMode.
		call Crlf					; New line.
		call Crlf					; New line.
		exit
		
	notFound:
		mov edx, offset notFoundMsg	; edx = notFoundMsg.
		call WriteString			; Show enterMsg (edx = notFoundMsg).
		call Crlf					; New line.
		call Crlf					; New line.
		exit

	offLimit:
		mov edx, offset wrongMsg
		call WriteString
		call Crlf
			jmp getInput

main endp 



END main 


;  Who cmp (destination,source) work ?
;  Cases                | Flags 
; ------------------------------------------------
;  destination < source | SignFlag != OverflowFlag 
;  destination > source | SignFlag  = OverflowFlag 
;  destination = source | ZeroFlag  = 0


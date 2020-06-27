TITLE Expression calculator (Ergasia_3.asm) 
; This program declares and reads array elements 
INCLUDE Irvine32.inc 
 

.data 
   calcStr byte "Calculating",0
   arr1Str byte 0Dh, 0Ah, "The value of element a[2,2] is: ", 0 ; next line (kesoras shn arxh kai nea grammh like \n).
   arr2Str byte 0Dh, 0Ah, "The value of element a[3,1] is: ", 0
   sum1Str byte 0Dh, 0Ah, "The sum a[2,2]+z = :", 0
   sum2Str byte 0Dh, 0Ah, "The sum a[2,2]-z = :", 0
   lineStr byte 0Dh, 0Ah, 0
	
   a	sdword 00d,10d,20d,30d
	lineSize= ($-a) ; sizeof first row.
	sdword 01d,11d,21d,31d
	sdword 02d,12d,22d,32d
	sdword 03d,13d,23d,33d

   x byte 2d
   y byte 2d
   z sword -30d
   p_xy dword ?
 

.code 
main PROC 

	mov edx, offset calcStr
	call WriteString

	mov esi, lineSize	; esi = ($-a) = 16.
	shr esi, 2		; esi = esi >> 2 = 16 / 4 = 4. ; elements of first line.
	shl esi, 1		; esi = esi << 1 = 4  * 2 = 8. ; elements of first & second line.
	movzx ecx, y		; ecx = y = 2 ; use movzx because z is unsigned, movzx zerostuffing l->r.
	add esi, ecx		; esi = esi + ecx = 8 + 2 = 10.
	shl esi, 2		; esi = esi << 2 = esi * 4 = 10 * 4 = 40 ; 4 is type of array in bytes.
	add esi, offset a	; esi = esi + offset of a[0] = offset of a[2,2].
	mov p_xy, esi		; p_xy = mem adress of a[2,2].
	mov esi, p_xy		
	mov eax, [esi]				; eax = **a[2,2]=+23.
	mov edx, offset arr1Str		; eax = arr1Str.
	call WriteString			; Show edx.memAdress
	call WriteInt				; Show eax.memAdress
	
	mov esi, eax				; esp = eax =  +23 ;for second sum ; esi overwrite.
	movsx ecx, z				; ecx = z ; Overwite y.

	add eax, ecx				; eax = eax + z = 23 -30
	mov edx, offset sum1Str		; eax = sum1Str. 
	call WriteString			; Show edx.memAdress
	call WriteInt				; Show eax.memAdress

	sub esi, ecx				; esi = esi - z = 23 - (-30)= +53.
	mov eax, esi				; eax = esi = +53. 
	mov edx, offset sum2Str		; eax = sum1Str.
	call WriteString			; Show edx.memAdress
	call WriteInt				; Show eax.memAdress

	mov esi, offset a			; esi = esi + offset of a[0]. ; esi overwrite. 
	mov eax, [esi + 52]			; eax = a[0] + 52 = a[2,2].
	mov edx, offset arr2Str		; eax = arr1Str.
	call WriteString			; Show edx.memAdress
	call WriteInt				; Show eax.memAdress

	mov edx, offset lineStr
	call WriteString
exit 
main ENDP 
END main 
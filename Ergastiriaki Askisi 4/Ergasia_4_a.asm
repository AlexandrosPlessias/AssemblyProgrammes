
TITLE Expression calculator (Ergasia_4_a.asm) 
 ; bla bla bla ... 

 INCLUDE Irvine32.inc 
   table_size EQU 8d		; Size of lessons (8 in decimal). @ COMPILE TIME
   name_size EQU 21d		; Size of name (20 name + 1 '/0'= 21 in decimal). @ COMPILE TIME
   
  
 .data 
  degrees dword table_size dup (0)		; Array with 8 cells init with 0.
  namOfStud byte name_size dup (?)		; String array 21 cell init with no initial data.
  
  strName byte "Enter your name(max 20 characters): ",0			
  strGiveDeg byte "Enter a degree for lesson N.",0				
  strDelimiter byte ": ",0									
  strDegIs byte 0Dh, 0Ah,"Degree for lesson N.",0					
  strAvr byte 0Dh, 0Ah,0Dh, 0Ah,"Average Degree (student: ",0		
  strDelimiter2 byte ")= ",0									
  strPress byte 0Dh, 0Ah,"Please press any key to continue...",0
  

.code 
 main PROC
 
	;Get name.
	mov edx,offset strName		; edx = strName .
	call WriteString			; Show edx.memAdress .
	
	mov edx,offset namOfStud		; edx = offset namOfStud.
	mov ecx, name_size			; ecx = name_size 
	call ReadString			; Read string and store @namOfStud with size=name_size .
  
  
	;Full array.
	mov esi, offset degrees		; esi = degrees[0].
	mov ecx,table_size			; ecx = 8; USE AS LOOP LIMIT...
	mov ebx,0					; ebx = 0; counter.
L1:

	mov edx,offset strGiveDeg	; edx = strGiveDeg ("Enter a degree for lesson N.").
	call WriteString			; Show edx.memAdress .
	
	mov eax,ebx				; eax = ebx = 0 ;
	inc eax					; eax = eax + 1 = 0 + 1 = 1 ;
	call WriteDec				; Show eax.memAdress .
	
	mov edx,offset strDelimiter	; edx = strDelimiter (": ").
	call WriteString			; Show edx.memAdress .
	
	call ReadDec				; Write eax the number we give.
	mov [esi+ebx*4],eax			; Give price to adress[degree+num*4] = eax .
	inc ebx					; ebx = ebx + 1 ;

loop L1						; Goto label:LI . dicrease ecx by 1 when == 0 finish. 

 
	;Add all array and show avg.
	mov ecx,table_size			; ecx = 8 ; USE AS LOOP LIMIT...
	mov ebx,0					; ebx = 0 ; counter.
	mov edi,0					; edi = 0 ; add and avg after.
	
L2:

	mov eax, [degrees+ebx*4]		; eax = degrees[0] ->  after = degrees[1] etc.
	add edi,eax				; edi = edi + eax .
	inc ebx					; ebx = ebx +1 .

loop L2						; Goto label:L2 . dicrease ecx by 1 when == 0 finish. 
	
	; Not use edi.
	shr edi,3					; edi = edi >> 3 = edi / 8 = average. 
	
	
	; Pause and clear
	mov edx,offset strPress		; edx = strPress (Please press any key to continue...").
	call WriteString			; Show edx.memAdress .
	call ReadDec				; Read enter.
	call Clrscr				; Clear screen.

	
	; Print array reversed.
	mov ecx,table_size			; ecx = 8 ; USE AS LOOP LIMIT...
	mov ebx,7					; ebx = 7 ; counter.
	
L3:
	mov edx,offset strDegIs		; edx = strDegIs ("Degree for lesson N.").
	call WriteString			; Show edx.memAdress.
	
	mov eax,ebx				; eax = ebx = 7.
	inc eax					; eax = eax + 1 = ebx + 1 = 7 + 1 = 8.
	call WriteDec				; Show eax .

	mov edx,offset strDelimiter	; edx = strDelimiter (": ").
	call WriteString			; Show edx.memAdress.
	
	mov eax, [degrees+ebx*4]		; eax = degrees[7];
	call WriteDec				; Show eax .
	
	dec ebx					; ebx = ebx - 1;
loop L3					; Goto label:L2 . dicrease ecx by 1 when == 0 finish. 


	; Show average.
	mov edx,offset strAvr		; edx = strAvr ("Average Degree (student: ").
	call Writestring			; Show edx.memAdress.
				
	mov edx,offset namOfStud		; edx = namOfStud (" onoma").
	call WriteString			; Show edx.memAdress.
		
	mov edx,offset strDelimiter2	; edx = strDelimiter2 (")= ").
	call Writestring			; Show edx.memAdress.
		
	mov eax, edi				; eax = edi = average.
	call WriteDec				; Show eax .

	call Crlf					; New line.
	call Crlf					; New line.
  
 exit 
 main ENDP 
 
 END main

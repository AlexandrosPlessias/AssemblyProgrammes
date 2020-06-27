TITLE Add and Subtract (Ergasia_1_a.asm)
; This program adds and subtracts 32-bit integers.
INCLUDE Irvine32.inc
.code
	main PROC
	
		mov eax, 10000h ; Eax now is 10000h .
		add eax, 50000h ; Eax now is 10000h + 50000h = 60000h .
		sub eax, 30000h ; Eax now is 10000h + 50000h - 30000h = 30000h .
		call DumpRegs

		exit
	main ENDP
	END main
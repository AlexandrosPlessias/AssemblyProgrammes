TITLE Add and Subtract (Ergasia_1_a.asm)
; This program adds and subtracts 32-bit integers.

; From Intel 386 until now.
.386  

; Protected mode , Call from MS-Windows Functions.
.model flat, stdcall 

; Memory 'allocation' size = 4096. 
.stack 4096

;Protopype & Input 
ExitProcess PROTO, dwExitCode:DWORD
DumpRegs PROTO

.code
	main PROC
	
		mov eax, 10000h ; Eax now is 10000h .
		add eax, 50000h ; Eax now is 10000h + 50000h = 60000h .
		sub eax, 30000h ; Eax now is 10000h + 50000h - 30000h = 30000h .
		call DumpRegs

		INVOKE ExitProcess,0
	main ENDP
	END main
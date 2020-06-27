TITLE Expression calculator (Ergasia_2_a.asm)
; This program calculates a simple arithmetical expression

INCLUDE Irvine32.inc

;������ �������� ���������� �������� � compile time data
p EQU 8d			; p = 8d ; ���� ��� ��� global ��� C.


.data			;������ ���������� �������� ���������� � run time data
x SDWORD 16d		; ��������� ����� �������� ������� ������������� ��� ���� �� 16  (��� ��������) ��� 32-bit.
y SDWORD 154d		; ��������� ����� �������� ������� ������������� ��� ���� �� 154 (��� ��������) ��� 32-bit.
z SDWORD -17d		; ��������� ����� �������� ������� ������������� ��� ���� �� -17 (��� ��������) ��� 32-bit.
w SDWORD ?		; ��������� ����� �������� ������� ������������� ����� ������ ���� ��� 32-bit.


.code
main PROC			; PROC directive ����������� ��� ������ ���� procedure �� ����� main.
	
	mov eax,x		; eax = x.
	add eax,y		; eax = eax + y = x + y.

	mov ebx,50d	; ebx = 50d.
	add ebx,eax	; ebx = ebx + eax =  50d + (x + y).
	add ebx,z		; ebx = ebx + z   = (50d +  x + y)+ z.
	sub ebx,p		; ebx = ebx - p   = (50d +  x + y + z) -p.

	mov w,eax		; w = eax = x+y
	sub w,ebx		; w = w-ebx = eax-ebx=(x+y)-(50d+x+y+z-p).
	
	mov eax,w		; Overwrite. ; eax =w = (x+y)-(50d+x+y+z-p). ;eax ��� �������.

	call Crlf		; ����� �������.
	call WriteInt	; �������� ��� ������������� ��� �� ���� �  eax ���� �����.
	call Crlf		; ����� �������.
	call Crlf		; ����� �������.

	exit
main ENDP			; ����������� �� ����� ��� procedure �� ����� main.
END main			; END directive ����������� ��� ��������� ������ ��� ������������ ���� ������������ ����� ��� �� ����� ��� procedure �� ��� ����� �� ��������� � �������� ���.
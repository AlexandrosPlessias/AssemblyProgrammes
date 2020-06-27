TITLE Expression calculator (Ergasia_2_a.asm)
; This program calculates a simple arithmetical expression

INCLUDE Irvine32.inc

;δήλωση σταθερών συμβολικών ονομάτων – compile time data
p EQU 8d			; p = 8d ; Κατι σαν την global της C.


.data			;δήλωση συμβολικών ονομάτων μεταβλητών – run time data
x SDWORD 16d		; Μεταβλητή τύπου Ακεραίου αριθμού προσημασμένου και ίσου με 16  (στο δεκαδικό) και 32-bit.
y SDWORD 154d		; Μεταβλητή τύπου Ακεραίου αριθμού προσημασμένου και ίσου με 154 (στο δεκαδικό) και 32-bit.
z SDWORD -17d		; Μεταβλητή τύπου Ακεραίου αριθμού προσημασμένου και ίσου με -17 (στο δεκαδικό) και 32-bit.
w SDWORD ?		; Μεταβλητή τύπου Ακεραίου αριθμού προσημασμένου χωρίς αρχική τιμή και 32-bit.


.code
main PROC			; PROC directive σηματοδοτεί την έναρξη μιας procedure με όνομα main.
	
	mov eax,x		; eax = x.
	add eax,y		; eax = eax + y = x + y.

	mov ebx,50d	; ebx = 50d.
	add ebx,eax	; ebx = ebx + eax =  50d + (x + y).
	add ebx,z		; ebx = ebx + z   = (50d +  x + y)+ z.
	sub ebx,p		; ebx = ebx - p   = (50d +  x + y + z) -p.

	mov w,eax		; w = eax = x+y
	sub w,ebx		; w = w-ebx = eax-ebx=(x+y)-(50d+x+y+z-p).
	
	mov eax,w		; Overwrite. ; eax =w = (x+y)-(50d+x+y+z-p). ;eax για προβολή.

	call Crlf		; αλαγή γραμμης.
	call WriteInt	; εμφάνιση του αποτελέσματος που το έχει ο  eax στην οθόνη.
	call Crlf		; αλαγή γραμμης.
	call Crlf		; αλαγή γραμμης.

	exit
main ENDP			; Σηματοδοτεί το τέλος της procedure με όνομα main.
END main			; END directive σηματοδοτεί την τελευταία γραμμή του προγράμματος προς μεταγλώττιση καθώς και το όνομα της procedure με την οποία θα ξεκινήσει η εκτέλεσή του.
section	.text
global  kodowanie

kodowanie:
	push ebp
	mov	ebp, esp
	push 0
	push 0
	push 0

	
	mov edi, [ebp+8]
	mov ecx, [ebp+12]
	mov eax, [ebp+16]
	mov ebx, [eax+8]
	mov [ebp-4], ebx	;pierwszy obrot

	mov ebx, [eax+12]
	mov [ebp-8], ebx	;drugi obrot

	mov ebx, [eax+16]
	mov [ebp-12], ebx	;trzeci obrot



przechodz:
	mov bl, [edi]
	cmp bl, 0
	jz koniec

	cmp bl, 65
	jl przepusc	

	cmp bl, 91
	jge przepusc1

	sub bl, 65
;zapomietac numer 1-j pozycji

	mov dl, [ebp-4]		; z przesunieciem
	add bl, dl

	cmp bl, 26
	jge modulo1

modulo1_powr:
	mov [ebp-16], bl
	mov eax, [ebp+16]
	mov ebx, [eax]
	mov eax, 0
	mov al, [ebp-16]
	mov bl, [ebx+4*eax]	;numer miejsca rotora nr2
;	mov [ebp-20], bl


	add bl, 26

	mov dl, [ebp-8]		; z przesunieciem
	add bl, dl
	
	cmp bl, 52
	jge modulo2

modulo2_powr:
	mov [ebp-16], bl
	mov eax, [ebp+16]
	mov ebx, [eax]
	mov eax, 0
	mov al, [ebp-16]
	mov bl, [ebx+4*eax]	;numer miejsca rotora nr3
;	mov [ebp-20], bl
	
	add bl, 52	

	mov dl, [ebp-12]		; z przesunieciem
	add bl, dl

	cmp bl, 78
	jge modulo3

modulo3_powr:
	
	mov [ebp-16], bl
	mov eax, [ebp+16]
	mov ebx, [eax]
	mov eax, 0
	mov al, [ebp-16]
	mov bl, [ebx+4*eax]	;numer miejsca rotora obroc
;	mov [ebp-20], bl


	add bl, 78
	mov [ebp-16], bl
	mov eax, [ebp+16]
	mov ebx, [eax]
	mov eax, 0
	mov al, [ebp-16]
	mov bl, [ebx+4*eax]	;numer miejsca rotora nr3 z powrotem
;	mov [ebp-20], bl

	mov dl, [ebp-12]		; z przesunieciem
	sub bl, dl 	


	cmp bl, 0
	jl zmien1

zmien1_powr:

	mov [ebp-16], bl
	mov eax, [ebp+16]
	mov ebx, [eax+4]
	mov eax, 0
	mov al, [ebp-16]
	mov bl, [ebx+4*eax]	;numer miejsca rotora nr2 z powrotem
;	mov [ebp-20], bl


	mov dl, [ebp-8]		; z przesunieciem
	sub bl, dl 	

	cmp bl, 0
	jl zmien2

zmien2_powr:
	
	add bl, 26
	mov [ebp-16], bl
	mov eax, [ebp+16]
	mov ebx, [eax+4]
	mov eax, 0
	mov al, [ebp-16]
	mov bl, [ebx+4*eax]	;numer miejsca rotora nr1 z powrotem
;	mov [ebp-20], bl
	
	mov dl, [ebp-4]		; z przesunieciem
	sub bl, dl 	
	
	cmp bl, 0
	jl zmien3

zmien3_powr:

	add bl, 52
	
	mov [ebp-16], bl
	mov eax, [ebp+16]
	mov ebx, [eax+4]
	mov eax, 0
	mov al, [ebp-16]
	mov bl, [ebx+4*eax]	;liczba	
	add bl, 65

zapisz:
	mov [ebp-20], bl

	mov bl, [ebp-20]
	mov [ecx], bl
	inc ecx
	inc edi
	jmp rotate
	;jmp przechodz


koniec:
	mov bl, 0
	mov bl, 13
	mov [ecx], bl
	inc ecx
	mov bl, 10
	mov [ecx], bl
	inc ecx
	mov bl, 0
	mov [ecx], bl
	

	mov [ebp+12], ecx
	
	mov ebx, [ebp-4]
	mov eax, [ebp+16]
	mov [eax+8],ebx

	mov ebx, [ebp-8]
	mov eax, [ebp+16]
	mov [eax+12],ebx

	mov ebx, [ebp-12]
	mov eax, [ebp+16]
	mov [eax+16],ebx

	;mov ebp, ebx
	
	mov esp, ebp
	pop	ebp
	ret
	
przepusc:

	cmp bl, 32
	jge zapisz
	
	inc edi
	jmp przechodz

przepusc1:

	cmp bl, 96
	jl zapisz
	
	inc edi
	jmp przechodz

rotate:

	mov ebx, 0
	mov bl, [ebp-4]
	cmp bl, 0
	jne countt4

	mov ebx, 0
	mov bl, [ebp-8]
	cmp bl, 0
	jne countt5

	mov ebx, 0
	mov bl, [ebp-12]
	cmp bl, 0
	jne countt6

	jmp countt4

countt4:

	add bl, 1
	cmp bl, 25
	je zamient4_na0
	mov [ebp-4], bl
	jmp przechodz

countt5:

	add bl, 1
	cmp bl, 25
	je zamient5_na0
	mov [ebp-8], bl
	jmp przechodz

countt6:

	add bl, 1
	cmp bl, 25
	je zamient6_na0
	mov [ebp-12], bl
	jmp przechodz

zamient4_na0:
	
	mov bl, 0
	mov [ebp-4], bl
	jmp przechodz

zamient5_na0:
	
	mov bl, 0
	mov [ebp-8], bl
	jmp przechodz

zamient6_na0:
	
	mov bl, 0
	mov [ebp-12], bl
	jmp przechodz

modulo1:

	sub bl, 26
	jmp modulo1_powr

modulo2:

	sub bl, 26
	jmp modulo2_powr

modulo3:

	sub bl, 26
	jmp modulo3_powr

zmien1:

	add bl, 26
	jmp zmien1_powr

zmien2:

	add bl, 26
	jmp zmien2_powr

zmien3:

	add bl, 26
	jmp zmien3_powr

.text
.global main

main:
	LDR 	r1, =a		  	@ r1 = a 
	MOV 	r5, #8		  	@ r5 = 8 (tamnho da sequência)
	MOV	r2, #0			@ r2 = 0
	LDR	r4, [r1]		@ r4 = a[0]
loop:
	CMP 	r2, #10		  	@ compara r3 com 10
	BEQ	fim
	LDR	r3, [r1, r2, LSL #2]	@ r3 recebe a[i]
	CMP	r3, r4
	MOVGT	r4, r3
	ADD	r2, r2, #1
	B	loop
fim:
	SWI 	0x123456
	
.data
a:
    .word 5, 2, 3, 1, 8, 4, 2, 15

.space 100 @abrindo um espaco de 100 bytes para armazenar a array
.align 1 @ align to even bytes REQUIRED!!!

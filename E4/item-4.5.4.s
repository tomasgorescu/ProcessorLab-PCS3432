.text
.global main

main:
	LDR 	r1, =a		  	@ r1 = a 
	MOV 	r2, #5		  	@ s = 5
	MOV 	r3, #0		  	@ i = 0
	MOV	r4, #0			@ constante 0
loop:
	CMP 	r3, r2		  	@ compara r3 com r2
	BEQ 	fim			@ encerra loop se i = s
	STR 	r4, [r1, r3, LSL #2]  	@ a[i] = 0
	ADD 	r3, r3, #1 
	B	loop
fim:
	SWI 	0x123456
	
.data
a:
    .word 1, 2, 3, 4, 5

.space 100 @abrindo um espaco de 100 bytes para armazenar a array
.align 1 @ align to even bytes REQUIRED!!!

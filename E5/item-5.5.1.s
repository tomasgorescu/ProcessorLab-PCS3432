.text
.global main

main:
	LDR 	r1, =a		  	@ r1 = a 
	LDR 	r2, =b		  	@ r2 = b
	MOV 	r3, #0		  	@ i = 0
	MOV 	r4, #5		  	@ r4 = 8 (tamnho da sequência)
loop:
	CMP 	r3, #10		  	@ compara r3 com 10
	BGT 	fim			@ encerra loop se i > 10
	RSB	r5, r3, #7		@ r5 = 7 - i
	LDR 	r5, [r2, r5, LSL #2]    @ r5 = b[7-i]
	STR 	r5, [r1, r3, LSL #2]    @ a[i] = r5 = b[7-i]
	ADD	r3, r3, #1
	B	loop
fim:
	SWI 	0x123456
	
.data
a:
    .word 0, 0, 0, 0, 0, 0, 0, 0
b:
    .word 0, 1, 2, 3, 4, 5, 6, 7

.space 100 @abrindo um espaco de 100 bytes para armazenar a array
.align 1 @ align to even bytes REQUIRED!!!

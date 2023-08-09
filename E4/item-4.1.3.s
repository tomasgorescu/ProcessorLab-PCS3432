.text
.global main

main:
	LDR r1, =a		  @ r1 = a
	LDR r2, =b		  @ r2 = b
	MOV r0, #0		  @ r0 = 0 -- contador
	MOV r5, #8		  @ array size
loop:
	CMP r0, r5		  @ compara contador com tamanho do array
	BEQ 	fim		 	@ se for igual iteração acabou
	RSB 	r4, r0, #7		@ r4 = 7 - i
	LDR 	r6, [r2, r4, LSL #2]  	@ r6 = b[ 7 - i]
	MOVS 	r7, r0, LSL #2	 	@ r7 = r0 * 4 (tamanho da palavra)
	CMP 	r7, #0
	STREQ 	r6, [r1]	   	@ a = b[r4] 
	STRNE 	r6, [r1, r7]
	ADD 	r0, r0, #1         	@ i ++ 
	B	loop
fim:
	SWI 0x123456
	
.data
	a:
	.word 0, 0, 0, 0, 0, 0, 0, 0
	b:
	.word 1, 2, 3, 4, 5, 6, 7, 8


.text
.global main

main:
	LDR r2, =array		  @ r2 = array
	MOV r1, #1		  @ r1 = 1 (valor arbitrário para y)
	MOV r3, #5		  @ posição do array a ser acessada
	LDR r0, [r2, r3, LSL #2]  @ r0 = array[5]
	ADD r0, r0, r1		  @ r0 = r0 + r1 = array[5] + y
fim:
	SWI 0x123456
	
array:
    .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19
    .space 100 @abrindo um espaco de 100 bytes para armazenar a array

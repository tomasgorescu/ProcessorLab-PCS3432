@hello.s
@ inspiração do algoritmo veio de https://www.geeksforgeeks.org/generate-n-bit-gray-codes/
	.text
	.globl main
main:
	LDR 	r1, =0b00011110 	@ r1 recebe código a ser transformado ( 0b10110100)
	MOV	r0, #8			@ r0 recebe o tamanho da palavra de r1
	MOV	r3, r1			@ r3 como uma cópia de r1
	MOV	r2, #0			@ resultado
	mov 	r6, #1			@ constante = 1
loop:
	SUB	r0, r0, #2		@ subtrai a ordem do codigo de gray do tamanho da palavra
	MOV 	r4, r3, LSR r0		@ r4 recebe o par da vez
	ADD	r2, r2, r4		@ incrementa r2 com o par da vez
	SUB	r3, r3, r4, LSL r0	@ remove-se de r3 o bar adicionado a r2
	MOV	r2, r2, LSL #3		@ adiciona um 0 a direita em r2 e abre 2 bits de espaço p/ soma
	CMP	r0, #0			@ Para quando r0 = 0
	BNE	loop
	MOV	r2, r2, LSR #3		@ Remove os bits adicionados a mais
lista_inversa:
	LDR 	r5, =0b10110100 	@ r1 recebe código inverso de r1 transformado ( 0b10110100)
	MOV	r0, #8			@ r0 recebe o tamanho da palavra de r1
	MOV	r3, r5	
loop_inverso:
	ADD	r2, r6, r2, LSL #1	@ adiciona um 1 a direita em r2
	MOV	r2, r2, LSL #2		@ adiciona 2 espaços para soma em r2
	SUB	r0, r0, #2		@ subtrai a ordem do codigo de gray do tamanho da palavra
	MOV 	r4, r3, LSR r0		@ r4 recebe o par da vez
	ADD	r2, r2, r4		@ incrementa r2 com o par da vez
	SUB	r3, r3, r4, LSL r0	@ remove-se de r3 o bar adicionado a r2
	CMP	r0, #0			@ Para quando r0 = 0
	BNE	loop_inverso
fim:
	MOV	r0, #0x0		
	MOV	r7, #0x1     @ exit(0)	
	SWI	0x0	     @ system call


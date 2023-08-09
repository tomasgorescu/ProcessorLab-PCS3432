@hello.s
	.text
	.globl main
@ r1 is the dividend
@ r2 is the divisor
@ r3 is the quotient
@ r5 is the remainder

main:
	LDR 	r1, =100		@ dividendo
	LDR 	r2, =10			@ divisor
	MOV 	r3, #0			@ quociente
	MOV 	r10, #0			@ resto
	MOV	    r8, r2			@ copia de divisor
	MOV 	r7, #0			@ contador
	MOV	    r6, #1			@ constante = 1
alinhamento:
	MOV 	r8, r8, LSL #1		@ divisor shitado para esquerda
	ADD	    r7, r7, #1		@ incrementa contador de shifts
	CMP 	r8, r1			@ ve se o divisor já é maior que o dividendo
	BLT 	alinhamento		@ votla para mais um shift left
	MOV	    r8, r8, LSR #1		@ garantia que ao final do loop da pra dividir um pelo outro
	SUB	    r7, r7, #1		@ decrementa o contador após o shift right
loop:
	CMP	    r1, r8			@ compara divisor e dividendo
	SUBGE	r1, r1, r8		@ subtrai divisor de dividendo
	ADDGE 	r3, r3, r6, LSL r7	@ quociente recebe resto 1 shiftado do numero de alinhamentos
	SUB	    r7, r7, #1
	MOV 	r8, r8, LSR #1		@ divisor shitado para esquerda n vezes
	CMP 	r7, #0
	BPL	    loop			@ continua se positivo ou 0
	MOV	    r7, r1			@ r7 recebe o resto
	MOV	    r10, r3			@ r10 recebe o quociente
fim:
	SWI	0x0	
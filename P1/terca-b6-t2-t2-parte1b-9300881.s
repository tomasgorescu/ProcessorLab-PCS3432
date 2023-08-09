@hello.s
	.text
	.globl main
main:
	LDR 	r0, =1			@ dividendo
	MOV	r4, #5			@ r4 =5
pronto:
	ADD	r0, r0, #1		@ i = i +1
maisum:
	MOV	r1, r0			@ divisor = r0
	MOV	r0, r4			@ dividendo = r4
	MOV 	r2, #0			@ quociente
	MOV 	r3, #0			@ resto
	MOV	r4, r1			@ copia de divisor
	MOV 	r5, #0			@ contador
	MOV	r6, #1			@ constante = 1
alinhamento:
	MOV 	r4, r4, LSL #1		@ divisor shitado para esquerda
	ADD	r5, r5, #1		@ incrementa contador de shifts
	CMP 	r4, r0			@ ve se o divisor já é maior que o dividendo
	BLT 	alinhamento		@ votla para mais um shift left
	MOV	r4, r4, LSR #1		@ garantia que ao final do loop da pra dividir um pelo outro
	SUB	r5, r5, #1		@ decrementa o contador após o shift right
loop:
	CMP	r0, r4			@ compara divisor e dividendo
	SUBGE	r0, r0, r4		@ subtrai divisor de dividendo
	ADDGE 	r2, r2, r6, LSL r5	@ quociente recebe resto 1 shiftado do numero de alinhamentos
	SUB	r5, r5, #1
	MOV 	r4, r4, LSR #1		@ divisor shitado para esquerda n vezes
	CMP	r5, #0
	BPL	loop			@ continua se positivo ou 0
	MOV	r3, r2			@ r3 recebe o quociente
	MOV	r2, r0			@ r2 recebe o resto
fim:
	SWI	0x0	

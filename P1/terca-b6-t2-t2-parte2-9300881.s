@hello.s
	.text
	.globl main
main:
	LDR 	r0, =15			@ dividendo
	LDR	r1, =2			@ primeiro divisor
pronto:
	CMP	r0, r1			@ compara divisor e dividendo
	BEQ	primo			@ 2 é primo (consideramos que nem faz sentido usar r0 =1)
	MOV	r7, r0			@ copia do dividendo
loop_altera_dividendo:
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
	MOV	r0, r7			@ r0 volta a ter valor do divisor
	CMP	r2, #0			@ resto é 0?
	BEQ 	fim
	ADD	r1, r1, #1		@ itera dividendo
	CMP	r1, r0			@ compara dividendo com divisor
	BEQ	primo			@ se for iguais é primo
	B 	loop_altera_dividendo
fim:
	SWI	0x0
primo:
	MOV	r1, #0			@ esse número é primo!
	b fim

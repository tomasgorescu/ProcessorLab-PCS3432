@hello.s
	.text
	.globl main
main:
	MOV	r0, #15	     @ comentarios vem depois de @ ou entre /* ... */		
	MOV	r1, #20
	BL	firstfunc    @ desvia para funcao, coloca o enderenco de retorno em R14 ou LR (link register).		
	MOV	r0, #0x0		
	MOV	r7, #0x1     @ exit(0)	
	SWI	0x0	     @ system call
firstfunc:
	ADDS	r0, r0, r1		
	MOV	pc, lr	     @ retorna da funcao


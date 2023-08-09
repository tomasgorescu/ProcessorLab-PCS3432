@hello.s
	.text
	.globl main
main:
	MOV 	r4, #2			@ atribui 2 a r4, a título de teste
	MOV 	r1, r4, LSL #2 		@ r1 = 2²* r4
	ADD 	r4, r1, r4, LSL #7 	@ r4 = r1 + (r4* 2⁷) = 4 * r4 + (128 * r4) = 132*r4
	MOV	r0, #0x0		
	MOV	r7, #0x1     @ exit(0)	
	SWI	0x0	     @ system call

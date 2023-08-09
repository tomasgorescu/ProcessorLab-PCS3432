@hello.s
	.text
	.globl main
main:
	MOV 	r4, #2			@ atribui 2 a r4, a título de teste
	MOV 	r1, r4, LSL #1	 	@ r1 = 2* r4
	ADD 	r4, r1, r4, LSL #4 	@ r4 = r1 + (r4* 16) = 2*r4 + (16 * r4) = 18*r4
	MOV	r0, #0x0		
	MOV	r7, #0x1     @ exit(0)	
	SWI	0x0	     @ system call

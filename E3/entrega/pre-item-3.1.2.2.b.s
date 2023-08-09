@hello.s
	.text
	.globl main
main:
	MOV 	r4, #2			@ atribui 2 a r4, a título de teste
	MOV 	r1, r4	 		@ r1 = r4
	RSB 	r4, r1, r4, LSL #8 	@ r4 = r1 + (r4* 28) = r4 - (256 * r4) = 255*r4
	MOV	r0, #0x0		
	MOV	r7, #0x1     @ exit(0)	
	SWI	0x0	     @ system call

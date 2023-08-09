@hello.s
	.text
	.globl main
main:
	MOV 	r4, #2			@ atribui 2 a r4, a título de teste
	MOV 	r4, r4, LSL #14 	@ r4 = (r4* 2¹⁴) = (16384 * r4)
	MOV	r0, #0x0		
	MOV	r7, #0x1     @ exit(0)	
	SWI	0x0	     @ system call

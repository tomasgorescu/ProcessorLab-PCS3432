@hello.s
	.text
	.globl main
main:
	ADD	r3, r7, #1023 @ soma entre reg e constante
	MOV	r0, #0x0		
	MOV	r7, #0x1     @ exit(0)	
	SWI	0x0	     @ system call


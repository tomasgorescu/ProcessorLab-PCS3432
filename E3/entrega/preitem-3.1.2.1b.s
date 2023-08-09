@hello.s
	.text
	.globl main
main:
	SUB 	r11, r12, r3, LSL #31 @ instrução fornecida
	MOV	r0, #0x0		
	MOV	r7, #0x1     @ exit(0)	
	SWI	0x0	     @ system call


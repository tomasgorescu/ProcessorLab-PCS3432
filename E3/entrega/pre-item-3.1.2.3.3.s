@hello.s
	.text
	.globl main
main:
	CMP 	r1, r3 		@ compara mais significativos
	CMPEQ	r2, r4		@ compara menos significativos se r1= r3
	MOV	r0, #0x0		
	MOV	r7, #0x1     @ exit(0)	
	SWI	0x0	     @ system call

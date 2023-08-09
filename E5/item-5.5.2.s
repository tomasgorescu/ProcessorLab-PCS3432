.text
.global main

main:
factorial: 
	MOV r6,#0xA 		@ load 10 into r6
	MOV r4,r6 		@ copy n into a temp register
loop:
	SUBS r4, r4, #1 	@ decrement next multiplier
	MULNE r6, r6, r4 	@ perform multiply
	BNE loop 		@ go again if not complete
fim:
	SWI 0x123456

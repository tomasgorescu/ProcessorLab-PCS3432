.text
.global main

main:
	LDMDA r2, {}
        STMDB r15!, {r0-r3, r4, lr}
fim:
	SWI 0x123456

.text
.global main

main:
	STMIA r5!, {r5, r4, r9}
fim:
	SWI 0x123456

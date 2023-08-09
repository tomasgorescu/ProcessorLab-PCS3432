.text
.global main

array:
	.word 0xbabe0000, 0x12340000, 0x00008888, 0xfeeddeaf, 0x1

main:
	LDR r3, =array
	LDR r0, =0x13
	LDR r1, =0xffffffff
	LDR r1, =0xeeeeeeee
	LDMIA r3!,{r0,r1,r2} 
fim:
	SWI 0x123456

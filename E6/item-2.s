.text
.global main

array:
	.word 0xbabe0000, 0x12340000, 0x00008888, 0xfeeddeaf, 0x1

main:
	LDR r6, =array
	LDMIA r6,{r0,r4,r7,lr} 
fim:
	SWI 0x123456

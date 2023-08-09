.text
.global main

main:
	LDR r0, =0x12340000
	LDR r1, =0xbabe2222
	LDR r2, =0
	LDR r3, =0
	LDR r13, =fim_pilha
	STMDB r13!,{r0,r1} 
	LDMIA r13!,{r2,r3}
fim:
	SWI 0x123456
	
.data
array:		
	.word 0x0, 0x0, 0x0
fim_pilha:
	.word 0xfeeddeaf, 0x1

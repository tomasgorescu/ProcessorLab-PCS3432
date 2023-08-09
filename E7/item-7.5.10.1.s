.text
.global main

main:
	LDR	r0, =0x3ff5000 			@IOPMOD
	LDR	r1, =0x1FC00			@ seta 0 em [3:0] e 1 em [16:10]
    LDR r4, =memory    			@ pega endereço de memory
	LDR r6, =tabela_segmentos
	LDR r8, =0xF        		@ constante = 0b1111
	STR	r1, [r0]				@ seta IOPMOD como input para [3:0] e output para [7:4]
	LDR	r2, =0x3ff5008 			@ IOPDATA
	LDR r7, =0xFFFFFF			@contador para delay
loop:
    SUBS    r7, r7, #1      	@ loop bastante longo
    BEQ     fim             	@ acaba no fim do loop
armazena:
	LDR r3, [r2]				@ le switches [3:0]
	AND r3, r3, r8      		@ só bits [3:0]
    LDR r5, [r4, r3, LSL #2]   	@ busca memory[r3]
	LDR r5, [r6, r5, LSL #2]   	@ busca codificação para display 7 segmentos
	STR	r5, [r2]				@ valor dos switches no displa
	B       loop
fim:
	SWI 0x123456
data:
  memory:
	.word 	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
  tabela_segmentos:
  	.word	0b010111110000000000	@0
	.word	0b000001100000000000	@1
	.word	0b001110110000000000	@2
	.word	0b001011110000000000	@3
	.word	0b011001100000000000	@4
	.word	0b011011010000000000	@5
	.word	0b011111010000000000	@6
	.word	0b000001110000000000	@7
	.word	0b011111110000000000	@8
	.word	0b011011110000000000	@9
	.word	0b011101110000000000	@A
	.word	0b011111000000000000	@B
	.word	0b010110010000000000	@C
	.word	0b001111100000000000	@D
	.word	0b011110010000000000	@E
	.word	0b011100010000000000	@F

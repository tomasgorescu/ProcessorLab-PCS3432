.text
.global main

main:
	LDR	r0, =0x3ff5000 		@IOPMOD
	LDR	r1, =0xF0		@ seta 0 em [3:0] e 1 em [7:4]
    LDR r4, =memory     @ pega endereço de memory
	STR	r1, [r0]		@ seta IOPMOD como input para [3:0] e output para [7:4]
	LDR	r2, =0x3ff5008 		@ IOPDATA
	LDR r3, [r2]		@ le switches [3:0]
armazena:
    STR r3, [r4]        @ salva na memoria
	MOV	r3, r3, LSL #4		@ shifta para [7:4]
	STR	r3, [r2]		@ valor dos switches nos leds
fim:
	SWI 0x123456
data:
  memory:
	.space 10

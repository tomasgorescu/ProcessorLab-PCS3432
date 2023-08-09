.text
.global main

main:
	LDR		r0, =0x3ff5000 		@IOPMOD
	LDR		r1, =0xf0			@ seta 1 nos bits [7:4]
	STR		r1, [r0]			@ seta IOPMOD como output
acende_led:
	LDR	    r0, =0x3ff5008 		@ IOPDATA
	LDR     r1, =memory			@ carrega endereço
    LDR     r2, [r1]			@ carega palavra da memória
	MOV 	r2, r2, LSL #4		@ i shiftado para [7:4]
	STR 	r2, [r0]			@ coloca i nos leds
nop:
	NOP
fim:
	SWI 0x123456
.data

memory:
    .word 5

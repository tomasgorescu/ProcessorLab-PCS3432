.text
.global main

main:
	LDR		r0, =0x3ff5000 		@IOPMOD
	LDR		r1, =0xf0		@ seta 1 nos bits [7:4]
	STR		r1, [r0]		@ seta IOPMOD como output
	LDR 	r1, =0			@ i = 0
acende_leds:
delay:
	SUBS 	r3, r3, #1			@subtrai um do contador
	BNE 	delay				@se > zero, loop
	LDR		r0, =0x3ff5008 		@ IOPDATA
	MOV 	r2, r1, LSL #4		@ i shiftado para [7:4]
	STR 	r2, [r0]		@ coloca i nos leds
	ADD 	r1, r1, #1		@ soma um no numero
	CMP 	r1, #16			@ parar no 16	
	LDR 	r3, =0xFFFFF			@contador para delay
	BNE 	acende_leds		@ se 16 para, se não volta pra acender proximo
fim:
	SWI 0x123456

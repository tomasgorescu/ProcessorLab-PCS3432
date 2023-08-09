.text
.global main

main:
	LDR 	r1, =0b0010110110	@ r1 = x 
	LDR 	r2, =0		  	@ r2 = z
	MOV 	r3, #0		  	@ i = 0
	MOV 	r4, #10		  	@ r4 = 10 -> tamanho da sequência
	SUB	r7, r4, #4		@ r7 =tamanho -4 -> iterar até tamanho -4
	RSB	r5, r4, #32		@ r5 = 32 - tamanho da sequeência = 22
loop:
	CMP 	r3, r7		  	@ compara r3 com r4- condição de parada
	BGT 	fim			@ encerra loop se i > 10 
	ADD	r6, r5, r3		@ r6 = tamanho da palavra - tamanho da sequência + i
	MOV	r6, r1, LSL r6		@ r6 = trecho de 4 bits a ser analisado deslocado p/ esquerda
	MOV	r6, r6, LSR #28		@ desloca para direita para isolar segmento de 4 bits
setado:					@ label para ajudar a imprimir os valores
	CMP	r6, #11			@ compara r6 com sequência fornecida
	ADDEQ	r2, r2, #1		@ 1 em r2 se for igual
	MOV	r2, r2, LSL #1		@ também passa r2 para próximo bit
	ADD	r3, r3, #1		@ incrementa contador
	B	loop
fim:
	SWI 	0x123456

.text
.global main

main:
	LDR 	r1, =a		  	@ r1 = a 
	LDR 	r2, =size		@ r2 = endereço do tamnho da sequência
	LDR	r2, [r2]		@ r2 = tamanho da sequência
	MOV	r4, #0			@ contador menor
	SUB	r9, r2, #1		@ r9 = tamanho-2
loop_menor:
	MOV	r7, r4			@ r7 = incremento para endereço de i
	ADD	r8, r7, #1		@ r8 = incremento para endereço de i + 1
	LDR	r5, [r1, r7, LSL #2]	@ pega a[i]
	LDR	r6, [r1, r8, LSL #2]	@ pega a[i + 1]
	CMP	r5, r6	
	BLGT	swap			@ se a[i] > a[i+1], inverte
	STR	r5, [r1, r7, LSL #2]	@ salva - como a troca é condicional, pode salvar sempre 
	STR	r6, [r1, r8, LSL #2]	@ salva - como a troca é condicional, pode salvar sempre 
	ADDS	r4, r4, #1		@ incrementa
	CMP 	r4, r9  		@ compara contador menor com tamanho -2
	BEQ	teste_loop_maior
	B 	loop_menor
teste_loop_maior:
	STMFD 	r13!, {r6}		@ push no r6 (maior elemento da iteração)
	SUBS	r9, r9, #1		@ decrementa o comparador da contagem
	MOV	r4, #0			@ reseta contador para novo
	BEQ	loop_de_pops
	B	loop_menor
loop_de_pops:
	LDMFD 	r13!, {r6}		@ pop da stack
	STR	r6, [r10, r4, LSL #2]	@ armazena em organizado_pela_stack
	ADD	r4, r4, #1		@ incrementa contador
	CMP	r4, r2			@ i = n?
	BNE	loop_de_pops		@ se não for, proxima iteração. Se for, continua para o fim
fim:
	SWI 	0x123456
	
swap:
   EOR r5, r5, r6      @ calcula r5 = r5 eor r6
   EOR r6, r5, r6      @ calcula r5 = r6 eor r6
   EOR r5, r5, r6      @ calcula r5 = r5 eor r6
   MOV pc, lr          @ retorna da função
	
.data
a:
    .word 9, 8, 7, 6, 5, 4, 3, 2, 1, 0
size:
    .word 10
organizado_stack:
    .space 100 @abrindo um espaco de 100 bytes para armazenar a array
.align 1 @ align to even bytes REQUIRED!!!

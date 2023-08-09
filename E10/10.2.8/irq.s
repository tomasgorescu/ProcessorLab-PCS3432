.global _start
.text
_start:
    b _Reset                                @posição 0x00 - Reset
    ldr     pc, _undefined_instruction      @posição 0x04 - Intrução não-definida
    ldr     pc, _software_interrupt         @posição 0x08 - Interrupção de Software
    ldr     pc, _prefetch_abort             @posição 0x0C - Prefetch Abort
    ldr     pc, _data_abort                 @posição 0x10 - Data Abort
    ldr     pc, _not_used                   @posição 0x14 - Não utilizado
    ldr     pc, _irq                        @posição 0x18 - Interrupção (IRQ)
    ldr     pc, _fiq                        @posição 0x1C - Interrupção(FIQ)

_undefined_instruction: .word undefined_instruction
_software_interrupt: .word software_interrupt
_prefetch_abort: .word prefetch_abort
_data_abort: .word data_abort
_not_used: .word not_used
_irq: .word irq
_fiq: .word fiq

INTPND: .word 0x10140000 @Interrupt status register
INTSEL: .word 0x1014000C @interrupt select register( 0 = irq, 1 = fiq)
INTEN: .word 0x10140010 @interrupt enable register
TIMER0L: .word 0x101E2000 @Timer 0 load register
TIMER0V: .word 0x101E2004 @Timer 0 value registers
TIMER0C: .word 0x101E2008 @timer 0 control register

_Reset:

    LDR sp, =supervisor_stack_top

    @ Inicializacao das stacks
    MRS r0, cpsr    @ salvando o modo corrente em R0
    MSR cpsr_ctl, #0b11010010 @ alterando o modo para irq - o SP eh automaticamente chaveado ao chavear o modo
    LDR sp, =irq_stack_top @ a pilha de irq eh setada
    MSR cpsr, r0 @ volta para o modo anterior

    bl main
    b .
undefined_instruction:
    b .
software_interrupt:
    b do_software_interrupt @ vai para o handler de interrupções de software
prefetch_abort:
    b .
data_abort:
    b .
not_used:
    b .
irq:
    b do_irq_interrupt @vai para o handler de interrupções IRQ
fiq:
    b .

do_software_interrupt: @Rotina de Interrupçãode software
    add r1, r2, r3 @r1 = r2 + r3
    mov pc, r14 @volta p/ o endereço armazenado em r14

do_irq_interrupt: @Rotina de interrupções IRQ
    @ corrige link register 
    SUB lr, lr, #4

    @ SALVA OS REGS em linhaA

    STR r0, linhaA  @ se não fizer store assim, perde valor de r0
    LDR r0, =linhaA @ pega endereço de linha[0] em r0
    ADD r0, r0, #4  @ incrementa pq linhaA[0] já tem 0 r0
    STMIA r0!, {r1 - r12, lr} @ salva regs na memória

    @ aqui temos r0-r12, lr (que é o pc)

    @ salva spsr
    MRS r1, spsr
    STMIA r0!, {r1}

    @ aqui temos r0-r12, lr, cpsr

    @ modo supervisor para pegar sp e lr
    MRS r1, cpsr
    MSR cpsr_ctl, #0b11010011 @ supervisor
    STMIA r0!, {sp, lr} @ armazena sp e lr

    @ aqui temos r0-r12, lr, cpsr, sp e lr

    MSR cpsr, r1 @volta para modo anterior

    @ volta pro código fornecido pelo prof

    LDR r0, INTPND @Carrega o registrador de status de interrupção
    LDR r0, [r0]
    TST r0, #0x0010 @verifica se é uma interupção de timer
    BLNE handler_timer @vai para o rotina de tratamento da interupção de timer
    vesaida:

    LDR r0, =linhaA
    ADD r0, r0, #68 @ 17 regs armazenados x 4 (final do linhaA)

    @ Eu acho feio começar por cima, mas se fizer um LDMIA r0!, {r0-r12} a gente perde endereço salvo em r0
    @ Usando o LMDB - load multiple decrement before- evitamos ter que por o r0 na stack ou algo assim


    MRS   r1, cpsr  @ salvo modo atual em r1
    MSR   cpsr_ctl, #0b11010011 @ altera modo para supervisor
    LDMDB r0!, {sp, lr} @ Restaura sp e lr
    MSR   cpsr, r1   @ volta pro modo anterior

    LDMDB r0!, {r1}     @ restaura spsr
    MSR   spsr, r1      @ escreve spsr

    LDMDB r0, {r0 - r12, pc}^ @ Restaura outro regs (pc recebe lr)

timer_init:
    @ Enable timer0 interrupt
    LDR r0, INTEN
    LDR r1,=0x10 @bit 4 for timer 0 interrupt enable
    STR r1,[r0]

    @ Set timer value
    LDR r0, TIMER0L
    LDR r1, =0xfffff @setting timer value
    STR r1,[r0]

    @ Enable timer0 counting
    LDR r0, TIMER0C
    MOV r1, #0xE0 @enable timer module
    STR r1, [r0]

    @ Enable processor interrupt in CPSR
    mrs r0, cpsr
    bic r0,r0,#0x80
    msr cpsr_c,r0 @enabling interrupts in the cpsr

    mov pc, lr

main:
    bl hello_world
    bl timer_init @ initialize interrupts and timer 0
loop:
    bl print_space
    b loop

linhaA:
    .space 68

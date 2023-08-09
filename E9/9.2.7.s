.text
.global main

main:
	NOP
    MRS r0, cpsr            @ salvando o modo corrente em R0
    MSR cpsr_ctl, #0b11011011    @ modo instrução invalida
supervisor:
    NOP
    MSR cpsr, r0

	SWI 0x123456

.section INTERRUPT_VECTOR, "x"
.global _Reset
_Reset:
  B Reset_Handler /* Reset */
  B Undefined_Handler
  B . /* Undefined */
  B . /* SWI */
  B . /* Prefetch Abort */
  B . /* Data Abort */
  B . /* reserved */
  B . /* IRQ */
  B . /* FIQ */
 
Reset_Handler:
  LDR sp, =stack_top
  MRS r0, cpsr    @ salvando o modo corrente em R0
  MSR cpsr_ctl, #0b11011011 @ modo undefined
indefinido:
  NOP 
  MSR cpsr_ctl, #0b11010011 @ modo supervisor
supervisor:
  NOP 
  MSR cpsr_ctl, #0b11010001 @ modo fiq
fiq:
  NOP
  MSR cpsr, r0 @ volta para o modo anterior 
modo_original:
  BL c_entry
  B .

Undefined_Handler:
    LDR sp, =stack_top
    BL undefined

undefined:

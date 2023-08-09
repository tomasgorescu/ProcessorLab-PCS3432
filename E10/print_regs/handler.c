volatile unsigned int * const TIMER0X = (unsigned int *)0x101E200c;
volatile unsigned int * const UART0DR = (unsigned int *)0x101f1000;

extern void int2str(int num, char *pontstr);
 
void print_uart0(const char *s) {
    while(*s != '\0') { /* Loop until end of string */
        *UART0DR = (unsigned int)(*s); /* Transmit char */
        s++; /* Next char */
    }
}

void impnum(int num) {
	char pontstr[50] = "";
	int2str(num, pontstr);
	print_uart0(pontstr);
	return;
}

void handler_timer() {
    *TIMER0X = 0;
    print_uart0("\n");
}

void taskA() {
  while(1) {
    print_uart0("A ");
  }
}

void taskB() {
  while(1) {
    print_uart0("B ");
  }
}

void taskC(int r0, int r1, int r2, int r3, int r4, int r5, int r6, int r7, int r8, int r9, int r10, int r11, int r12) {
  while(1) {
    print_uart0("R0: ");
    impnum(r0);
    print_uart0("\n");
    print_uart0("R1: ");
    impnum(r1);
    print_uart0("\n");
    print_uart0("R2: ");
    impnum(r2);
    print_uart0("\n");
    print_uart0("R3: ");
    impnum(r3);
    print_uart0("\n");
    print_uart0("R4: ");
    impnum(r4);
    print_uart0("\n");
    print_uart0("R5: ");
    impnum(r5);
    print_uart0("\n");
    print_uart0("R6: ");
    impnum(r6);
    print_uart0("\n");
    print_uart0("R7: ");
    impnum(r7);
    print_uart0("\n");
    print_uart0("R8: ");
    impnum(r8);
    print_uart0("\n");
    print_uart0("R9: ");
    impnum(r9);
    print_uart0("\n");
    print_uart0("R10: ");
    impnum(r10);
    print_uart0("\n");
    print_uart0("R11: ");
    impnum(r11);
    print_uart0("\n");
    print_uart0("R12: ");
    impnum(r12);
    print_uart0("\n");
  }
}


// para montar este código basta usar "gcc main.c div.s int2str.s"
// para debugar gdb a.out
#include <stdio.h>
					
extern void int2str(int num, char *pontstr);

void impnum(int num)
{
	char pontstr[50] = "";
	int2str(num, pontstr);
	puts(pontstr);
	return;
}
					
int main()
{
	impnum(9300881);
	return 0;
}

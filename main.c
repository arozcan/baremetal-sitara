#define UART0_BASE 0x44E09000
#define UART0_THR *(volatile unsigned int *)(UART0_BASE + 0x00)
#define UART0_LSR *(volatile unsigned int *)(UART0_BASE + 0x14)
void uart0_puts(char *s);
void uart0_putc(char c);

int main(void) {
    unsigned int delay = 20000000;
    uart0_puts("HELLO");
    while(delay--) {
        uart0_puts("LOLS ");
        delay = 20000000;
    }
}

void uart0_puts(char* s) {
    while(*s != 0x00) {
        uart0_putc(*s++);
    }
}


void uart0_putc(char c) {
    while((UART0_LSR & 0x20) == 0x00) {
        __asm__("nop");
    }
    UART0_THR = c;
}

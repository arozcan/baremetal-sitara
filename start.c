typedef unsigned int uint32_t;
extern uint32_t _etext;
extern uint32_t _sdata;
extern uint32_t _edata;
extern uint32_t _sbss;
extern uint32_t _ebss;
extern uint32_t _estack;

void cstart(void) __attribute__((section(".startup")));
void cstart(void){
    /* Use symbols provided by linker to get data contents from nonvolatile memory (at end of .text) and copy to .data in RAM */
    uint32_t* nvdata = &_etext;
    uint32_t* data =  &_sdata;
    while(data < &_edata){
        *(data++) = *(nvdata++);
    }
    /* Now zero .bss, for all global/static stuff that has no initial value */
    data = &_sbss;
    while(data < &_ebss){
        *(data++) = 0;
    }
}

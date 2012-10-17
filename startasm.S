.section .startup
.globl start
start:
    ldr r13, =_estack
    bl cstart
    bl main
hang:
    b hang

/* Baremetal linker script. Derivative of the one for F4OS */

/* Specify the memory areas */
MEMORY
{
  RAM (xrw)       : ORIGIN = 0x80000000, LENGTH = 256M
}

_estack = 0x82000000;

SECTIONS {

    .start :
    {
        . = ALIGN(4);
        *(.startup*);
        . = ALIGN(4);
    } > RAM

    .text :
    {
        . = ALIGN(4);
        _stext = .;
        *(.text*)
        . = ALIGN(4);
        _etext = .;
    } > RAM
    _sidata = .;
    .data : AT ( _sidata )
    {
        . = ALIGN(4);
        _sdata = .;        /* create a global symbol at data start */
        *(.data*)           /* .data sections */

        . = ALIGN(4);
        _edata = .;        /* define a global symbol at data end */
    } > RAM
    /* Uninitialized data section */
    _sibss = .;
    .bss : AT ( _sibss )
    {
        . = ALIGN(4);
        _sbss = .;         /* define a global symbol at bss start */
        *(.bss*)

        . = ALIGN(4);
    } > RAM
    _ebss = .;         /* define a global symbol at bss end */
}

PROVIDE(end = .);
_end            = .;

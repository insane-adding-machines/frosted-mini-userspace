ENTRY(_init);

MEMORY
{
    FLASH (rx) : ORIGIN = 0x00000000 + 0x10000, LENGTH = 0x30000
    SRAM (rwx) : ORIGIN = (0x20000000 + 0x8000), LENGTH = 0x8000
}

SECTIONS
{
    .text :
    {
        KEEP(*(.init*))
        *(.text*)
        *(.rodata*)
        . = ALIGN(4);
        *(.xipfs*)
    } > FLASH
 
    .data :
    {
        apps_etext = LOADADDR(.data);
        apps_data = .;
        *(vtable)
        *(.data*)
        apps_edata = .;
    } > SRAM AT > FLASH
 
    .bss :
    {
        __bss_start__ = .;
        apps_bss = .;
        *(.bss*)
        *(COMMON)
        . = ALIGN(32 / 8);
        apps_ebss = .;
        __bss_end__ = .;
    } > SRAM

    /* NOTE: .fini, .rodata, .eh_frame, .init_array not a separate section */
}

section .text
    global _start       ;must be declared for using gcc
_start:                     ;tell linker entry point
    mov     ax,-4     ; test value

doFewTests:
    push    eax

    cmp     ax,0
;    test    ax,ax
;    test    ax,0x8000

    jl      handleNegative
    ; handle non-negative
    ; fake conversion to ASCII for numbers 0-9
    add     al,'0'
    mov     ecx,strPositive
    mov     edx,lenPositive
    mov     [ecx+edx-2],al
    jmp     printMessage
handleNegative:
    ; fake conversion to ASCII for numbers -9 to -1
    neg     al
    add     al,'0'
    mov     ecx,strNegative
    mov     edx,lenNegative
    mov     [ecx+edx-2],al
printMessage:
    mov     ebx, 1      ;file descriptor (stdout)
    mov     eax, 4      ;system call number (sys_write)
    int     0x80        ;call kernel
    pop     eax
    inc     ax
    cmp     ax,5
    jl      doFewTests  ; do -4 to +4 demonstration loop
    ; exit
    mov     eax, 1      ;system call number (sys_exit)
    int     0x80        ;call kernel

section .data

strPositive db 'Positive number: x', 10
lenPositive equ $ - strPositive
strNegative db 'Negative number: -x', 10
lenNegative equ $ - strNegative
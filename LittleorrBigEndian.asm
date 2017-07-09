section .text
 
global _start
_start:
 
mov dword[a],0x12345678
mov cl,byte[a]
 
cmp cl,0x78
je little
 
 
cmp cl,0x12
jne ext
 
mov ecx,big
mov edx,lbig
mov eax,4
mov ebx,1
int 0x80
 
jmp ext
 
 
 
little:
 
mov ecx,lit
mov edx,llit
mov eax,4
mov ebx,1
int 0x80
 
ext:
 
 
mov eax,1
mov ebx,0
int 0x80
 
 
 
section .data
a dd 30h
big db "BIG ENDIAN        -      GODLY",10
lbig equ $-big
lit db "LITTLE ENDIAN        -       GODLY",10
llit equ $-lit
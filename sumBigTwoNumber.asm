section	.text
   global _start        ;must be declared for using gcc

_start:	                ;tell linker entry point

   mov     esi, 4       ;pointing to the rightmost digit
   mov     ecx, 5       ;num of digits
   clc
add_loop:  
   mov 	al, [num1 + esi]
   adc 	al, [num2 + esi]
   aaa
   pushf
   or 	al, 30h
   popf
	
   mov	[sum + esi], al
   dec	esi
   loop	add_loop
	
   mov	edx,len	        ;message length
   mov	ecx,msg	        ;message to write
   mov	ebx,1	        ;file descriptor (stdout)
   mov	eax,4	        ;system call number (sys_write)
   int	0x80	        ;call kernel
	
   mov	edx,5	        ;message length
   mov	ecx,sum	        ;message to write
   mov	ebx,1	        ;file descriptor (stdout)
   mov	eax,4	        ;system call number (sys_write)
   int	0x80	        ;call kernel
	
   mov	eax,1	        ;system call number (sys_exit)
   int	0x80	        ;call kernel

section	.data
msg db 'The Sum is:',0xa	
len equ $ - msg			
num1 db '12345'
num2 db '23456'
sum db '
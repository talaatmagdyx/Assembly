section .text
 
input:
mov eax,3
mov ebx,0
int 0x80
ret
 
output:
mov eax,4
mov ebx,1
int 0x80
ret
 
global _start
_start:
 
mov ecx,inpmsg
mov edx,linp
call output
 
mov ecx,inpsen
mov edx,1000
call input
 
 
mov ebp,0
mov esi,0
 
finding_large:
mov ebp,esi
mov cl,byte[inpsen+ebp]
cmp cl,10
je printsen
cmp cl,32
jne wordcheck
add ebp,1
wordcheck:
add esi,1
mov cl,byte[inpsen+esi]
cmp cl,10
je checkexit
cmp cl,32
jne wordcheck
checkexit:
mov ebx,esi
sub ebx,ebp
mov eax,dword[large]
 
cmp ebx,eax
jl finding_large
mov dword[large],ebx
mov dword[ptrstrt],ebp
mov dword[ptrstop],esi
jmp finding_large
 
 
printsen:
 
mov ecx,entered
mov edx,1
call output
 
mov ecx,10
mov edx,1
call output
 
mov ecx,omsg
mov edx,lomsg
call output
 
printdoc:
mov esi,dword[ptrstop]
mov ebp,dword[ptrstrt]
printing:
 
cmp ebp,esi
je exit
mov al,byte[inpsen+ebp]
mov byte[printdata],al
 
mov ecx,printdata
mov edx,1
call output
add ebp,1
jmp printing
 
exit:
 
mov ecx,entered
mov edx,1
call output
 
mov eax,1
mov ebx,0
int 0x80
 
 
section .bss
inpsen resb 1000
 
section .data
entered db 10
ptrstop dd 0
ptrstrt dd 0
inpmsg db "ENTER THE SENTENCE : ",32
linp equ $-inpmsg
large dd 0
omsg db "LARGEST WORD - ",32
lomsg equ $-omsg
printdata db 30h
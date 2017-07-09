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
 
mov ecx,inpwrdmsg
mov edx,linpwrd
call output
 
mov ecx,inpwrd
mov edx,100
call input
 
mov ebp,0
 
mov esi,0
 
 
sencheck:
mov cl,byte[inpwrd+esi]
mov dl,byte[inpsen+ebp]
cmp cl,dl
jne continue
 
mov dword[ptrstrt],ebp
 
comparing:
add esi,1
cmp byte[inpwrd+esi],10
jne cont
mov dword[ptrstop],ebp
call deleteword
mov ecx,dword[ptrstrt]
mov edx,dword[ptrstop]
sub edx,ecx
add edx,1
sub ebp,edx
cont:
add ebp,1
cmp byte[inpsen+ebp],10
je printsen
mov cl,byte[inpwrd+esi]
mov dl,byte[inpsen+ebp]
cmp cl,dl
je comparing
mov esi,0
 
continue:
add ebp,1
cmp byte[inpsen+ebp],10
jne sencheck
 
 
 
printsen:
mov ecx,10
mov edx,1
call output
 
mov ecx,omsg
mov edx,lomsg
call output
 
mov ebp,0
printing:
mov al,byte[inpsen+ebp]
cmp al,10
je exit
mov byte[printdata],al
 
mov ecx,printdata
mov edx,1
call output
add ebp,1
jmp printing
 
exit:
mov ecx,10
mov edx,1
call output
 
mov eax,1
mov ebx,0
int 0x80
 
deleteword:
mov edx,0
mov eax,dword[ptrstrt]
mov ebx,dword[ptrstop]
add ebx,1
deleting:
mov cl,byte[inpsen+ebx+edx]
mov byte[inpsen+eax+edx],cl
add edx,1
mov cl,byte[inpsen+ebx+edx-1]
cmp cl,10
jne deleting
 
ret
 
section .bss
inpsen resb 1000
inpwrd resb 100
 
section .data
ptrstop dd 0
ptrstrt dd 0
inpmsg db "ENTER THE SENTENCE : ",32
linp equ $-inpmsg
inpwrdmsg db "ENTER THE WORD TO BE DELETED : ",32
linpwrd equ $-inpwrdmsg
omsg db "MODIFIED SENTENCE",10
lomsg equ $-omsg
printdata db 30h
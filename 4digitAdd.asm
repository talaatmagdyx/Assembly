section .text
 
convert:
sub bl,30h
mov eax,0
mov ecx,0
mov al,bl
mov byte[count],3
acon:
mov edx,0
mov ecx,10
mul cx
sub bh,30h
shr ebx,8
mov edx,0
mov dl,bl
add ax,dx
sub byte[count],1
cmp byte[count],0
jne acon
ret
 
global _start
_start:
mov ecx,msg
mov edx,lmsg
mov eax,4
mov ebx,1
int 0x80
 
mov ecx,space
mov edx,1
mov eax,4
mov ebx,1
int 80h
 
 
mov ecx,inp1
mov edx,4
mov eax,3
mov ebx,0
int 0x80
 
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h
 
mov ecx,msgplus
mov edx,lpl
mov eax,4
mov ebx,1
int 80h
 
mov ebx,0
mov ebx,[inp1]
call convert
mov word[inp1],ax
 
mov ecx,space
mov edx,1
mov eax,4
mov ebx,1
int 80h
 
mov ecx,inp2
mov edx,4
mov eax,3
mov ebx,0
int 80h
 
mov ecx,msgend
mov edx,lend
mov eax,4
mov ebx,1
int 80h
 
mov ebx,0
mov ebx,[inp2]
call convert
mov word[inp2],ax
 
 
 
 
mov eax,0
mov edx,0
mov ax,[inp1]
mov dx,[inp2]
add ax,dx
 
 
 
 
push 29h
mov byte[count],5
break:
mov ebx,10
mov edx,0
div bx
add dl,30h
push dx
sub byte[count],1
cmp byte[count],0
jne break
 
mov eax,0
pop ax
print:
mov byte[temp],al
 
mov ecx,temp
mov edx,1
mov eax,4
mov ebx,1
int 80h
 
mov eax,0
pop ax
cmp al,29h
jne print
 
mov eax,4
mov ebx,1
mov ecx,newline
mov edx,1
int 80h
 
mov eax,1
mov ebx,0
int 80h
 
section .data
msg: db "ENTER THE NUMBERS(4 DIGIT)",10
lmsg equ $-msg
newline db 0xa
space db " "
msgplus db "      +",10
lpl equ $-msgplus
msgend db "______",10
lend equ $-msgend
inp1 dw 30h
inp2 dw 30h
sum dw 30h
count db 30h
temp db 30h

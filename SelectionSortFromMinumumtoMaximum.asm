
          ; Selection Sort From Minumum to Maximum 


section .text

        
                 ; first lable for println 
println:

mov ecx,newline
mov edx,1
mov eax,4
mov ebx,1
int 0x80
ret
 

                 ; For receive data in decimal  

convert:

mov ecx,[inp]     ; inp=>30h
mov bl,10         ;  bl is known as base register (Used as indexed   ; address)
mov al,cl    
sub al,30h
 


;    ch  Register ************    
cmp bl,10               ;###################
je converted


converted:
mov byte[inp],al
ret             
 


takeinput:     ;message for ask user to enter 


mov ecx,number_count    
mov edx,length
mov eax,4       ;write 
mov ebx,1
int 0x80
 

tinput:
 
mov ecx,inp
mov edx,3     ;length
mov eax,3      ;read
mov ebx,0       ; mov ebx,0    stdin    ;mov ebx,1     stdout 
int 0x80
 

call convert       ;for convert to decimal 
 
ret    ;#################
   
global _start

_start:
       ; Output ask to enter number number of element
mov ecx,number_of_elements
mov edx,length_elements
mov eax,4
mov ebx,1
int 0x80

call tinput
 
mov eax,0           ;stdinp
mov al,byte[inp]         ;8 bit      ; input ==>4
mov byte[n],al
mov esi,0                  ; ESI (32 bit)===>source index (16bit)
 


taking:
push ax                 ;push in ax 
 
call takeinput
 
mov al,byte[inp]
         ;4  ;4
mov byte[input+esi],al
 
add esi,1                     
mov eax,0           ;   4     4 4 3 2 
pop ax
cmp eax,esi
jne taking
 
mov esi,0
mov eax,0
mov edx,0
mov ecx,0


sorting:

mov edx,esi
mov al,byte[input+edx]
mov byte[temp1],al

comparing:
add edx,1
mov bl,byte[n]
cmp dl,bl      ;EDX       DL DH           
je aftercompare
mov cl,byte[input+edx]
cmp al,cl
jle comparing
mov byte[temp2],dl
mov al,cl
jmp comparing

aftercompare:
cmp al,[temp1]
je noswap

;If the two number are not equal 

mov byte[input+esi],al
mov ecx,0
mov edx,0
mov cl,[temp1]          ;cl ==>counter Register 
mov dl,[temp2]           ;DL==>for call Data 
mov byte[input+edx],cl



noswap:          ; if doent make no swap we move to the next index 

add esi,1
mov ebx,0
mov bl,byte[n]
cmp esi,ebx  
jne sorting
 

  ;if we reached to the end of the size of inp 
        ; Now We print Message with sorting of Array 
mov ecx,sortmsg
mov edx,lsortmsg
mov eax,4
mov ebx,1
int 0x80
 
mov ebp,0                  ; ebp =====>  ;stack base pointer register
movzx ebp,byte[n]     ;For Assign 32 bit register to 16 bit register 
                                      
mov esi,0
                  
call println


output:   ; This is for the Type of the Architecture x8086

mov eax,0     ; TO Avoid Making flag in Memory 

; instruction used to take a little longer than the xor eax, eax as ;well... cannot recall exactly why
              
mov al,byte[input+esi]
push 30h
 
break:       ;When arrive to end of the count out from the loop

mov bx,10
mov edx,0         ;32bit 
div bx
add dx,30h
push dx            ;########################################
cmp al,0
jne break
 
mov eax,0
pop ax



print:
mov byte[printdata],al
 
     ;Starting printing sorted number which user enter 
mov ecx,printdata       ;printing the output here 
mov edx,1
mov eax,4 
mov ebx,1         
int 0x80
 
pop ax
cmp al,30h 

jne print
 
mov ecx,newline
mov edx,1
mov eax,4
mov ebx,1
int 0x80


add esi,1
cmp ebp,esi
jne output
 
mov eax,1
mov ebx,0
int 0x80


 
section .bss
input resb 100


section .data

temp1 db 30h
temp2 db 30h
printdata db 30h
inp dd 30h
space db 32

newline db 10      ; 10 is hexadecimal number for printing newline 

n db 30h

number_count db "ENTER ELEMENTS Now",32
length equ $-number_count
number_of_elements db "ENTER NUMBER OF ELEMENTS WHICH YOU WANT TO MAKE SORT FOR IT ",32
length_elements equ $-number_of_elements
sortmsg db "SORTED ARRAY",10,7
lsortmsg equ $-sortmsg
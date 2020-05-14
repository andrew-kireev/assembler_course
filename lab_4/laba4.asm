.model tiny


code segment
assume cs:code, ds:code
org 100h

main:

mov cx, 0
mov cl, [es:80h]
cmp cl, 0
    je enddd
dec cl
mov number, cl      
mov si, 82h
mov num, 0
mov bx, offset argv
read_first:
    mov dl, es:[si]
    cmp dl, ' '
        je break
    mov [bx], dl
    inc num
    inc si
    inc bx
loop read_first

break:

mov dx, offset text
call PUTSTR
mov cl, num
mov si, 0
write_first:              
    mov dl, argv[si]
    call PUTCH
    inc si
loop write_first

cmp num, 6          
jne wrong

mov si, 0
mov di, 0
mov cl, 6
write_to_string:                
    mov al, argv[si]
    mov str_args[di], al
    inc al
    inc di
    inc si
loop write_to_string


push ds
pop es
mov si, offset lastname
mov di, offset str_args
mov cx, 6


check_first:         
    cmpsb
    jne wrong
loop check_first
jmp result

enddd:
mov dx, offset text6
call PUTSTR
jmp endd

wrong:
mov dx, offset text2
call PUTSTR
jmp second

result:
mov dx, offset text1
call PUTSTR

second:
call NL
mov dx, offset text5
call PUTSTR


mov cl, number
mov al, num

cmp cl, num
    je no_second
mov dx, offset text3
call PUTSTR
jmp endd

no_second:
mov dx, offset text4
call PUTSTR

endd:
call NL
GETCH proc
    mov ah, 01h
    int 21h
    ret
GETCH endp

NL proc
    mov dx, offset CLRF         
    mov ah, 09H
    int 021H
    ret
NL endp

END_PROC PROC
    mov al, 0
    mov ah, 4Ch
    int 21h
    RET
END_PROC ENDP

CLEAN proc
    mov ax, 03H
    int 10h
    ret
CLEAN endp

PUTSTR proc
    mov ah, 09H
    int 21h
    ret
PUTSTR endp

PUTCH proc
    mov ah, 02h
    int 21h
    ret
PUTCH endp

ret
; Call END_PROC
; MYCODE ENDS
; END START

argv db 40 dup (' ')
str_args db ' $'


HEX_STRING DB 'FEDCBA9876543210'
CLRF DB 0dh,0ah,'$'
text db 'first parametr: $'
text1 db 13, 10, 'first parametr is right$'
text2 db 13, 10, 'is not right$'
text3 db 'paranetr is here$'
text4 db ' parametr is not here$'
text5 db 'second parametr: $'
text6 db 'there are no paramerts $'
lastname db 'kireev'
num db 0
number db 0
code ends
end main

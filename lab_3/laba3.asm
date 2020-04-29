MYCODE SEGMENT 'CODE'
        ASSUME CS:MYCODE, DS:MYCODE

CLRF DB 0dh,0ah,'$'
HEX_STRING DB 'FEDCBA9876543210'
text2 DB'Press any key to continue $'
text3 DB'Press * to exit $'
buf db 100,100 dup ('$')
NL PROC
    MOV DX, OFFSET CLRF
    MOV AH, 09H
    INT 21H
    RET
NL ENDP 


PUTCH PROC
    MOV AH, 02H
    INT 21H
    RET
PUTCH ENDP

GETCHH PROC
        MOV AH, 01H
        INT 21H
        RET
GETCHH ENDP

HEX PROC
    PUSH AX
    MOV BX, OFFSET HEX_STRING
    MOV AL,  buf[si]
    SHR AL, 4
    MOV DL, 15
    SUB DL, AL
    MOV AL, DL                      ;31h
    XLAT
    MOV DL,AL
    CALL PUTCH
    MOV AL, buf[si]
    AND AL, 0FH
    MOV DL, 15
    SUB DL, AL
    MOV AL, DL
    XLAT
    MOV DL,AL
    CALL PUTCH
    MOV buf[si], '$'
    inc si
    MOV DL, 'h'
    CALL PUTCH
    MOV DL, ' '
    CALL PUTCH
    POP AX
    RET
HEX ENDP


END_PROC PROC
    MOV AL, 0
    MOV AH, 4CH
    INT 21H
    RET
END_PROC ENDP


WAITING PROC
    call NL
    MOV DX, OFFSET text2
    MOV AH, 09H
    INT 21H
    CALL NL
    MOV DX, OFFSET text3
    MOV AH, 09H
    INT 21H
    CALL NL
    CALL GETCHH
    CMP AL, '*'
        JE ennd
    CALL NL
    mov si, 0
    MOV CX, 5
    LOOP for
WAITING ENDP

GETCH PROC
    mov Ah, 08H
    INT 21H
     CMP AL, '$'
        JE start_print
    mov bh, al
    MOV buf[si], bh
    mov dl, bh
    call PUTCH
    mov dl, ' '
    call PUTCH
    inc si
    RET
GETCH ENDP

START:
    PUSH CS
    POP DS
    mov si, 0
    MOV CX, 5
    for:
    call GETCH
        MOV CX, 0
        inc al
    LOOP for
    start_print:
    call NL
    mov si, 0
    MOV CX, 5
    for1:
    CMP buf[si], '$'
        JE end_
        call HEX
        MOV CX, 0
    LOOP for1


    end_:
    CALL NL
    CALL WAITING
    ennd:
    CALL END_PROC     
    MYCODE ENDS
END START

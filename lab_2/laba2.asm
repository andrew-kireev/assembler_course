MYCODE SEGMENT 'CODE'
        ASSUME CS:MYCODE, DS:MYCODE

CLRF DB 0dh,0ah,'$'
text1 DB'Enter symbol: $'
text2 DB'Press any key to continue $'
text3 DB'Press * to exit $'
; HEX_STRING DB '0123456789ABCDEF'
HEX_STRING DB 'FEDCBA9876543210'
NL PROC
        MOV DX, OFFSET CLRF
        MOV AH, 09H
        INT 21H
        RET
NL ENDP 

GETCH PROC
        MOV AH, 08H
        INT 21H
        RET
GETCH ENDP

PUTCH PROC
        MOV AH, 02H
        INT 21H
        RET
PUTCH ENDP

HEX PROC
        MOV BX, OFFSET HEX_STRING
        MOV AL, DH
        SHR AL, 4
        MOV DL, 15
        SUB DL, AL
        MOV AL, DL                      ;31h
        XLAT
        MOV DL,AL
        CALL PUTCH
        MOV AL,DH
        AND AL, 0FH
        MOV DL, 15
        SUB DL, AL
        MOV AL, DL
        XLAT
        MOV DL,AL
        CALL PUTCH
        RET
HEX ENDP

PRINT PROC
        MOV DL, AL
        PUSH AX
        CALL PUTCH
        MOV DH, DL
        CALL PRINT_SEP
        CALL HEX
        MOV DL, 'h'
        CALL PUTCH
        POP AX
        RET
PRINT ENDP


PRINT_SEP PROC
        MOV DL, ' '
        CALL PUTCH
        MOV DL, '-'
        CALL PUTCH
        MOV DL, ' '
        CALL PUTCH
        RET
PRINT_SEP ENDP

END_PROC PROC
        MOV AL, 0
        MOV AH, 4CH
        INT 21H
        RET
END_PROC ENDP

WAITING PROC
        MOV DX, OFFSET text2
        MOV AH, 09H
        INT 21H
        CALL NL
        MOV DX, OFFSET text3
        MOV AH, 09H
        INT 21H
        CALL GETCH
        CMP AL, '*'
        JE end_
        LOOP START
WAITING ENDP



START:
        PUSH CS
        POP DS
        CALL NL
        MOV DX, OFFSET text1
        MOV AH, 09H
        INT 21H
        CALL NL

        CALL GETCH
        CALL NL
        MOV CX, 20
        for:
                CALL PRINT
                CALL NL
                inc AL
        LOOP for
        CALL WAITING
        end_:
        CALL END_PROC     
        MYCODE ENDS
END START
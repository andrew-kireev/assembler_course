MYCODE SEGMENT 'CODE'
        ASSUME CS:MYCODE, DS:MYCODE

CLRF DB 0dh,0ah,'$'
LET DB '�'
LETT DB '�'
LETTT DB '�'
mes0 DB 13,10,'Enter symbol: $'
mes1 DB 13,10,'Press any key to restart... Press * to exit... $'

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

START:
        PUSH CS
        POP DS
        CALL GETCH
	MOV CX, 3
	for:
		MOV DL, AL
		CALL PUTCH
                CMP CX, 1
                JE metka
                  CALL NL
		inc AL
                 metka:
	LOOP for
        MOV AL, 0
        MOV AH, 4CH
        INT 21H
MYCODE ENDS
END START








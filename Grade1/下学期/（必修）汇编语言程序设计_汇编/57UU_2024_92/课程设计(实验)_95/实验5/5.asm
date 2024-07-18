DATAS SEGMENT
    ;�˴��������ݶδ���  
    BUFFER DB 11,0;max_length,actual_length
    ARRAY DB 11 dup(?);RAW array
    NEW_LINE DB 0DH,0AH,'$'
    ARRAY2 DB 11 DUP(?);ARRAY WITHOUT NUMBER
DATAS ENDS

STACKS SEGMENT
    DW  40H  DUP(0) 
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;get line from console
    MOV  AH,0AH 
	MOV  DX,OFFSET BUFFER
	INT   21H 
    
    ;call remove_number function
    MOV SI,OFFSET BUFFER+1;LEN
    PUSH SI
    MOV SI,OFFSET ARRAY
    PUSH SI
    MOV SI,OFFSET ARRAY2
    PUSH SI
    CALL RM_NUM
    
    
    ;call to_upper function
    MOV AH,0
    MOV AL,BUFFER+1;LEN
    MOV SI,AX
    PUSH SI
    MOV SI,OFFSET ARRAY2
    PUSH SI
    CALL TO_UPPER
    
    ;IF THE ARRAY IS EMPTY,SET ITS VALUE TO '?'
    CMP BUFFER+1,0
    JNZ PRINT
    MOV BUFFER+1,1
    MOV ARRAY2,'?'
PRINT:
	;NEW LINE
	MOV DX,OFFSET NEW_LINE
	MOV AH,09H
	INT 21H
	
    ;print the array
    MOV BX,OFFSET ARRAY2
    MOV DX,BX
    ADD BL,BUFFER+1

	MOV BYTE PTR[BX],'$'
    MOV AH,09H
    INT 21H
    
    ;NEW LINE
	MOV DX,OFFSET NEW_LINE
	MOV AH,09H
	INT 21H
    
    ;EXIT
    MOV AH,4CH
    INT 21H

RM_NUM PROC;�������(len addr,RAW array addr,DST ARRAY ADDR)�������޸�len,dst array
	PUSH BP			;����ִ���ֳ�
	MOV BP,SP
	PUSHF
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	PUSH DI
	
	MOV SI,[BP+4]	;DST ARRAY ADDR
	MOV DI,[BP+6]	;SRC array addr
	MOV BX,[BP+8]	;LEN addr
	MOV CH,0		;���CX��8λ
	MOV CL,BYTE PTR[BX]
	JCXZ DONE
L1:
	MOV DH,0;��DH����bool flag,��ʾ������Ƿ�������
	CMP BYTE PTR[DI],'0'
	JB JUDGE;�����'0'С��˵���ⲻ������
	CMP BYTE PTR[DI],'9'
	JA JUDGE;�����'9'��˵���ⲻ������
	;��������е����˵����һ��������	
	MOV DH,1;����flagֵ
	DEC BYTE PTR [BX];DECREASE THE LENGTH
JUDGE:
	CMP DH,1;�Ƚ�flag��ֵ�ǲ���1
	JZ NEXT_;�����1��������������δ���
	MOV DH,BYTE PTR [DI];������ַ���Դ�ƶ���Ŀ��
	MOV [SI],DH
	INC SI;ƫ����ָ��Ŀ���ַ�����һ��Ԫ��
	
NEXT_:
	INC DI;ƫ����ָ��Դ�ַ�����һ��Ԫ��
	LOOP L1
DONE:
	POP DI;�ָ�ִ���ֳ�
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	POPF
	POP BP
	RET 6
RM_NUM ENDP

TO_UPPER PROC;(len,array addr)
	PUSH BP;����ִ���ֳ�
	MOV BP,SP
	PUSHF
	PUSH BX
	PUSH CX
	
	MOV BX,[BP+4];array addr
	MOV CH,0
	MOV CL,BYTE PTR[BP+6];LEN
	JCXZ DONE_
L1:
	CMP BYTE PTR[BX],'a';�Ƚ����ֵ��'a'�Ĺ�ϵ�������'a'С��˵������Сд��ĸ
	JB NEXT
	CMP BYTE PTR[BX],'z';�Ƚ����ֵ��'z'�Ĺ�ϵ�������'z'��Ҳ����Сд��ĸ
	JA NEXT
	;��������е����˵����Сд��ĸ
	SUB BYTE PTR[BX],32
NEXT:
	INC BX
	LOOP L1
DONE_:
	;�ָ�ִ���ֳ�

	POP CX
	POP BX
	POPF
	POP BP
	RET 4
TO_UPPER ENDP

CODES ENDS
    END START
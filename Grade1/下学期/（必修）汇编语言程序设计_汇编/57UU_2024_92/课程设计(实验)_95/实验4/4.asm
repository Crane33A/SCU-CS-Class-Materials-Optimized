DATAS SEGMENT
    VARB DB 14,-25,66,-17,78,-33,46,-96,71,80
 	LEN EQU $-VARB;���鳤��
    ODDNUM DB 0
    EVENNUM DB 0
DATAS ENDS

STACKS SEGMENT
    
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    
    MOV CX,LEN;VARB�ĳ���
    LEA BX,VARB;VARB�ĵ�ַ
LOOP_START:
	MOV AH,[BX]
	ADD AH,0;�ı��־λSF
	JNS POSITIVE
	NEG AH;���������Ļ���ȡ��
POSITIVE:
	SAR AH,1;�����λȡ����CF��
	JC ODD_NUM
EVEN_NUM:
	INC EVENNUM;ż��
	JMP FINISH;��ת����������������ż������
ODD_NUM:
	INC ODDNUM;����
FINISH:
	
	INC BX;��ַλ+1��ָ����һ������
	LOOP LOOP_START;ѭ����ÿһ�����ַ���
    
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
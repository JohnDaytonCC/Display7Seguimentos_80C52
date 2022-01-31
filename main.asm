;====================================================================
; Programa utilizado para implementar o nome IFCE em quatro display
; de 7 seguimentos, com deslocamento do nome
;
; Created:   qua jul 17 2013
; Processor: 80C52
; Compiler:  ASEM-51 (Proteus)
; By: John Dayton Chaves Custódio
;====================================================================

$NOMOD51
$INCLUDE (80C52.MCU)

;====================================================================
; DEFINITIONS
;====================================================================

;====================================================================
; VARIABLES
;====================================================================

;====================================================================
; RESET and INTERRUPT VECTORS
;====================================================================

      ; Reset Vector
      ORG   0000h
      JMP  INICIO

;====================================================================
; CODE SEGMENT
;====================================================================
      
INICIO:	MOV		SP,#2FH			;DESLOCAMENTO DA PILHA PARA 2FH
		MOV		DPTR,#TABELA	;MOVE VALORES DA TABELA PARA DPTR
NOVO:	MOV		A,#0			;INICIALIZA REGISTRADOR COM VALOR 0
		MOV		R0,#0
		MOV		R1,#1
		MOV		R2,#2
		MOV		R3,#3
SEGUE:	MOV		A,R3
		MOVC	A,@A+DPTR	;VALOR DE DPTR DESLOCADO 3 POSIÇÃO
		ACALL	ENVIA
		MOV		A,R2
		MOVC	A,@A+DPTR	;VALOR DE DPTR DESLOCADO 2 POSIÇÃO
		ACALL	ENVIA
		MOV		A,R1
		MOVC	A,@A+DPTR	;VALOR DE DPTR DESLOCADO 1 POSIÇÃO
		ACALL	ENVIA
		MOV		A,R0
		MOVC	A,@A+DPTR	;ATRIBUI O MESMO VALOR DE DPTR
		ACALL	ENVIA		;CHAMA ROTINA QUE ENVIA OS VALORES AOS DISPLAYS
		ACALL	T_05S		;CHAMA ROTINA DE TEMPO
		INC		R3			;INICIALIZA O INCREMENTO PARA O DESLOCAMENTO DO NOME
		INC		R2
		INC		R1
		INC		R0
		CJNE	R0,#15,SEGUE	;REGISTRADOR IGUAL A 8?
							;NÃO, ENTÃO DESVIA PARA SEGUE
		AJMP	NOVO		;SIM, ENTAO DESVIA PARA NOVO
;--------------------------------------------------------------------
;ROTINA		T_05S
T_05S:	MOV		08H,#4	;MOVE O VALOR A DECIMAL PARA O ENDEREÇO DA MEMÓRIA 08H
MAIS:	ACALL	TEMPO	;CHAMA A ROTINA TEMPO
		DJNZ	08H,MAIS	;DECREMENTA O VALOR DA MEMÓRIA 08H E SALTA SE ZERO, CASO CONTRÁRIO VAI PARA MAIS
		RET			;RETORNO DA ROTINA
;--------------------------------------------------------------------
;ROTINA		TEMPO
TEMPO:	MOV		09H,#250	;CAREGA R0 DO BANCO 1 COM O VALOR DE 250 DECIMAL
SEG1:	MOV		0AH,#250	;CAREGA R1 DO BANCO 1 COM O VALOR DE 250 DECIMAL
		DJNZ	0AH,$		;ESPERA DECREMENTAR ATÉ ZERAR O VALOR DE 0AH DA MEMÓRIA
		DJNZ	09H,SEG1	;SALTA A INSTRUÇÃO SE O VALOR FOR IGUAL A ZERO
		RET			;RETORNO DA ROTINA
;-------------------------------------------------------------------
;ROTINA		ENVIA
ENVIA:	MOV		R7,#8		;ATRIBUI O VALOR DE 8 A R7 PARA PODER ENVIA BIT A BIT PELA CARRY
REPETE:	MOV		C,ACC.7		;MOVE PARA A CARRY O BIT MAIS SIGNIFICATIVO DO ACC
		MOV		P1.1,C		;ATRIBUI O PINO 1 DA PORTA 1 O VALOR DA CARRY
		SETB	P1.0		;SETA O PINO 1 DA PORTA 1, CLOCK
		NOP			;TEMPO NECESSÁRIO PARA O CI 4015 RECONHECER O PULSO
		NOP
		NOP
		NOP
		NOP
		CLR		P1.0		;LIMPA O PINO 1 DA PORTA 1
		RL		A			;ROTACIONA A ESQUERDA O VALOR DO ACUMULADOR
		DJNZ	R7,REPETE	;AGUARDA R7 IGUAL A ZERO, OU SEJA, O ENVIO DE TODOS OS 8 BITS
		RET			;RETORNO DA ROTINA
;--------------------------------------------------------------------
;CONSTRUÇÃO DA TABELA
TABELA:	DB	00H,00H,00H,00H,1EH,3FH,76H,54H,00H,5EH,77H,6EH,78H,3FH,54H,00H,00H,00H,00H

;====================================================================
      END

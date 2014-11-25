*-----------------------------------------------------------
* Title      :  DISSEMBLER PROTOTYPE I/O
* Written by :  BRANDAN HAERTEL, ERICK HOUSE, GARY MIXSON
* Date       :  10/5/2014
* Description:  MAIN PROGRAM <- NEED A BETTER DESCRIPTION!
*-----------------------------------------------------------

* 000 Dn
* 001 An
* 010 (An)
* 011 (An)+
* 100 -(An)
* 101 #$
* 110 #WXYZ
* 111 $

* D0 IO TRAP TASK
* D1 IO TRAP TASK
* D2 OPERAND 1 MODE
* D3 OPERAND 1 REGISTER
* D4 OPERAND 2 MODE
* D5 OPERAND 2 REGISTER
* D6
* D7

* A0
* A1 IO TRAP TASK
* A2
* A3
* A4
* A5 START/CURRENT ADDRESS
* A6 ENDING ADDRESS
* A7 STACK POINTER

*-----------------------------------------TEST DATA--------------------------------------------------------
TESTDATA
    CMP         D1,D2           ;Data register direct
    CMP         A1,D2           ;Address register direct
    CMP         $0010,D2        ;
    CMP         $1234FFFF,D2
    CMP         #14,D2
    CMP.L       #$12345,D2   
    
*--------------------MOVEA VARIANTS---------------------------
    MOVEA.W     D1,A2
    MOVEA.L     D1,A2
    MOVEA.W     -(A6),A2
    MOVEA.L     -(A6),A2
    MOVEA.W     #$1600,A2
    MOVEA.L     #$1600,A2
    MOVEA.L     #$FFFF,A2
    MOVEA.L     #$16001234,A2
    MOVEA.W     #14,A2
    MOVEA.L     #14,A2
    MOVEA.L     $1600,A2
    MOVEA.W     $1600,A2
    MOVEA.W     $16001234,A2
    
    
*----------------------MOVE VARIANTS--------------------------
    MOVE.B      D5,D6           *Data Register Direct
    MOVE.L      A5,A4           *Address Register Direct
    MOVE.B      (A5),D6         *Address Register Indirect
    MOVE.B      #255,D6         *Immediate Data
    MOVE.B      (A5)+,D6        *Address Register with Postincrement
    MOVE.B      -(A5),D6        *Address Register with Predecrement
    MOVE.B      D5,$19001234    *Absolute Long Address
    MOVE.B      D5,$1900        *Absolute Word Address
    
    MOVE.W    D2,A2
    MOVE.L    D3,$1650000
    MOVE.B    #14,D6
    MOVE.W    #14,D6
    MOVE.L    #1455,D6
    MOVE.L    #1455,A6
    MOVE.L    #145555,D6
    
*--------------------MOVEM VARIANTS--------------------------
    MOVEM.L     A0-A3/D0-D7, -(A7)

*----------------------CMP VARIANTS--------------------------
CMPVARIANTS
    CMP         D1,D2           ;Data register direct
    CMP         A1,D2           ;Address register direct
    CMP         $0010,D2        ;
    CMP         $1234FFFF,D2
    CMP         #14,D2
    CMP.L       #$12345,D2
    
*--------------------BTST VARIANTS-----------------------
    BTST    D3,#1234
    BTST    D7,D2
    BTST    D7,$1600
    BTST    D7,$12345678
    BTST    #12345678,D2
    BTST.L  #$12345678, D2
    BTST    #$12345678, D2
ENDTESTDATA
*------------------------------------------------END TEST DATA---------------------


* Put variables and constants here
*------------------------------------------Opcode Constants----------------------------------------------------
BEQ_OP              DC.B        'BEQ',0
ADD_OP              DC.B        'ADD',0
ADDA_OP             DC.B        'ADDA',0
ADDQ_OP             DC.B        'ADDQ',0
AND_OP              DC.B        'AND',0
ASL_OP              DC.B        'ASL',0
ASR_OP              DC.B        'ASR',0
BHI_OP              DC.B        'BHI',0
BLT_OP              DC.B        'BLT',0
BNE_OP              DC.B        'BNE',0
BRA_OP              DC.B        'BRA',0
BTST_OP             DC.B        'BTST',0
CMP_OP              DC.B        'CMP',0
CMPA_OP             DC.B        'CMPA',0
CMPI_OP             DC.B        'CMPI',0
DIVS_OP             DC.B        'DIVS',0
EOR_OP              DC.B        'EOR',0
EORI_OP             DC.B        'EORI',0
JSR_OP              DC.B        'JSR',0
LEA_OP              DC.B        'LEA',0
LSL_OP              DC.B        'LSL',0
LSR_OP              DC.B        'LSR',0
MOVE_OP             DC.B        'MOVE',0
MOVEA_OP            DC.B        'MOVEA',0
MOVEM_OP            DC.B        'MOVEM',0
MULS_OP             DC.B        'MULS',0
NEG_OP              DC.B        'NEG',0
NOT_OP              DC.B        'NOT',0
ORI_OP              DC.B        'ORI',0
ROL_OP              DC.B        'ROL',0
ROR_OP              DC.B        'ROR',0
RTS_OP              DC.B        'RTS',0
SUB_OP              DC.B        'SUB',0
SUBA_OP             DC.B        'SUBA',0
SUBI_OP             DC.B        'SUBI',0
*-----------------------------------------------------------

CR                  EQU         $0D                 ; Carriage Return
LF                  EQU         $0A                 ; Line Feed
BS                  EQU         $08                 ; Backspace
HT                  EQU         $09                 ; Tab (horizontal 5 characters)
LF                  EQU         $0A                 ; New line (line feed)
VT                  EQU         $0B                 ; Vertical tab (4 lines)
FF                  EQU         $0C                 ; Form Feed (Always end printing with a Form Feed.)

NUM_EXP_WRDS        DS.B        1                   ; Number of expansion words after the opcode
                    
NUM_OPERANDS        DS.B        1                   ; Number of operands for the current instruction valid range: 1 or 2
                    
PAUSE_COUNT         DC.W        30                  ; COUNTER
PAUSE_MSG           DC.B        'Dissambler paused. Press any key to continue...',0
EL                  DC.B        '',CR,LF,0          ; End Line
OP_COMMA            DC.B        ',',0
TAB                 DC.B        '',HT,0

SPLASH              DC.B        '        ____ ___  __ __                        ',CR,LF
                    DC.B        '       / __/( _ )/ //_/                        ',CR,LF
                    DC.B        '      / _ \/ _  / ,<                           ',CR,LF
                    DC.B        '      \___/\___/_/|_|  __      _               ',CR,LF
                    DC.B        '        / __/ /__ ____/ /_____(_)___           ',CR,LF
                    DC.B        '       / _// / -_) __/ __/ __/ / __/           ',CR,LF
                    DC.B        '      /___/_/\__/\__/\__/_/_/_/\__/        __  ',CR,LF
                    DC.B        '        / __/ /  ___ ___  / /  ___ _______/ /__',CR,LF
                    DC.B        '       _\ \/ _ \/ -_) _ \/ _ \/ -_) __/ _  (_-<',CR,LF
                    DC.B        '      /___/_//_/\__/ .__/_//_/\__/_/  \_,_/___/',CR,LF
                    DC.B        '                  /_/                          ',CR,LF
                    DC.B        'Brandan Heaertel' ,CR,LF
                    DC.B        'Erick House'      ,CR,LF
                    DC.B        'Gary Mixson'      ,CR,LF,CR,LF,0

GETSRTHEX           DC.B        'Enter Starting Hex Address Of Program: ',CR,LF,0
GETENDHEX           DC.B        'Enter Ending Hex Address Of Program: ',CR,LF,0
RUNAGAIN            DC.B        'Would You Like To Dissasmble Anouther Program? (Y/N): ',CR,LF,0
CONFIRMSRT          DC.B        'Starting address is stored',CR,LF,0
CONFIRMEND          DC.B        'Ending address is stored',CR,LF,0
EXEASCII            DC.B        'Executing ASCII',CR,LF,0
BADADDRESS          DC.B        'Bad address...',CR,LF,0

SP0                 DC.B        'D',0
SP1                 DC.B        'A',0
SP2                 DC.B        '(A',0
SP3                 DC.B        '(A',0
SP4                 DC.B        '-(A',0
SP5                 DC.B        '#$',0
SP6                 DC.B        '#WXYZ',0
SP7                 DC.B        '$',0

SE0                 DC.B        '',0
SE1                 DC.B        '',0
SE2                 DC.B        ')',0
SE3                 DC.B        ')+',0
SE4                 DC.B        ')',0
SE5                 DC.B        '',0
SE6                 DC.B        '',0
SE7                 DC.B        '',0

MASK_13_12          EQU     %00110000000000000000000000000000
MASK_11_9           EQU     %00001110000000000000000000000000
MASK_8_6            EQU     %00000001110000000000000000000000
MASK_5_3            EQU     %00000000001110000000000000000000
MASK_2_0            EQU     %00000000000001110000000000000000

    *Attributes
BYTE                DC.B    '.B',HT,0
WORD                DC.B    '.W',HT,0
LONG                DC.B    '.L',HT,0
    
START:              ORG         $3000               ; first instruction of program

*--------------------MAIN-----------------------------------
* Put program code here

MAIN
                    MOVE.B      #0,NUM_EXP_WRDS     ; Initialize to 0
                    MOVE.B      #0,NUM_OPERANDS     ; Initialize to 0
                    BRA         AUTOTEST
                    ;JSR         SPLASH_SCREEN
                    ;BRA         STARTHEX
                                 ;
                    
SPLASH_SCREEN       LEA         SPLASH,A1           ; put the GETSRTHEX message into A1
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS             
*---------------------------Autohex----------------------
AUTOTEST

                    MOVEA.L     #TESTDATA,A5
                    MOVEA.L     #ENDTESTDATA,A6
                    
                    BRA         MAIN_LOOP_RUN           ; branch to main loop                    
                    
*-------------------MAIN LOOP------------------------------
* main program loop
* check to see if the starting address is before the ending
* adress, if so run MINI_LOOP, else prompt to run again.

MAIN_LOOP
                    ADDA.L      #$2,A5              ; add 1 word to the start address to move over the opcode
*                    ADDA.L      NUM_EXP_WRDS,A5
*                    ADDA.L      NUM_EXP_WRDS,A5
                    CLR         D0
                    MOVE.B      NUM_EXP_WRDS,D0
                    ADDA.L      D0,A5
                    ADDA.L      D0,A5
*                    MULU        #$4,D0
*                    ADDA.L      D0,A5
*                    MOVE.L      NUM_OPERANDS,D1     ; copy the operands count to D1
*                    MULU        #8,D1               ; multiply 8bits be the number of operands to move over 
*                    ADDA.L      D1,A5               ; add operand displacment to the start adress to find
*                                                    ; the begining of the nexr opcode
                    BRA         MAIN_LOOP_RUN       ; branch to the main loop

MAIN_LOOP_RUN       JSR         DEC_LOOP_COUNT
                    CMPI.W      #$0,PAUSE_COUNT
                    BEQ         PAUSE
                    
                    MOVE.L      A5,D1
                    MOVE.L      A6,D2
                    CMP.L       D1,D2               ; check if starting address and ending address are equal
                    BEQ         PROMPTRUNAGAIN      ; if equal end program by prompting to run again
                    BRA         BEGINOPCODE         ; branch to opcode conversion
                    
DEC_LOOP_COUNT      SUBI.W      #$1,PAUSE_COUNT
                    RTS
                    
PAUSE               LEA         PAUSE_MSG,A1
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    SUBA.L      A1,A1
                    MOVE.B      #2,D0               ; trap task 5 grabs a single character
                    TRAP        #15                 ; trap #15 I/O
                    MOVE.W      #30,PAUSE_COUNT
                    JSR         CLEAR_SCREEN
                    BRA         MAIN_LOOP_RUN

*--------------------STARTHEX & ENDHEX-------------------------------
* prompt the user for a starting address in hex
* prompt the user for a ending address in hex
* this does not error check!

STARTHEX
                    LEA         GETSRTHEX,A1        ; put the GETSRTHEX message into A1
                    MOVE.B      #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
            
                    MOVE.B      #2,D0               ; read a string in from the keyboard
                    TRAP        #15                 ; trap #15 I/O
            
                    JSR         CALLCONVERTASCII
                    MOVEA.L     D3,A5               ; move converted address to A5(start address)
                    MOVE.L      #$0,D3              ; reset D3
                    JSR         CLEAR_SCREEN
                    JSR         SPLASH_SCREEN
                    BRA         ENDHEX              ; branch to get and convert the ending address
ENDHEX
                    LEA         GETENDHEX,A1        ; put the GETENDHEX message into A1
                    MOVE.B      #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
            
                    MOVE.B      #2,D0               ; read a string in from the keyboard
                    TRAP        #15                 ; trap #15 I/O

                    JSR         CALLCONVERTASCII
                    MOVEA.L     D3,A6               ; move converted address to A6(end address)
                    JSR         CLEAR_DATA
                    JSR         CLEAR_SCREEN
                    BRA         MAIN_LOOP_RUN           ; branch to main loop
                    
*---------------------CALLCONVERTASCII--------------------------------
* preps the ascii to hex conversion by putting the length of the hex
* address in register D1

CALLCONVERTASCII
                    MOVE.L      #$4,D1              ; convert 1 word
                    JSR         ASCIITOHEX          ; convert the string to hex address
                    RTS                             ; return
             
*-------------------ASCIITOHEX------------------------------
* turn the ascii letter in A1 to hex
* A1 = FULL STRING TO CONVERT
* D1 = CONVERSION COUNT
* D2 = DIGIT TO CONVERT
* D3 = CONVERTED NUMBER

ASCIITOHEX
                    MOVE.B      (A1)+,D2            ; move number to data reg for conversion
                    CMPI.B      #$39,D2             ; check if number
                    BLE         NUMTOHEX            ; branch to convert number
                    BRA         STRINGTOHEX
STRINGTOHEX
                    SUBI.B      #$37,D2             ; convert to number (ASCII $40-#10)
                    BRA         ASCIINEXT           ; go to next number
NUMTOHEX
                    SUBI.B      #$30,D2             ; convert to number
                    BRA         ASCIINEXT           ; go to next number
ASCIINEXT
                    ADD.B       D2,D3               ; add converted number to address
                    SUBI.B      #$1,D1              ; decrement counter
                    CMPI.B      #$0,D1              ; check to see if done
                    BEQ         ASCIITOHEXQUIT      ; branch to finished sub routine
                    ROL.L       #4,D3               ; shift 4 left
                    BRA         ASCIITOHEX          ; loop back to ASCIITOHEX
ASCIITOHEXQUIT
                    RTS                             ; return back
                   
*---------------------PROMPTRUNAGAIN-------------------------
* ask to run the program again, if Y then call MAIN
* if N then END program

PROMPTRUNAGAIN     
                    LEA         RUNAGAIN,A1         ; put message into A1
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                
                    MOVE.B      #2,D0               ; trap task 5 grabs a single character
                    TRAP        #15                 ; trap #15 I/O
                    CMP.L       #$59,D1             ; compare Y to D1
                    BEQ         RESET               ; brach to Reset if D1 == UPPER(Y)
                    
                    CMP.B       #$79,D1             ; compare y to D1
                    BEQ         RESET               ; brach to Reset if D1 == LOWER(y)
                    BRA         ENDPROGRAM          ; else branch to end

*----------------------RESET--------------------------------
* prep the program to run again

RESET               JSR         CLEAR_SCREEN
                    JSR         CLEAR_DATA
                    JSR         CLEAR_ADDRESS
                    BRA         START               ; branch back to start
                    
CLEAR_SCREEN        MOVE.B      #11,D0              ; clear the screen
                    MOVE.W      #$FF00,D1           ; clear the screen
                    TRAP        #15                 ; send trap task command
                    RTS
CLEAR_DATA          CLR         D0                  ; clear the data register
                    CLR         D1                  ; clear the data register
                    CLR         D2                  ; clear the data register
                    CLR         D3                  ; clear the data register
                    CLR         D4                  ; clear the data register
                    CLR         D5                  ; clear the data register
                    CLR         D6                  ; clear the data register
                    CLR         D7                  ; clear the data register
                    RTS
CLEAR_ADDRESS       SUBA.L      A0,A0               ; clear the acess register
                    SUBA.L      A1,A1               ; clear the acess register
                    SUBA.L      A2,A2               ; clear the acess register
                    SUBA.L      A3,A3               ; clear the acess register
                    SUBA.L      A4,A4               ; clear the acess register
                    SUBA.L      A5,A5               ; clear the acess register
                    SUBA.L      A6,A6               ; clear the acess register
                    RTS

*----------------------PRINT------------------------------------------
* print the operands

PRINT               CMPI.B      #$0,NUM_OPERANDS    ; check to see if opcode has no operands
                    BEQ         PRINT_RETURN        ; return to main loop if no operands
                    
                    JSR         PRINT_OPMODE1_PRE   ; print the first opmode preface symbol
                    JSR         PRINT_OPREG1        ; print the first opmode register
                    JSR         PRINT_OPMODE1_POST  ; print the first opmode post symbol
                    CMPI.B      #$1,NUM_OPERANDS    ; check if opcode has 2 operands
                    BEQ         PRINT_RETURN        ; return to main loop if opcode has 1 operand
                    
                    LEA         OP_COMMA,A1         ; move comma string to A1
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    
                    JSR         PRINT_OPMODE2_PRE   ; print the second opmode preface symbol
                    JSR         PRINT_OPREG2        ; print the second opmode register
                    JSR         PRINT_OPMODE2_POST  ; print the second opmode post symbol
                    BRA         PRINT_RETURN        ; return to main loop
                    
PRINT_RETURN        LEA         EL,A1               ; print end of line to screen
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    BRA         MAIN_LOOP           ; return to main loop

BAD_MSG             DC.B        'DATA',HT,'#WXYZ',CR,LF,0

PRINT_BAD
                    CLR         D2
                    CLR         D3
                    CLR         D4
                    CLR         D5
                    LEA         BAD_MSG,A1
                    MOVE.B      #14,D0
                    TRAP        #15
                    BRA         MAIN_LOOP
                                
*----------------------PRINT OPMODE PRE--------------------------------
* print the preface operand mode symbol(s)

PRINT_OPMODE1_PRE   LEA         MODE1_PRE,A0        ; Index into the table
                    CLR         D1                  ; clear D1
                    SUBA.L      A1,A1               ; clear A1
                    MOVE.B      D2,D1               ; copy the operand mode code to D1
                    MULU        #$6,D1              ; multiply the operand mode code by 6 bytes
                    JSR         0(A0,D1)            ; Jump indirect with index 
                    RTS                             ; return

MODE1_PRE           JMP         MODE1_PRE000         
                    JMP         MODE1_PRE001
                    JMP         MODE1_PRE010
                    JMP         MODE1_PRE011
                    JMP         MODE1_PRE100
                    JMP         MODE1_PRE101
                    JMP         MODE1_PRE110
                    JMP         MODE1_PRE111
                    
MODE1_PRE000        LEA         SP0,A1              ; print pre symbols for opmode Dn
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS
MODE1_PRE001        LEA         SP1,A1              ; print pre symbols for opmode An
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS
MODE1_PRE010        LEA         SP2,A1              ; print pre symbols for opmode (An)
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS
MODE1_PRE011        LEA         SP3,A1              ; print pre symbols for opmode (An)+
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS
MODE1_PRE100        LEA         SP4,A1              ; print pre symbols for opmode -(An)
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS
MODE1_PRE101        LEA         SP5,A1              ; print pre symbols for opmode #$
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS
MODE1_PRE110        LEA         SP6,A1              ; print pre symbols for opmode #WXYZ
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS
MODE1_PRE111        LEA         SP7,A1              ; print pre symbols for opmode $
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS

*----------------------PRINT OP REGISTER 1--------------------------------
* print the REGISTER FOR OPMODE 1                   

PRINT_OPREG1        CLR         D1                  ; clear D1
*                    SUBA.L      A1,A1               ; clear A1
                    MOVE.L      D3,D1
                    MOVE        #3,D0               ; trap task #14 to print the message to screen
*                    MOVE.L      D2,D6               ; SAVE MODE1                                                *CANNOT USE THIS TRAP, MUST CHANGE
*                    MOVE.L      D3,D1               ; PUT REG# INTO 1                                           *CANNOT USE THIS TRAP, MUST CHANGE
*                    MOVE.L      #16,D2              ; PUT BASE 16 INTO D2                                       *CANNOT USE THIS TRAP, MUST CHANGE
*                    MOVE.B      #15,D0              ; TRAP TASK 15                                              *CANNOT USE THIS TRAP, MUST CHANGE
                    TRAP        #15                 ; trap #15 I/O                                              
*                    MOVE.L      D6,D2               ; RESTORE MODE1                                             *CANNOT USE THIS TRAP, MUST CHANGE
                    RTS
                    
*REGVALUE            DC.L        0
*
*PRINT_OPREG1        CLR         D1                  ; clear D1
*                    SUBA.L      A1,A1               ; clear A1
*                    MOVE.L      D3,REGVALUE
*                    MOVEA.L     REGVALUE,A1
*                    JSR         DEC2ASCII    
*   
*                    MOVEA.L     A2,A1
*                    MOVE        #14,D0               ; trap task #14 to print the message to screen
*                    TRAP        #15                 ; trap #15 I/O
*                    RTS
*    
*DEC2ASCII           MOVE.L      #8,D7               ; move counter to D7
*                    JSR         D2ALOOP             ; start loop
*                    RTS                             ; return
*D2ALOOP             MOVE.B      (A1)+,D6            ; move 
*                    CMPI.B      #$09,D6             ; compare 9 to byte         
*                    BLE         DECTONUM
*                    BRA         DECTOLET
*DECTONUM            ADDI.B      #$30,D6             ; add 30 to number
*                    BRA         D2ANEXT
*DECTOLET            ADDI.B      #$37,D6
*                    BRA         D2ANEXT
*
*D2ANEXT             SUBI.B      #$1,D7
*                    MOVE.B       D6,(A2)+
*                    
*                    CMPI.B      #$0,D7
*                    BEQ         D2AQUIT
*                    ROL.L       #4,D1
*                    BRA         D2ALOOP
*D2AQUIT             RTS

*----------------------PRINT OPMODE POST--------------------------------
* print the post operand mode symbol(s)

PRINT_OPMODE1_POST  LEA         MODE1_POST,A0       ; Index into the table
                    CLR         D1
                    MOVE.B      D2,D1               ; copy the operand mode code to D1
                    MULU        #$6,D1              ; multiply the operand mode code by 6 bytes
                    JSR         0(A0,D1)            ; Jump indirect with index 
                    RTS                             ; branch to next part of program

MODE1_POST          JMP         MODE1_POST000         
                    JMP         MODE1_POST001
                    JMP         MODE1_POST010
                    JMP         MODE1_POST011
                    JMP         MODE1_POST100
                    JMP         MODE1_POST101
                    JMP         MODE1_POST110
                    JMP         MODE1_POST111
                    
MODE1_POST000       LEA         SE0,A1              ; print post symbols for opmode Dn
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS
MODE1_POST001       LEA         SE1,A1              ; print post symbols for opmode An
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS
MODE1_POST010       LEA         SE2,A1              ; print post symbols for opmode (An)
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS
MODE1_POST011       LEA         SE3,A1              ; print post symbols for opmode (An)+
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS
MODE1_POST100       LEA         SE4,A1              ; print post symbols for opmode -(An)
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS
MODE1_POST101       LEA         SE5,A1              ; print post symbols for opmode #$
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS
MODE1_POST110       LEA         SE6,A1              ; print post symbols for opmode #WXYZ
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS
MODE1_POST111       LEA         SE7,A1              ; print post symbols for opmode $
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS

*----------------------PRINT OPMODE PRE--------------------------------
* print the preface operand mode symbol(s)

PRINT_OPMODE2_PRE   LEA         MODE2_PRE,A0        ; Index into the table
                    CLR         D1                  ; clear D1
                    SUBA.L      A1,A1               ; clear A1
                    MOVE.B      D4,D1               ; copy the operand mode code to D1
                    MULU        #$6,D1              ; multiply the operand mode code by 6 bytes
                    JSR         0(A0,D1)            ; Jump indirect with index 
                    RTS                             ; return

MODE2_PRE           JMP         MODE2_PRE000         
                    JMP         MODE2_PRE001
                    JMP         MODE2_PRE010
                    JMP         MODE2_PRE011
                    JMP         MODE2_PRE100
                    JMP         MODE2_PRE101
                    JMP         MODE2_PRE110
                    JMP         MODE2_PRE111
                    
MODE2_PRE000        LEA         SP0,A1              ; print pre symbols for opmode Dn
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS
MODE2_PRE001        LEA         SP1,A1              ; print pre symbols for opmode An
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS
MODE2_PRE010        LEA         SP2,A1              ; print pre symbols for opmode (An)
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS
MODE2_PRE011        LEA         SP3,A1              ; print pre symbols for opmode (An)+
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS
MODE2_PRE100        LEA         SP4,A1              ; print pre symbols for opmode -(An)
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS
MODE2_PRE101        LEA         SP5,A1              ; print pre symbols for opmode #$
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS
MODE2_PRE110        LEA         SP6,A1              ; print pre symbols for opmode #WXYZ
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS
MODE2_PRE111        LEA         SP7,A1              ; print pre symbols for opmode $
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS

*----------------------PRINT OP REGISTER 1--------------------------------
* print the REGISTER FOR OPMODE 1                   

PRINT_OPREG2        CLR         D1
                    MOVE.L      D5,D1
                    MOVE        #3,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS
                    
*----------------------PRINT OPMODE POST--------------------------------
* print the post operand mode symbol(s)

PRINT_OPMODE2_POST  LEA         MODE2_POST,A0       ; Index into the table
                    CLR         D1                  ; clear D1
                    SUBA.L      A1,A1               ; clear A1
                    MOVE.B      D4,D1               ; copy the operand mode code to D1
                    MULU        #$6,D1              ; multiply the operand mode code by 6 bytes
                    JSR         0(A0,D1)            ; Jump indirect with index 
                    RTS                             ; branch to next part of program

MODE2_POST          JMP         MODE2_POST000         
                    JMP         MODE2_POST001
                    JMP         MODE2_POST010
                    JMP         MODE2_POST011
                    JMP         MODE2_POST100
                    JMP         MODE2_POST101
                    JMP         MODE2_POST110
                    JMP         MODE2_POST111
                    
MODE2_POST000       LEA         SE0,A1              ; print post symbols for opmode Dn
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS
MODE2_POST001       LEA         SE1,A1              ; print post symbols for opmode An
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS
MODE2_POST010       LEA         SE2,A1              ; print post symbols for opmode (An)
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS
MODE2_POST011       LEA         SE3,A1              ; print post symbols for opmode (An)+
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS
MODE2_POST100       LEA         SE4,A1              ; print post symbols for opmode -(An)
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS
MODE2_POST101       LEA         SE5,A1              ; print post symbols for opmode #$
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS
MODE2_POST110       LEA         SE6,A1              ; print post symbols for opmode #WXYZ
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS
MODE2_POST111       LEA         SE7,A1              ; print post symbols for opmode $
                    MOVE        #14,D0              ; trap task #14 to print the message to screen
                    TRAP        #15                 ; trap #15 I/O
                    RTS

*------------------------------Begin OpCode----------------------------------



Bits_15141312  EQU  %1111000000000000

Bits_876       EQU  %0000000111000000

Bits_11109     EQU  %0000111000000000


*------------------------------Configure JMP----------------------------------

CONFIGURE_JMP    

                 MOVE.W  (A5),D0         ; Copy the current opcode
                
                 AND.W   D3,D0           ; Mask the current Opcode 
                
                 LSR.W   D1,D0           ; Shift over a certain number of bits    
                
                 MULU    #6,D0           ; Multiply by 6 to JMP b/c each JMP is 6 bytes    
                 
                 RTS                     ; return

*------------------------------Configure JMP----------------------------------


BEGINOPCODE      JSR     CLEAR_DATA      ; Clear all of the Registers

                 LEA     jmp_table,A0    ;Load the next JMP table
                 
                 MOVE.W  #Bits_15141312,D3     ;Move the mask into D3
                 
                 MOVE.W  #12,D1          ;Move the shift amount into D1

                 JSR     CONFIGURE_JMP   
               
                 JMP     0(A0,D0)     

*----------------------Initial jmp table----------------------------------                    

jmp_table        JMP     code0000

                 JMP     code0001

                 JMP     code0010

                 JMP     code0011

                 JMP     code0100

                 JMP     code0101

                 JMP     code0110

                 JMP     code0111

                 JMP     code1000

                 JMP     code1001

                 JMP     code1010

                 JMP     code1011

                 JMP     code1100

                 JMP     code1101

                 JMP     code1110

                 JMP     code1111


* ------------------------ end initial jmp table----------------------------

 

 
*------------------------------------Begin Bucket 0001-------------------------------
* Supported Opcodes
* CMPI, EORI, ORI, SUBI, BTST


*Check BTST is a special function to make sure that the opcode is not btst
* it is easy to look at a code and accidently return BTST when it is not
Check_BTST       JSR     CLEAR_DATA

                 MOVE.W  #Bits_876,D3                  ;Move the mask into D3
                 
                 MOVE.W  #6,D1                         ;Move the shift amount into D1 
                 
                 MOVE.W  (A5),D0                       ; Copy the current opcode
                
                 AND.W   D3,D0                         ; Mask the current Opcode 
                
                 LSR.W   D1,D0                         ; Shift over a certain number of bits

                 RTS
  

*starting the the JMP
code0000         JSR     CLEAR_DATA                    ; Clear all of the Registers    

                 LEA     jmp_table_0000_11109 ,A0      ;Next JMP table
                 
                 MOVE.W  #Bits_11109,D3                  ;Move the mask into D3
                 
                 MOVE.W  #9,D1                         ;Move the shift amount into D1

                 JSR     CONFIGURE_JMP   
               
                 JMP     0(A0,D0)
                   
jmp_table_0000_11109        JMP code_0000_000

                            JMP code_0000_001

                            JMP code_0000_010

                            JMP code_0000_011

                            JMP code_0000_100

                            JMP code_0000_101

                            JMP code_0000_110

                            JMP code_0000_111
  

          
code_0000_000     JSR   Check_BTST
                  CMPI  #4,D0
                  BRA   BTST_EA
                  *BRA   CMPI_EA   

code_0000_001     JSR   Check_BTST
                  CMPI  #4,D0
                  BRA   BTST_EA
                  *BRA   SUBI_EA 

code_0000_010     JSR   Check_BTST
                  CMPI  #4,D0
                  BRA   BTST_EA
                  BRA   PRINT_BAD 

code_0000_011     JSR   Check_BTST
                  CMPI  #4,D0
                  BRA   BTST_EA
                  BRA   PRINT_BAD 

code_0000_100     BRA   BTST_EA
              
code_0000_101     JSR   Check_BTST
                  CMPI  #4,D0
                  BRA   BTST_EA
                  *BRA   EORI_EA 

code_0000_110     JSR   Check_BTST
                  CMPI  #4,D0
                  BRA   BTST_EA
                  BRA   PRINT_BAD 

code_0000_111     JSR   Check_BTST
                  CMPI  #4,D0
                  BRA   BTST_EA
                  BRA   PRINT_BAD 
                
*------------------------------------End Bucket 0000---------------------------------



*------------------------------------Begin Bucket 0001-------------------------------
code0001         BRA        MOVE_EA
*------------------------------------End Bucket 0001---------------------------------


*------------------------------------Begin Bucket 0010-------------------------------
code0010         BRA        MOVE_EA
*------------------------------------End Bucket 0010---------------------------------


*------------------------------------Begin Bucket 0011-------------------------------
code0011         BRA        MOVE_EA
*------------------------------------End Bucket 0011---------------------------------
 
code0100        STOP        #$2700

code0101        STOP        #$2700

code0110        STOP        #$2700

code0111        STOP        #$2700

code1000        STOP        #$2700

code1001        STOP        #$2700

*------------------------------------Begin Bucket 1010-----------------------------
code1010        BRA      PRINT_BAD
*------------------------------------End Bucket 1010-------------------------------


*------------------------------------Begin Bucket 1011-----------------------------

code1011         JSR     CLEAR_DATA                    ; Clear all of the Registers    

                 LEA     jmp_table_1011_XXX_876 ,A0    ;Next JMP table
                 
                 MOVE.W  #Bits_876,D3                  ;Move the mask into D3
                 
                 MOVE.W  #6,D1                         ;Move the shift amount into D1

                 JSR     CONFIGURE_JMP   
               
                 JMP     0(A0,D0)
                 
                 
                 
jmp_table_1011_XXX_876      JMP code_1011_XXX_000

                            JMP code_1011_XXX_001

                            JMP code_1011_XXX_010

                            JMP code_1011_XXX_011

                            JMP code_1011_XXX_100

                            JMP code_1011_XXX_101

                            JMP code_1011_XXX_110

                            JMP code_1011_XXX_111
  

          
code_1011_XXX_000  BRA CMP_EA
            
code_1011_XXX_001  BRA CMP_EA

code_1011_XXX_010  BRA CMP_EA

code_1011_XXX_011  BRA CMPA_EA

code_1011_XXX_100  BRA EOR_EA

code_1011_XXX_101  BRA EOR_EA

code_1011_XXX_110  BRA EOR_EA

code_1011_XXX_111  BRA CMPA_EA


*-----------------------------End Bucket 1011---------------------------------------

code1100       STOP        #$2700

code1101       STOP        #$2700

code1110       STOP        #$2700

*-----------------------------Begin Bucket 1111-------------------------------------
code1111       BRA      PRINT_BAD
*-----------------------------End Bucket 1111---------------------------------------

*----------------------------------------------Increment Expansion Word Count-----------------------------------------
INCREMENT_WRD_CNT       
                    ADD.B   #1,NUM_EXP_WRDS
                    RTS
                    
*-----------------------------------------------APPLYMASK-----------------------------------
*Caller should move a bit mask from the global variables into D7
*This SR will apply the mask to data currently pointed at by A5
*The result will be shifted to the LSB and stored in D7
*Errors will terminate program
APPLYMASK
        MOVE.L  (A5),D0             ;Get a copy of the data to work on
        AND.L   D7,D0               ;Apply the mask and store remaining bits in d0
        
        *Determine the mask being used to know how many bits need to be shifted off
        CMP.L   #MASK_13_12,D7
        BNE     msk11
        MOVE    #28,D1
        BRA     shift
msk11   CMP.L   #MASK_11_9,D7
        BNE     msk8
        MOVE    #25,D1
        BRA     shift   
msk8    CMP.L   #MASK_8_6,D7
        BNE     msk5
        MOVE    #22,D1
        BRA     shift   
msk5    CMP.L   #MASK_5_3,D7
        BNE     msk2
        MOVE    #19,D1
        BRA     shift   
msk2    CMP.L   #MASK_2_0,D7
        BNE     ENDPROGRAM      ;D7 doesn't match any mask in the global variables
        MOVE    #16,D1
        BRA     shift
        
shift   LSR.L   D1,D0               ;Shift bits to the least sig bit
        MOVE.L  D0,D7               ;Move the data register for display
        
        RTS
 
*------------------------------BTST_EA-------------------------------------------
BTST_EA

        CLR.B   NUM_EXP_WRDS
        MOVE.B  #2,NUM_OPERANDS ;
        
        MOVE.L  #MASK_8_6,D7    ;Mask determines immediate data source
        JSR     APPLYMASK       
        MOVE.L  D7,D2           ;Move for comparrison (will not be displayed)
        
        MOVE.L  #MASK_5_3,D7    ;Mask for EA mode
        JSR     APPLYMASK
        MOVE.L  D7,D4           ;Move mode for display
        
        MOVE.L  #MASK_2_0,D7    ;Mask for ea register
        JSR     APPLYMASK       
        MOVE.L  D7,D5           ;Move ea register for display
        
        CMP.B   #4,D2           ;4 indicates BIT NUMBER STATIC
        BNE     btst_im         ;Immediate if not 4 (assume 0)
        
*Dynamic
        
        MOVE.L  #MASK_11_9,D7   ;Mask for destination register
        JSR     APPLYMASK
        MOVE.L  D7,D3           ;Move register for display
        
        CLR     D2              
        MOVE.B  #0,D2           ;Dynamic always uses data register
        
        CMP.B   #7,D4           ;D4 should be EA Mode
        BLE     btst_not7
        
        
btst_not7
        CMP.B   #0,D4           ;Only supported mode below 7 is 0
        BNE     btst_bad        ;Unsupported address mode
        BSR     print_btst      
        JSR     PRINT_LONG      ;Data reg destination uses long only
        BRA     PRINT           ;Print operands
        JSR     INCREMENT_WRD_CNT   ;Mode 7 has at least 1 expansion word
        CMP.B   #0,D5           ;
        
btst_bad    
        BRA     PRINT_BAD
        
        
btst_im
        MOVE.B  #5,D2           ;First operand mode is immediate
        MOVE.B  #2,NUM_EXP_WRDS ;Immediate btst always has 2 words
        BSR     print_btst      ;Print the opcode
        JSR     PRINT_LONG      ;Immediate is always long
        BRA     PRINT           ;Print the operands
        
        
print_btst
        *Print opcode
        LEA     BTST_OP,A1
        MOVE.B  #14,D0
        TRAP    #15
        RTS       
        
*----------------------------Load Last 12 Bits by 3--------------------------------------------
*Loads the least 12 significant bits from the word A5 is currently pointing to. These are grouped
*by 3 bits and loaded into D2-D5. SR uses RTS.
*The order is:
*Bits 11-9 -> D5
*Bits 8-6 -> D4
*Bits 5-3 -> D2
*Bits 2-0 -> D3
LOAD12BY3
                MOVE.L  #MASK_11_9,D7       ;Mask out bits 11_9 for the destination register
                JSR     APPLYMASK
                MOVE.L  D7,D5               ;Move the dest register for display
               
                MOVE.L  #MASK_8_6,D7        ;Load the mask for opmode
                JSR     APPLYMASK
                MOVE.L  D7,D4               ;Move the opmode for finding attribute (will not be displayed)
                                
                MOVE.L  #MASK_5_3,D7        ;Load the mask for ea mode
                JSR     APPLYMASK
                MOVE.L  D7,D2               ;Move the ea mode for display                
              
                MOVE.L  #MASK_2_0,D7        ;Load the mask for ea register
                JSR     APPLYMASK
                MOVE.L  D7,D3               ;Move the ea register for display
                RTS

*-----------------------------------NOP_EA------------------------------ 
*NOP doesn't actually have an ea but hey you gotta start somewhere
NOP_EA

                   

*------------------------------------ADD EA------------------------------------
ADD_EA
register_msk        EQU     %00001110000000000000000000000000
opmode_msk          EQU     %00000001110000000000000000000000
ea_mode_msk         EQU     %00000000001110000000000000000000
ea_reg_msk          EQU     %00000000000001110000000000000000


                    MOVE.L  #$DA430000,$1600    *Test data corresponds to ADD D3,D5
                    
                    
*---------------------------------CMPA_EA------------------------------------
CMPA_EA
                CLR.B   NUM_EXP_WRDS
                MOVE.B  #2,NUM_OPERANDS           
               
                JSR     LOAD12BY3
*Calculate the number of expansion words
                CMP     #7,D2               ;Source mode determines if expansion words needed
                BLT     cmpa_output          ;Modes less than 7 don't have words
                JSR     INCREMENT_WRD_CNT   ;Mode 7 has at least 1 expansion word
                CMP     #0,D3               ;Look at register
                BEQ     cmpa_output          ;Source register of 0 is short word so already incremented once
                CMP     #1,D3               ;Source register of 4 is imediate data need to look at atribute (opmode)
                BNE     cmpa_op_mod         ;If register is not one (earlier checked 0) then it is 4 which means immediate
                JSR     INCREMENT_WRD_CNT   ;Register 1 means long word add one expansion
                BRA     cmpa_output          ;Thats all folks
cmpa_op_mod     CMP     #2,D3               ;Source register 4 immediate data need to check attribute (opmode)
                BNE     cmpa_output          ;Byte or Word only add a single word already done when we hit mode 7 so done
                JSR     INCREMENT_WRD_CNT   ;Opmode 2 eauals long word so one more expansion
cmpa_output
                *Print opcode
                LEA     CMPA_OP,A1
                MOVE.B  #14,D0
                TRAP    #15
                *Print attribute
                CMP     #3,D4             ;Destination mode (opmode) determines attribute
                BLE     PRINT_BAD         ;No mode below 3 are valid
                CMP     #3,D4               
                BEQ     cmpa_word          ;Mode 3 is equal to word    
                CMP     #7,D4
                BEQ     cmpa_long          ;Mode 7 is equal to long
cmpa_word
                JSR     PRINT_WORD
                BRA     fin_cmpa_ea
                
cmpa_long  
                JSR     PRINT_LONG     
                BRA     fin_cmpa_ea
                
fin_cmpa_ea      
                CLR.L   D4          ;Destination is always a data register
                BRA     PRINT       ;EA completed

                

                    
*---------------------------------CMP_EA-----------------------------------------
*Parse the effective address of a cmp opcode
CMP_EA
                CLR.B   NUM_EXP_WRDS
                MOVE.B  #2,NUM_OPERANDS           
               
                JSR     LOAD12BY3
                
*Calculate the number of expansion words
                CMP     #7,D2               ;Source mode determines if expansion words needed
                BLT     cmp_output          ;Modes less than 7 don't have words
                JSR     INCREMENT_WRD_CNT   ;Mode 7 has at least 1 expansion word
                CMP     #0,D3               ;Look at register
                BEQ     cmp_output          ;Source register of 0 is short word so already incremented once
                CMP     #1,D3               ;Source register of 4 is imediate data need to look at atribute (opmode)
                BNE     cmp_op_mod          ;If register is not one (earlier checked 0) then it is 4 which means immediate
                JSR     INCREMENT_WRD_CNT   ;Register 1 means long word add one expansion
                BRA     cmp_output          ;Thats all folks
cmp_op_mod      CMP     #2,D3               ;Source register 4 immediate data need to check attribute (opmode)
                BNE     cmp_output          ;Byte or Word only add a single word already done when we hit mode 7 so done
                JSR     INCREMENT_WRD_CNT   ;Opmode 2 eauals long word so one more expansion
                
cmp_output
                *Print opcode
                LEA     CMP_OP,A1
                MOVE.B  #14,D0
                TRAP    #15
                *Print attribute
                CMP     #0,D4               ;Destination mode (opmode) determines attribute
                BEQ     cmp_byte          ;Mode 0 is equal to byte
                CMP     #1,D4               
                BEQ     cmp_word          ;MOde 1 is equal to word    
                CMP     #2,D4
                BEQ     cmp_long          ;Mode 2 is equal to long   

cmp_byte      
                JSR     PRINT_BYTE
                BRA     fin_cmp_ea
cmp_word
                JSR     PRINT_WORD
                BRA     fin_cmp_ea
                
cmp_long  
                JSR     PRINT_LONG     
                BRA     fin_cmp_ea
                
fin_cmp_ea      
                CLR.L   D4          ;Destination is always a data register
                BRA     PRINT       ;EA completed
                
*-----------------------------PRINT_BYTE--------------------------------------
*Prints the byte attribute
PRINT_BYTE
                MOVE.B  #14,D0
                LEA     BYTE,A1
                TRAP    #15
                RTS
 
*-------------------------------PRINT_WORD---------------------------------------------------------------
*Prints the word attribute
PRINT_WORD
                MOVE.B  #14,D0
                LEA     WORD,A1
                TRAP    #15
                RTS
                
*------------------------------------PRINT_LONG------------------------------------------------------
*Prints the long attribute
PRINT_LONG  

                MOVE.B  #14,D0
                LEA     LONG,A1
                TRAP    #15
                RTS
                
*-------------------------------EOR_EA---------------------------------------------------------
EOR_EA
                CLR     NUM_EXP_WRDS
                MOVE.B  #2,NUM_OPERANDS     ;Eor always has 2 operands
                
                    
                MOVE.L  #MASK_11_9,D7       ;Load the mask for destination register
                JSR     APPLYMASK
                MOVE.L  D7,D3               ;Move the destination register to be displayed
                   
                MOVE.L  #MASK_8_6,D7        ;Load the mask for opmode register
                JSR     APPLYMASK   
                MOVE.L  D7,D2               ;Move the opmode to be displayed                
                   
                MOVE.L  #MASK_5_3,D7        ;Load the mask for EA mode
                JSR     APPLYMASK
                MOVE.L  D7,D4               ;Move the EA mode to be displayed
                
                MOVE.L  #MASK_2_0,D7        ;Load the mask for EA register
                JSR     APPLYMASK
                MOVE.L  D7,D5               ;Move the EA register to be displayed
                
                *Count Expansion words
                CMP.W   #7,D2               ;Mode 7 has at least one expansion word
                BLT     fin_eor_ea          ;Modes below 7 do not have expansion words
                JSR     INCREMENT_WRD_CNT   ;Mode is 7
                CMP.W   #1,D3               ;Register determines if a second expansion is needed
                BLT     fin_eor_ea          ;Register 0 only has one word
                JSR     INCREMENT_WRD_CNT   ;Register 1 needs a second word                
fin_eor_ea
                

*---------------------------------MOVE_EA----------------------------------
*Parse the effective address of a move opcode
MOVE_EA

                    MOVE.B  #0,NUM_EXP_WRDS            *Zero out number of expansion words
                    MOVE.B  #2,NUM_OPERANDS         ;Move always has 2 operands                    
                    
                    MOVE.L  #MASK_13_12,D7         *Load the mask for size
                    JSR     APPLYMASK
                    MOVE.L  D7,D0                 ;<-------------------------------------------------------------------Need to integrate with I/O now that I have attribute
                  
                    JSR     LOAD12BY3
                    ;MOVE.L  #MASK_11_9,D7          *Load the mask for destination register                  
                    ;JSR     APPLYMASK                  
                    ;MOVE.L  D7,D5                  *Move the finished destination reg in place for display                    
                    
                    ;MOVE.L  #MASK_8_6,D7           *Load the mask destination mode
                    ;JSR     APPLYMASK
                    ;MOVE.L  D7,D4                  *Move the mode for display                  
                    
                    
                    ;MOVE.L  #MASK_5_3,D7           *Load the mask for the source mode
                    ;JSR     APPLYMASK              
                    ;MOVE.L  D7,D2                  *Move the mode for display
                    
                    ;MOVE.L  #MASK_2_0,D7           *Load the mask source register
                    ;JSR     APPLYMASK   
                    ;MOVE.L  D7,D3                  *Move the source reg num for display
                    
*Calculate number of expansion words
                    *Destination side
                    CMP.W   #7,D2                  *Destination modes below 7 do not have expansion words 
                    BLT     src_expansion
                    JSR     INCREMENT_WRD_CNT
                    CMP.W   #1,D1                  *001 in destination register
                    BNE     src_expansion
                    JSR     INCREMENT_WRD_CNT
                    
*Calculate number of expansion words
                    *Source Side
src_expansion       CMP.W   #7,D2                   
                    BLT     fin_move_ea             *Mode less than 7 don't have expansion words
                    JSR     INCREMENT_WRD_CNT       *At lease one more word
                    CMP.W   #1,D3                   *Reg 1 means long word
                    BLT     fin_move_ea             *Reg 0 is single word
                    JSR     INCREMENT_WRD_CNT
                    CMP.W   #4,D5                   *Register 4 indicates immediate data     
                    BNE     fin_move_ea             *If not immediate data then wer're done
                    CMP.W   #2,D0                   *If immediate then look at the size
                    BNE     fin_move_ea             *Less than 2 means a single word and we've already added that
                    JSR     INCREMENT_WRD_CNT       *Size is 2 (cant be greater) so add additonal word 
fin_move_ea         
                    
                                        

*------------------------------------------MOVEA_EA----------------------------------------------------------
MOVEA_EA
                MOVE.B  #0,NUM_EXP_WRDS
                MOVE.B  #2,NUM_OPERANDS             ; MOVEA always has 2 operands
                
                MOVE    #1,D4                       ; MOVEA always has a destination address register
                
                MOVE.L  #MASK_13_12,D7              ; Mask for size
                JSR     APPLYMASK
                MOVE.L  D7,D0                       ; Move for exmpansion wrd and attribute calculations
                
                MOVE.L  #MASK_11_9,D7               ; Mask for destination register
                JSR     APPLYMASK
                MOVE.L  D7,D5                       ; Move for printing
                
                MOVE.L  #MASK_5_3,D7                ; Mask of source mode
                JSR     APPLYMASK
                MOVE.L  D7,D2                       ; Move for printing
                
                MOVE.L  #MASK_2_0,D7                ; Mask of source register
                JSR     APPLYMASK
                MOVE.L  D7,D3                       ; Move for printing                
               
                LEA     MOVEA_OP,A1
                MOVE.B  #14,D0
                TRAP    #15
               
                
                *Calculate the number of expansion words
                CMP.W   #7,D2
                BLT     movea_attribute             ; Source mode less than 7 lack expansion words
                JSR     INCREMENT_WRD_CNT
                
                CMP.W   #0,D3                       ; Source reg determines size of expansion
                BEQ     movea_attribute             ; Source reg 0 has only 1 expansion word
                
                CMP.W   #1,D3                       ; Source reg 1 has second expansion word
                BNE     chk_sreg_4                  ; Need to look at 
                JSR     INCREMENT_WRD_CNT           ; Source Reg 1 has second word
                BRA     movea_attribute             ; No more expansion words
                
                
chk_sreg_4      CMP.W   #4,D3                       ; Source reg 4 with mode 7 is immediate
                BNE     movea_unsupported           ; With source mode 7 supported registers are 0,1,4 only
                CMP.W   #2,D0                       ; Size indicates numb of exp words with immediate
                BNE     movea_word                  ; Size of 3 indicates word so only 1 expansion
                JSR     INCREMENT_WRD_CNT           ; Size of 2 indicates long so need another expansion
                BRA     movea_long          
                

                
                *Calculate attribute
movea_attribute
                CMP.W   #2,D0                       ; Size determines attribute
                BEQ     movea_long                  ; 2 is long
                BRA     movea_word                  ; 3 is word (No check for invalid values)
movea_word      
                JSR     PRINT_WORD
                BRA     fin_movea_ea
movea_long
                JSR     PRINT_LONG
                BRA     fin_movea_ea
              

movea_unsupported
                ; Need to print invalid code here

fin_movea_ea
                BRA     PRINT
        
* EndProgram
*-----------------------------------------------------------
ENDPROGRAM
            END         START            ; last line of source




































































































































































































































































































































































































































































































































































































































































*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

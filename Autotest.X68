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

*ericks testing opcodes
    *CMPI    #1,D0
    *SUBI #1,D0
    *EORI  #1,D0
    *ORI   #1,D0
    *SUBA    D0,A1
    *SUB     D0,D1
    *ADDQ    #1,D1
    *NEG.L   D3<----------Decodes as movem
    *NEG.L   (A5)<----------Decodes as movem

*    NEG.B   D4
*    NEG     D1
*    NEG.W   D2
    NEG.B   $1234
    NEG.W   $1234    
    
    JSR     ENDPROGRAM
    JSR     TESTDATA
    JSR     ENDTESTDATA
    ASL.W   #3,D0
    ROL     #5,D3
    LSL     #3,D0
    ROL     D3,D5
    LSL     D5,D3
    LSL.B   D5,D3
    BHI     TESTJSR    
    *BCC     TESTJSR
    BNE     TESTJSR
    BLT     TESTJSR 
    BHI     TESTJSR 
    LSR.W   D0,D1
    LSL.W   D0,D1
    ROL.W   D0,D1
    ROR.W   D0,D1
    NEG     D0
    NOT     D0
    RTS
    JSR     TESTJSR

    ADD $1234,D2
    ADD D2,$1234

    MULS    D2,D3
    MULS    $1234,D4
    MULS    (A5),D6
    
TESTJSR
    RTS
    
    *LEA     $3243,A3
    *MOVEM   
    AND.B   D1,D2
    MULS.W  D1,D2
    MULS.W  D1,D2

*---------------------Add Variants--------------------

    ADD     D1,D2
    ADD     $1234,D2
    ADD     D2,$1234
    ADD     (A1)+,D2


*----------------------MOVE VARIANTS--------------------------
    MOVE.L    D3,$1650000
    MOVE.B      #255,D6         *Immediate Data
    MOVE.L      #$1234,D6
    MOVE.B      D5,$19001234    *Absolute Long Address
    MOVE.B      D5,$1900        *Absolute Word Address

    MOVE.B      D5,D6           *Data Register Direct
    MOVE.L      A5,A4           *Address Register Direct
    MOVE.B      (A5),D6         *Address Register Indirect
    
    MOVE.B      (A5)+,D6        *Address Register with Postincrement
    MOVE.B      -(A5),D6        *Address Register with Predecrement
    
    
    MOVE.W    D2,A2
   
    MOVE.B    #14,D6
    MOVE.W    #14,D6
    MOVE.L    #1455,D6
    MOVE.L    #1455,A6
    MOVE.L    #145555,D6


 *--------------------BTST VARIANTS-----------------------
    BTST    D3,#1234
    BTST    D7,D2
    BTST    D7,$1600
    BTST    D7,$12345678
    BTST    #12345678,D2
    BTST.L  #$12345678, D2
    BTST    #$12345678, D2
    BTST    #120,D2
    BTST    #128,D2

    CMPA        D3,A2
    CMPA        A2,A4
    CMPA        $1234,A3

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
MASK_7_6            EQU     %00000000110000000000000000000000
MASK_7_0            EQU     %00000000111111110000000000000000
MASK_5_3            EQU     %00000000001110000000000000000000
MASK_2_0            EQU     %00000000000001110000000000000000

    *Attributes
BYTE                DC.B    '.B',HT,0
WORD                DC.B    '.W',HT,0
LONG                DC.B    '.L',HT,0

HEX_MSG             DC.B    'A',0                   ; PLACEHOLDER FOR HEX CONVERSION 
    
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

BAD_MSG1             DC.B        'DATA',HT,0
BAD_MSG2            DC.B        '#wxyz',CR,LF,0

PRINT_BAD           CLR         D2
                    CLR         D3
                    CLR         D4
                    CLR         D5
                    LEA         BAD_MSG1,A1
                    MOVE.B      #14,D0
                    TRAP        #15
                    LEA         BAD_MSG2,A1
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

PRINT_OPREG1        
                    CLR         D1                  ; clear D1
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
                    
*PRINT_OPREG1_L      CLR          D0
*                    CLR          D1
*                    MOVE.B       #8,D0        
*PUSH_LOOP           CMPI.B       #$0,D0
*                    BEQ          HEX_PULL
*                    MOVE.B       D1,D3
*                    LSR.L        #4,D1
*                    ANDI.B       #$F,D3
*                    CMPI.B       #$9,D3
*                    BLT          HEX_NUM
*                    BRA          HEX_ALP
*            
*HEX_NUM             ADDI.B       #$30,D3
*                    BRA          HEX_AGAIN
*HEX_ALP             ADD.B        #$37,D3
*                    BRA          HEX_AGAIN
*HEX_AGAIN           MOVE.B       D3,-(SP)
*                    SUBI.B       #$1,D0
*                    BRA          PUSH_LOOP
*
*HEX_PULL            MOVE.B       #$8,D1
*PULL_LOOP           MOVE.B       (SP)+,HEX_MSG
*                    LEA          HEX_MSG,A1
*                    MOVE.B       #14,D0
*                    TRAP         #15
*                    SUBI.B       #$1,D1
*                    CMPI.B       #$0,D1
*                    BGT          PULL_LOOP
*                    RTS               
                    

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

*------------------------------Begin OpCode-------------------------------------------------------------------------------------------------


; differnt masking bits used in opmode analysis

Bits_15141312  EQU  %1111000000000000

Bits_876       EQU  %0000000111000000

Bits_11109     EQU  %0000111000000000

Bits_987       EQU  %0000001110000000

Bits_43        EQU  %0000000000011000

Bits_54        EQU  %0000000000110000

Bits_8         EQU  %0000000100000000



*------------------------------Configure JMP----------------------------------


*this function is only a little different than the Check functions
*multiplies the number at the end so the jump table move to the correct code
CONFIGURE_JMP    

                 MOVE.W  (A5),D0         ; Copy the current opcode
                
                 AND.W   D3,D0           ; Mask the current Opcode 
                
                 LSR.W   D1,D0           ; Shift over a certain number of bits    
                
                 MULU    #6,D0           ; Multiply by 6 to JMP b/c each JMP is 6 bytes    
                 
                 RTS                     ; return
                 
*------------------------------Configure JMP----------------------------------                 

*each of the below functions masks and then shifts the bits that 
* the function is labeld as
* Example: 11109 masks bits 11,10,9 and then shifts them all the way to the right

*bits are stored as EQU's
                 
Check_11109      JSR     CLEAR_DATA

                 MOVE.W  #Bits_11109,D3                  ;Move the mask into D3
                 
                 MOVE.W  #9,D1                         ;Move the shift amount into D1 
                 
                 MOVE.W  (A5),D0                       ; Copy the current opcode
                
                 AND.W   D3,D0                         ; Mask the current Opcode 
                
                 LSR.W   D1,D0                         ; Shift over a certain number of bits

                 RTS


Check_987        JSR     CLEAR_DATA 

                 MOVE.W  #Bits_987,D3                  ;Move the mask into D3
                 
                 MOVE.W  #7,D1                         ;Move the shift amount into D1 
                 
                 MOVE.W  (A5),D0                       ; Copy the current opcode
                
                 AND.W   D3,D0                         ; Mask the current Opcode 
                
                 LSR.W   D1,D0                         ; Shift over a certain number of bits

                 RTS 
                 
                 
Check_876        JSR     CLEAR_DATA     

                 MOVE.W  #Bits_876,D3                  ;Move the mask into D3
                 
                 MOVE.W  #6,D1                         ;Move the shift amount into D1 
                 
                 MOVE.W  (A5),D0                       ; Copy the current opcode
                
                 AND.W   D3,D0                         ; Mask the current Opcode 
                
                 LSR.W   D1,D0                         ; Shift over a certain number of bits

                 RTS 
                 
                 
Check_43         JSR     CLEAR_DATA     

                 MOVE.W  #Bits_43,D3                  ;Move the mask into D3
                 
                 MOVE.W  #3,D1                         ;Move the shift amount into D1 
                 
                 MOVE.W  (A5),D0                       ; Copy the current opcode
                
                 AND.W   D3,D0                         ; Mask the current Opcode 
                
                 LSR.W   D1,D0                         ; Shift over a certain number of bits

                 RTS 
                 
                 
Check_54         JSR     CLEAR_DATA     

                 MOVE.W  #Bits_54,D3                  ;Move the mask into D3
                 
                 MOVE.W  #4,D1                         ;Move the shift amount into D1 
                 
                 MOVE.W  (A5),D0                       ; Copy the current opcode
                
                 AND.W   D3,D0                         ; Mask the current Opcode 
                
                 LSR.W   D1,D0                         ; Shift over a certain number of bits

                 RTS 
                 
                 
Check_8          JSR     CLEAR_DATA     

                 MOVE.W  #Bits_8,D3                    ;Move the mask into D3
                 
                 MOVE.W  #8,D1                         ;Move the shift amount into D1 
                 
                 MOVE.W  (A5),D0                       ; Copy the current opcode
                
                 AND.W   D3,D0                         ; Mask the current Opcode 
                
                 LSR.W   D1,D0                         ; Shift over a certain number of bits

                 RTS 


*------------------------------Configure JMP----------------------------------


BEGINOPCODE      JSR     CLEAR_DATA              ; Clear all of the Registers
 
                 LEA     jmp_table,A0            ;Load the next JMP table
                 
                 MOVE.W  #Bits_15141312,D3       ;Move the mask into D3
                 
                 MOVE.W  #12,D1                  ;Move the shift amount into D1

                 JSR     CONFIGURE_JMP ;_to hyper space :0    
               
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
  

*starting the the JMP
code0000         JSR     CLEAR_DATA                    ; Clear all of the Registers    

                 LEA     jmp_table_0000_11109 ,A0      ;Next JMP table
                 
                 MOVE.W  #Bits_11109,D3                  ;Move the mask into D3
                 
                 MOVE.W  #9,D1                         ;Move the shift amount into D1

                 JSR     CONFIGURE_JMP ;_to hyper space   
               
                 JMP     0(A0,D0)
                   
jmp_table_0000_11109        JMP code_0000_000

                            JMP code_0000_001

                            JMP code_0000_010

                            JMP code_0000_011

                            JMP code_0000_100

                            JMP code_0000_101

                            JMP code_0000_110

                            JMP code_0000_111
  

          
code_0000_000     JSR   Check_876           ;if btst else ori
                  CMPI  #4,D0
                  BEQ   BTST_EA
                  *BRA  ORI_EA   

code_0000_001     JSR   Check_876           ;if btst else subi
                  CMPI  #4,D0
                  BEQ   BTST_EA
                  *BRA   SUBI_EA 

code_0000_010     JSR   Check_876           ;if btst else unsupported
                  CMPI  #4,D0   
                  BEQ   BTST_EA
                  BRA   PRINT_BAD 

code_0000_011     JSR   Check_876           ;if btst else unsupported
                  CMPI  #4,D0
                  BEQ   BTST_EA
                  BRA   PRINT_BAD 

code_0000_100     BRA   BTST_EA
              
code_0000_101     JSR   Check_876           ;if btst else eori
                  CMPI  #4,D0
                  BEQ   BTST_EA
                  *BRA   EORI_EA 

code_0000_110     JSR   Check_876           ;if btst else cmpi
                  CMPI  #4,D0
                  BEQ   BTST_EA
                  *BRA   CMPI_EA 

code_0000_111     JSR   Check_876           ;if btst else unsupported
                  CMPI  #4,D0
                  BEQ   BTST_EA
                  BRA   PRINT_BAD 
                
*------------------------------------End Bucket 0000---------------------------------



*------------------------------------Begin Bucket 0001-------------------------------
*supported opcodes
*MOVE.B
code0001         BRA        MOVE_EA
*------------------------------------End Bucket 0001---------------------------------



*------------------------------------Begin Bucket 0010-------------------------------
*supported opcodes
*MOVE.L, MOVEA.L
code0010         BRA        MOVE_EA
*------------------------------------End Bucket 0010---------------------------------



*------------------------------------Begin Bucket 0011-------------------------------
*supported opcodes
*MOVE.W, MOVEA.W
code0011         BRA        MOVE_EA
*------------------------------------End Bucket 0011---------------------------------



*------------------------------------Begin Bucket 0100------------------------------- 
* supported opcodes
* MOVEM, NEG, DIVISL, JSR, LEA, MULSL, NOT, RTS

                 
                
code0100         JSR     Check_987          ;check movem and lea first, they are different than the rest
                 CMPI.B  #1, D0             
                 BEQ     MOVEM_EA

                 JSR     Check_876
                 CMPI.B  #7, D0
                 BEQ     LEA_EA 

  

                 JSR     CLEAR_DATA                    ; Clear all of the Registers    

                 LEA     jmp_table_0100_11109 ,A0      ;Next JMP table
                 
                 MOVE.W  #Bits_11109,D3                ;Move the mask into D3
                 
                 MOVE.W  #9,D1                         ;Move the shift amount into D1

                 JSR     CONFIGURE_JMP   
               
                 JMP     0(A0,D0)
                 
                   
jmp_table_0100_11109        JMP code_0100_000

                            JMP code_0100_001

                            JMP code_0100_010

                            JMP code_0100_011

                            JMP code_0100_100

                            JMP code_0100_101

                            JMP code_0100_110
        
                            JMP code_0100_111
  

          
code_0100_000   BRA         PRINT_BAD 

code_0100_001   BRA         PRINT_BAD
     
code_0100_010   BRA         NEG_EA
   
code_0100_011   BRA         NOT_EA
  
code_0100_100   BRA         PRINT_BAD
                  
code_0100_101   BRA         PRINT_BAD 
   
code_0100_110   JSR         Check_876  ;if/else for divis/muls 
                CMPI.B      #1,D0
                *BEQ         DIVIS_EA    
                BRA         MULS_EA        

code_0100_111   JSR         Check_876  ;if/else for jsr/rts
                CMPI.B      #2,D0
                BEQ         JSR_EA   
                BRA         RTS_EA        
 

*------------------------------------End Bucket 0100---------------------------------



*------------------------------------Begin Bucket 0101-------------------------------
*supported opcodes
*ADDQ
code0101        BRA         ADDQ_EA
*------------------------------------End Bucket 0101---------------------------------



*------------------------------------Begin Bucket 0110-------------------------------
*supported opcodes
*BCC, BEQ, BHI, BLT, BNE, BRA

code0110         JSR     CLEAR_DATA                    ; Clear all of the Registers    

                 LEA     jmp_table_0110_11109 ,A0      ;Next JMP table
                 
                 MOVE.W  #Bits_11109,D3                  ;Move the mask into D3
                 
                 MOVE.W  #9,D1                         ;Move the shift amount into D1

                 JSR     CONFIGURE_JMP ;_to hyper space   
               
                 JMP     0(A0,D0)
                   
jmp_table_0110_11109        JMP code_0110_000

                            JMP code_0110_001

                            JMP code_0110_010

                            JMP code_0110_011

                            JMP code_0110_100

                            JMP code_0110_101

                            JMP code_0110_110

                            JMP code_0110_111
  

          
code_0110_000     BRA   BRA_EA

code_0110_001     BRA   BHI_EA

code_0110_010     BRA   PRINT_BAD 

code_0110_011     JSR   Check_8
                  CMPI  #0,D0
                  BEQ   BNE_EA
                  BRA   BEQ_EA 

code_0110_100     BRA   PRINT_BAD
              
code_0110_101     BRA   PRINT_BAD 

code_0110_110     BRA   BLT_EA

code_0110_111     BRA   PRINT_BAD                


*------------------------------------End Bucket 0110---------------------------------



*------------------------------------Begin Bucket 0111-------------------------------
*supported opcodes
*NONE
code0111        BRA         PRINT_BAD
*------------------------------------End Bucket 0111---------------------------------



*------------------------------------Begin Bucket 1000-------------------------------
*supported opcodes
*OR, DIVSW

code1000       JSR          Check_876           ;if/else for or/divs
               CMPI         #7,D0
               BEQ          DIVS_EA
               *BRA          OR_EA

*------------------------------------End Bucket 1000---------------------------------



*------------------------------------Begin Bucket 1001-------------------------------
*supported opcodes
*SUB, SUBA

code1001       JSR          Check_876           ;suba can only be 7 or 3, anything else is sub
               CMPI         #7,D0
               BEQ          SUBA_EA
               
               JSR          Check_876
               CMPI         #3,D0
               BEQ          SUBA_EA
               
               BRA          SUB_EA
*------------------------------------End Bucket 1001---------------------------------



*------------------------------------Begin Bucket 1010-------------------------------
*supported opcodes
*NONE
code1010        BRA      PRINT_BAD
*------------------------------------End Bucket 1010---------------------------------



*------------------------------------Begin Bucket 1011-------------------------------
*supported opcodes
*CMP, CMPA, EOR

code1011         JSR     CLEAR_DATA                    ; Clear all of the Registers    

                 LEA     jmp_table_1011_XXX_876 ,A0    ;Next JMP table
                 
                 MOVE.W  #Bits_876,D3                  ;Move the mask into D3
                 
                 MOVE.W  #6,D1                         ;Move the shift amount into D1

                 JSR     CONFIGURE_JMP   
               
                 JMP     0(A0,D0)
                 
                 
*XXX represents "dont care what those bits are" 
                 
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



*-----------------------------Begin Bucket 1100---------------------------------------
*supported opcodes
*MULSW, AND

code1100       JSR          Check_876           ;if/else for muls/and
               CMPI         #7,D0
               BEQ          MULS_EA
               BRA          AND_EA
               
*-----------------------------End Bucket 1100---------------------------------------



*-----------------------------Begin Bucket 1101-------------------------------------
*supported opcodes
*ADD, ADDA, ADDX
code1101       JSR          Check_43           ;if addx
               CMPI         #0,D0
               *BEQ          ADDX_EA
               
               JSR          Check_876          ;else if adda (adda opmode can be 3 or 7)
               CMPI         #3,D0
               BEQ          ADDA_EA
               
               JSR          Check_876          ;else if adda (adda opmode can be 3 or 7)
               CMPI         #7,D0
               BEQ          ADDA_EA
               
               BRA          ADD_EA             ;else add (anything else is assumed add)

*-----------------------------End Bucket 1101---------------------------------------



*-----------------------------End Bucket 1110---------------------------------------TestTag
*supported opcodes
*LSR, LSL, ROL, ROR

code1110       JSR          Check_43                 
               CMPI         #0,D0           ;if AS R or L memory shift
               BEQ          AS_
               CMPI         #1,D0           ;if LS R or L memory shift
               BEQ          LS_
               CMPI         #3,D0           ;if RO R or L memory shift
               BEQ          RO_
               
               JSR          Check_11109      
               CMPI         #0,D0           ;if AS R or L register shift
               BEQ          AS_
               CMPI         #1,D0           ;if LS R or L register shift
               BEQ          LS_
               CMPI         #3,D0           ;if RO R or L register shift
               BEQ          RO_
 
               BRA          PRINT_BAD        ;anything else is not supported
               
*know that it is LS, check to see if right or left shift               
LS_            JSR          Check_8
               CMPI         #1,D0
               BEQ          LSL_EA
               BRA          LSR_EA


*know that it is RO, check to see if right or left rotate 
RO_            JSR          Check_8
               CMPI         #1,D0
               BEQ          ROL_EA
               BRA          ROR_EA
               
               
*know that it is AS, check to see if right or left rotate 
AS_            JSR          Check_8
               CMPI         #1,D0
               BEQ          ASL_EA
               BRA          ASR_EA

                     
*-----------------------------End Bucket 1110---------------------------------------



*-----------------------------Begin Bucket 1111-------------------------------------
*supported opcodes
*NONE
code1111       BRA      PRINT_BAD

*-----------------------------End Bucket 1111---------------------------------------


*---------------------------------------end opcode-------------------------------------------------------------------------

*-------------------------------------------EA Sub Routines Follow---------------------------------

*-----------------------------PRINT_BYTE--------------------------------------
*Prints the byte attribute
PRINT_BYTE
                MOVE.B  #14,D0
                LEA     BYTE,A1
                TRAP    #15
                BRA     PRINT
 
*-------------------------------PRINT_WORD---------------------------------------------------------------
*Prints the word attribute
PRINT_WORD
                MOVE.B  #14,D0
                LEA     WORD,A1
                TRAP    #15
                BRA     PRINT
                
*------------------------------------PRINT_LONG------------------------------------------------------
*Prints the long attribute
PRINT_LONG  

                MOVE.B  #14,D0
                LEA     LONG,A1
                TRAP    #15
                BRA     PRINT

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
        BNE     msk76
        MOVE    #22,D1
        BRA     shift
msk76   CMP.L   #MASK_7_6,D7
        BNE     msk70
        MOVE    #22,D1
        BRA     shift
msk70   CMP.L   #MASK_7_0,D7
        BNE     msk5
        MOVE    #16,D1
        BRA     shift    
msk5    CMP.L   #MASK_5_3,D7
        BNE     msk2
        MOVE    #19,D1
        BRA     shift      
msk2    CMP.L   #MASK_2_0,D7
        BNE     ENDPROGRAM      ;D7 doesn't match any mask in the global variables
        MOVE    #16,D1
        BRA     shift
        
shift   LSR.L   D1,D0           ;Shift bits to the least sig bit
        MOVE.L  D0,D7           ;Move the data register for display
        
        RTS
        
        
*------------------------------Effective Address with Checks-------------------------------
EAWCHKS
        MOVE.B  #0,NUM_EXP_WRDS
        MOVE.L  A5,A4       ;Make a copy of the opcode pointer
        ADD.L   #2,A4       ;Advance to first expansion word (assumes one exists)
        
        CMP.B   #5,D2       ;D2 holds bits 5-3 EA Mode
        BEQ     PRINT_BAD   ;Mode 5 unsupported
        CMP.B   #6,D2
        BEQ     PRINT_BAD   ;Mode 6 unsupported
        CMP.B   #2,D2       
        BEQ     PRINT_BAD   ;Mode 2 unsupported
        CMP.B   #3,D2
        BEQ     PRINT_BAD   ;Mode 3 unsupported
        
        CMP.B   #7,D2       
        BLT     fin_eachk   ;Modes below 7 don't use expansion words
        
        *Mode 7 is W,L or I need to check register
        CMP     #0,D3       ;D3 holds bits 2-0 EA register
        BEQ     getwordea   ;Single word
        CMP     #1,D3
        BEQ     getlongea   ;Long word
        CMP     #4,D3       ;Signifies immediate data
        BEQ     immediateea
        BRA     PRINT_BAD   ;Other registers with mode 7 are unsupported
        
        
immediateea
        CMP     #2,D6       ;Size data register
        BEQ     getlongea   ;2 indicates long word
        BRA     getwordea   ;1 or 3 use word
        
        
getwordea
        CLR     D3          ;Clear the register before copy expansion word D3 holds register
        MOVE.W  (A4)+,D3
        ADD.B   #1,NUM_EXP_WRDS
        RTS
        
getlongea
        CLR     D3          ;Clear the register before copy expansion word D3 holds register
        MOVE.L  (A4)+,D3
        ADD.B   #2,NUM_EXP_WRDS
        RTS   
        
fin_eachk
        RTS
        
*-------------------------------Multiply and Divide--------------------------------------
MULDIV
        JSR     LOAD12BY3
        JSR     EAWCHKS
        
        CMP     #0,D3       ;D3 holds 8-6 indicates size
        *BEQ     
        
mul_long
        
        RTS
        
        
*-----------------------------Expansion to Operand Arithemitic-----------------------------
*Moves data from the expansion words into operand registers
*D2 operand 1 Opmode
*D3 operand 1 register
*D4 operand 2 mode
*D5 operand 2 register

EXP2OPERAR
        MOVE.B  #0,NUM_EXP_WRDS
        MOVE.L  A5,A4   ;Make a copy of the opcode pointer
        ADD.L   #2,A4   ;Advance to first expansion word (assumes one exists)
        
*chk_unsupported1
*        CMP.B   #5,D2       ;Mode 5-6 are displacement and unsupported
*        BEQ     PRINT_BAD
*        CMP.B   #6,D2
*        BEQ     PRINT_BAD
*        CMP.B   #7,D2    
*        BNE     check_unsupported2
*        CMP.B   #2,D3
*        BEQ     PRINT_BAD
*        CMP.B   #3,D3
*        BEQ     PRINT_BAD
*        BRA     check_unsupported2
        
chk_unsupported2
        CMP.B   #5,D4       ;Mode 5-6 are displacement and unsupported
        BEQ     PRINT_BAD
        CMP.B   #6,D4
        BEQ     PRINT_BAD
        CMP.B   #7,D4    
        BNE     operand1a
        CMP.B   #2,D5       ;Register 2 - 3 are unsupported
        BEQ     PRINT_BAD
        CMP.B   #3,D5
        BEQ     PRINT_BAD
        
operand1a
        CMP.B   #7,D2       ;Look at operand 1 mode
        BLT     operand2a    ;Opcodes below 7 don't use expansion words
        CMP     #0,D3       ;Register 0 is word addressing
        BEQ     getword1a    ;Single word
        CMP     #1,D3
        BEQ     getlong1a   ;Long word
        CMP     #4,D3       ;Signifies immediate data
        BEQ     immediate1a
        
        
immediate1a
        CMP     #2,D6       ;Size data register
        BEQ     getlong1a   ;2 indicates long word
        BRA     getword1a   ;1 or 3 use word
        
immediate2a
        CMP     #2,D6       ;Size data register
        BEQ     getlong2a   ;2 indicates long word
        BRA     getword2a   ;1 or 3 use word        
        
getword1a
        CLR     D3          ;Clear the register before copy expansion word
        MOVE.W  (A4)+,D3
        ADD.B   #1,NUM_EXP_WRDS
        BRA     operand2
        
getlong1a
        CLR     D3          ;Clear the register before copy expansion word
        MOVE.L  (A4)+,D3
        ADD.B   #2,NUM_EXP_WRDS
        BRA     operand2
        
operand2a
        CMP.B   #7,D4       ;Look at operand 1 mode
        BLT     fin_exp     ;Opcodes below 7 don't use expansion words
        CMP     #0,D5       ;Register 0 is word addressing
        BEQ     getword2a   ;Single word
        CMP     #1,D5
        BEQ     getlong2a   ;Long word
        CMP     #4,D5       ;Signifies immediate data
        BEQ     immediate2a
        
getword2a
        CLR     D5          ;Clear the register before copy expansion word
        MOVE.W  (A4)+,D5
        ADD.B   #1,NUM_EXP_WRDS
        BRA     fin_exp
        
getlong2a
        CLR     D5          ;Clear the register before copy expansion word
        MOVE.L  (A4)+,D5
        ADD.B   #2,NUM_EXP_WRDS
        BRA     fin_expa


fin_expa
        RTS
        
*-----------------------------Expansion to Operand-----------------------------
*Moves data from the expansion words into operand registers
*D2 operand 1 mode
*D3 operand 1 register
*D4 operand 2 mode
*D5 operand 2 register

EXP2OPER
        MOVE.B  #0,NUM_EXP_WRDS
        MOVE.L  A5,A4   ;Make a copy of the opcode pointer
        ADD.L   #2,A4   ;Advance to first expansion word (assumes on exists)
        
check_unsupported1
        CMP.B   #5,D2       ;Mode 5-6 are displacement and unsupported
        BEQ     PRINT_BAD
        CMP.B   #6,D2
        BEQ     PRINT_BAD
        CMP.B   #7,D2    
        BNE     check_unsupported2
        CMP.B   #2,D3
        BEQ     PRINT_BAD
        CMP.B   #3,D3
        BEQ     PRINT_BAD
        BRA     check_unsupported2
        
check_unsupported2
        CMP.B   #5,D4       ;Mode 5-6 are displacement and unsupported
        BEQ     PRINT_BAD
        CMP.B   #6,D4
        BEQ     PRINT_BAD
        CMP.B   #7,D4    
        BNE     operand1
        CMP.B   #2,D5       ;Register 2 - 3 are unsupported
        BEQ     PRINT_BAD
        CMP.B   #3,D5
        BEQ     PRINT_BAD
        
operand1
        CMP.B   #7,D2       ;Look at operand 1 mode
        BLT     operand2    ;Opcodes below 7 don't use expansion words
        CMP     #0,D3       ;Register 0 is word addressing
        BEQ     getword1    ;Single word
        CMP     #1,D3
        BEQ     getlong1    ;Long word
        CMP     #4,D3       ;Signifies immediate data
        BEQ     immediate1
        
        
immediate1
        CMP     #2,D6       ;Size data register
        BEQ     getlong1    ;2 indicates long word
        BRA     getword1    ;1 or 3 use word
        
immediate2
        CMP     #2,D6       ;Size data register
        BEQ     getlong2    ;2 indicates long word
        BRA     getword2    ;1 or 3 use word        
        
getword1
        CLR     D3          ;Clear the register before copy expansion word
        MOVE.W  (A4)+,D3
        ADD.B   #1,NUM_EXP_WRDS
        BRA     operand2
        
getlong1
        CLR     D3          ;Clear the register before copy expansion word
        MOVE.L  (A4)+,D3
        ADD.B   #2,NUM_EXP_WRDS
        BRA     operand2
        
operand2
        CMP.B   #7,D4       ;Look at operand 1 mode
        BLT     fin_exp     ;Opcodes below 7 don't use expansion words
        CMP     #0,D5       ;Register 0 is word addressing
        BEQ     getword2    ;Single word
        CMP     #1,D5
        BEQ     getlong2    ;Long word
        CMP     #4,D5       ;Signifies immediate data
        BEQ     immediate2
        
getword2
        CLR     D5          ;Clear the register before copy expansion word
        MOVE.W  (A4)+,D5
        ADD.B   #1,NUM_EXP_WRDS
        BRA     fin_exp
        
getlong2
        CLR     D5          ;Clear the register before copy expansion word
        MOVE.L  (A4)+,D5
        ADD.B   #2,NUM_EXP_WRDS
        BRA     fin_exp


fin_exp
        RTS   
        
 
       
        
*----------------------------Load Last 12 Bits by 3--------------------------------------------
*Loads the least 12 significant bits from the word A5 is currently pointing at. These are grouped
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

*------------------------------------ADD_EA------------------------------------
ADD_EA
        MOVE.B  #2,NUM_OPERANDS
        JSR     LOAD12BY3
        JSR     EXP2OPERAR
        
        LEA     ADD_OP,A1
        MOVE    #14,D0
        TRAP    #15
        
        BRA     PRINT_BYTE
        
        
        
*-----------------------------------ADDA_EA-------------------------------------
ADDA_EA
        LEA     ADDA_OP,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        MOVE.B  #0,NUM_EXP_WRDS
        BRA PRINT
  
*-------------------------------------ADDQ_EA-----------------------------------
ADDQ_EA
        LEA     ADDQ_OP,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        MOVE.B  #0,NUM_EXP_WRDS
        BRA PRINT
        
*---------------------------AND_EA------------------------------------
AND_EA
        LEA     AND_OP,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        MOVE.B  #0,NUM_EXP_WRDS
        BRA PRINT
*---------------------------Shift Common-----------------------------
SHIFTCOM
*Bits 11-9 -> D5
*Bits 8-6 -> D4
*Bits 5-3 -> D2
*Bits 2-0 -> D3
        JSR     LOAD12BY3           ;Split opcode into registers (only a few are used here)
        MOVE.L  MASK_7_6,D7         ;Field indicates location of data, register or memory
        ANDI.L  #$00C00000,D7       ;Work around the sign extension
        JSR     APPLYMASK           
        MOVE.L  D7,D6               ;D6 now holds "location"/size field
        CMP.B   #3,D6               ;Size can be 0-2
        BEQ     memory_shifts       ;3 indicates memory shift        
        
register_shifts
        MOVE.B  #0,NUM_EXP_WRDS
        MOVE.B  #2,NUM_OPERANDS
        *Operand values are reverse order from what 12 by 3 returns (swap d3 and d5)
        MOVE.L  D3,D2               ;Make a copy of operand 2(d3) value
        MOVE.L  D5,D3               ;Operand 1 now in correct position
        MOVE.L  D2,D5               ;Operand 2 now in correct posision
        MOVE.L  #0,D4               ;Operand 2 mode         
        
        MOVE.W  (A5),D0             ;Get a copy of the opcode to test 
        BTST    #5,D0               ;5th bit is i/r field
        BEQ     shift_field         ;0 indicates shift count in count/reg
        BRA     shift_dreg          ;1 indcates data register in count/reg

shift_field
        MOVE.L  #7,D2               ;Operand 1 mode
        RTS
        
shift_dreg
        MOVE.L  #0,D2               ;Operand 1 mode
        RTS
        
memory_shifts
        MOVE.B  #1,NUM_OPERANDS
        MOVE.B  #2,NUM_EXP_WRDS
        MOVE.L  D4,D2               ;EA mode is first operand in this situation
        MOVE.L  (2,A5),D3           ;Displacement is always a long word
        MOVE.L  #2,D6               ;D6 will hold the size 0 = byte, 1 = word, 2 = long
        RTS
        
        
*---------------------------ASL_EA------------------------------------
ASL_EA
        JSR     SHIFTCOM
        
        LEA     ASL_OP,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        CMP.B   #0,D6
        BEQ     PRINT_BYTE
        CMP.B   #1,D6
        BEQ     PRINT_WORD
        CMP.B   #2,D6
        BEQ     PRINT_LONG
        BRA     ENDPROGRAM      ;In case something went wrong

        
*---------------------------ASR_EA------------------------------------
ASR_EA
        JSR     SHIFTCOM
        
        LEA     MULS_OP,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        CMP.B   #0,D6
        BEQ     PRINT_BYTE
        CMP.B   #1,D6
        BEQ     PRINT_WORD
        CMP.B   #2,D6
        BEQ     PRINT_LONG
        BRA     ENDPROGRAM      ;In case something went wrong

        
*---------------------Bcc Common-------------------------------------
BCCCOM
    MOVE        A5,A4               ;Make a copy of opcode pointer
    ADD         #2,A4               ;Point to first expansion word (assume it exists)
    MOVE.B      #1,NUM_OPERANDS     ;One operand corresponds to displacement
    MOVE.B      #7,D2               ;Set the first operand to display hex
    MOVE.L      MASK_7_0,D7         ;Last 8 bits determine length of displacement
    ANDI.L      #$00FF0000,D7       ;Work around the sign extension
    JSR         APPLYMASK
    CMP.B       #$00,D7             ;D7 holds last 8 bits
    BEQ         bcc1                ;0 indicates word displacement
    CMP.B       #$FF,D7             ;D7 holds displacement bits
    BEQ         bcc2                ;FF indicates long word displacement
    BRA         bcc0                ;Any other value is the actual displacement
    
bcc0
    MOVE.B      D7,D3               ;Displacement less than 8 bits 
    MOVE.B      #0,NUM_EXP_WRDS
    BRA         PRINT_WORD
    
bcc1
    MOVE.W      (A4),D3
    MOVE.B      #1,NUM_EXP_WRDS
    BRA         PRINT_WORD
    
bcc2    
    MOVE.L      #2,NUM_EXP_WRDS
    MOVE.W      (A4),D3
    BRA         PRINT_LONG

        
*---------------------------BEQ_EA------------------------------------
BEQ_EA
        
        LEA     BEQ_OP,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        BRA     BCCCOM
        
*---------------------------BLT_EA------------------------------------
BLT_EA

        LEA     BLT_OP,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        BRA     BCCCOM        
        
*---------------------------BNE_EA------------------------------------
BNE_EA

        LEA     BNE_OP,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        BRA     BCCCOM
        
*---------------------------BHI_EA------------------------------------
BHI_EA

        LEA     BHI_OP,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        BRA     BCCCOM
*---------------------------BRA_EA------------------------------------
BRA_EA

        LEA     BRA_OP,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        BRA     BCCCOM

*------------------------------BTST_EA-------------------------------------------
BTST_EA

        MOVE.B  #0,NUM_EXP_WRDS
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
        
        CMP.B   #4,D2           ;4 indicates BIT NUMBER DYNAMIC
        BNE     btst_im         ;Immediate if not 4 (assume 0)
        
*Dynamic
        
        MOVE.L  #MASK_11_9,D7   ;Mask for destination register
        JSR     APPLYMASK
        MOVE.L  D7,D3           ;Move register for display
        
        CLR     D2              
        MOVE.B  #0,D2           ;Dynamic always uses data register
        
        CMP.B   #7,D4           ;D4 should be EA Mode
        BLT     btst_lss7       ;Modes less than 7
        *Mode = 7
        JSR     INCREMENT_WRD_CNT ;Mode 7 has at least 1 expansion word
        CMP.B   #0,D5           ;Look at EA Register
        BEQ     PRINT_BYTE      ;EA Register 0 has only one expansion word and byte attribute
        CMP.B   #4,D5           ;Look at EA Register
        BEQ     PRINT_BYTE      ;EA Register 4 also has only one expansion word and byte attribute
        CMP.B   #1,D5           ;Look at EA Register
        BNE     btst_bad        ;INVAID
        JSR     INCREMENT_WRD_CNT ;Ea register 1 indicates long attribute with 2 expansion words
        BRA     PRINT_LONG                         
        
btst_lss7
        CMP.B   #0,D4           ;Only supported modes are 0,2-4
        BEQ     PRINT_BYTE      ;Data register is the only long attribute
        CMP.B   #4,D4           ;Only supported modes are 0,2-4
        BGT     btst_bad        ;Unsupported address mode
        BRA     PRINT_BYTE      ;EA Modes 2-4 are all byte sized                
        
btst_bad    
        BRA     PRINT_BAD
        
        
btst_im
        MOVE.B  #5,D2           ;First operand mode is immediate
        MOVE.B  #2,NUM_EXP_WRDS ;Immediate btst always has 2 words
        MOVE.L  A5,D0           ;Move the first operator from the expansion word
        ADDI.L  #2,D0
        MOVE.L  D0,A4
        MOVE.W (A4),D3
        BSR     print_btst      ;Print the opcode
        BRA     PRINT_LONG      ;Immediate is always long        
        
print_btst
        *Print opcode
        LEA     BTST_OP,A1
        MOVE.B  #14,D0
        TRAP    #15
        RTS
        
*---------------------------------CMP_EA-----------------------------------------
*Parse the effective address of a cmp opcode
CMP_EA
                MOVE.B  #0,NUM_EXP_WRDS
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
                
                MOVE.L  D4,D6               ;D6 holds the size
                CLR.L   D4                  ;Destination is always a data register
                *Print attribute
                CMP     #0,D6               ;Destination mode (opmode) determines attribute
                BEQ     PRINT_BYTE          ;Mode 0 is equal to byte
                CMP     #1,D6               
                BEQ     PRINT_WORD          ;MOde 1 is equal to word    
                CMP     #2,D6
                BEQ     PRINT_LONG          ;Mode 2 is equal to long
                    
                    
*---------------------------------CMPA_EA------------------------------------
CMPA_EA
                MOVE.B  #0,NUM_EXP_WRDS
                MOVE.B  #2,NUM_OPERANDS           
               
                JSR     LOAD12BY3
*Calculate the number of expansion words
                CMP     #7,D2               ;Source mode determines if expansion words needed
                BLT     cmpa_output         ;Modes less than 7 don't have words
                JSR     INCREMENT_WRD_CNT   ;Mode 7 has at least 1 expansion word
                CMP     #0,D3               ;Look at register
                BEQ     cmpa_output         ;Source register of 0 is short word so already incremented once
                CMP     #1,D3               ;Source register of 4 is imediate data need to look at atribute (opmode)
                BNE     cmpa_op_mod         ;If register is not one (earlier checked 0) then it is 4 which means immediate
                JSR     INCREMENT_WRD_CNT   ;Register 1 means long word add one expansion
                BRA     cmpa_output         ;Thats all folks
cmpa_op_mod     CMP     #2,D3               ;Source register 4 immediate data need to check attribute (opmode)
                BNE     cmpa_output         ;Byte or Word only add a single word already done when we hit mode 7 so done
                JSR     INCREMENT_WRD_CNT   ;Opmode 2 eauals long word so one more expansion
cmpa_output
                *Print opcode
                LEA     CMPA_OP,A1
                MOVE.B  #14,D0
                TRAP    #15
                
                MOVE.L  D4,D1               ;D1 will determine size
                MOVE.L  #1,D4               ;Destination is always an address register
                *Print attribute
                CMP     #3,D1               ;Destination mode (opmode) determines attribute
                BLT     PRINT_BAD           ;No mode below 3 are valid
                CMP     #3,D1               
                BEQ     PRINT_WORD          ;Mode 3 is equal to word    
                CMP     #7,D1
                BEQ     PRINT_LONG          ;Mode 7 is equal to long
                    
                
*------------------------------------CMPI_EA--------------------------------------
CMPI_EA
                MOVE.B  #1,NUM_EXP_WRDS     ;CMPI always includes at least 1 word
                MOVE.B  #2,NUM_OPERANDS     
                
                MOVE.L  MASK_7_6,D7         ;Mask for size
                JSR     APPLYMASK
                MOVE.L  D7,D6               ;Hold on to size for comparrison
                
                MOVE.L  MASK_5_3,D7         ;EA mode (operand 2)
                JSR     APPLYMASK
                MOVE.L  D7,D4               ;Move ea mode for display
                
                MOVE.L  MASK_2_0,D7         ;Mask for ea register
                JSR     APPLYMASK
                MOVE.L  D7,D5               ;Move ea register for display
                BRA     PRINT
                
*---------------------------DIVS_EA------------------------------------
DIVS_EA

        LEA     DIVS_OP,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        MOVE.B  #0,NUM_EXP_WRDS
        BRA PRINT              
                
                
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
                BRA     PRINT
                
*---------------------------EORI_EA------------------------------------
EORI_EA

        LEA     EORI_OP,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        MOVE.B  #0,NUM_EXP_WRDS
        BRA PRINT
        
*---------------------------JSR_EA------------------------------------
JSR_EA
        MOVE.B  #1,NUM_OPERANDS
        MOVE.B  #1,NUM_EXP_WRDS ;May be overwritten later
        
        LEA     JSR_OP,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        JSR     LOAD12BY3       ;Split word into data registers (only need d2 and d3)
                
        CMP.W   #5,D2           ;D2 is the ea mode
        BEQ     PRINT_BAD       ;Unsupported displacement
        CMP.W   #6,D2           ;D2 is the ea mode
        BEQ     PRINT_BAD       ;Unsupported displacement
        CMP.W   #7,D2           ;D2 is the ea mode
        BLT     jsr_operand     ;Must be mode 2
        CMP.W   #2,D3           ;D3 is register
        BGE     PRINT_BAD       ;Register 2 and up are unsupported
        CMP.W   #0,D3           ;D3 is register #
        BEQ     jsr_operand     ;Register 0 is word addressing
        MOVE.B  #2,NUM_EXP_WRDS ;2 words for long addressing
        BRA     jsr_operand
        
jsr_operand
        MOVE.L  A5,A4   ;Make a copy of the opcode pointer
        ADD.L   #2,A4   ;Advance to first expansion word (assumes on exists)
        CMP.B   #1,NUM_EXP_WRDS
        BGT     jsr_2
        MOVE.W  (A4),D3
        BRA     PRINT
        
jsr_2   MOVE.L  (A4),D3
        BRA     PRINT
     
 
  

                
*---------------------------LEA_EA------------------------------------
LEA_EA

        LEA     LEA_OP,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        MOVE.B  #0,NUM_EXP_WRDS
        BRA PRINT
        
*---------------------------LSL_EA------------------------------------
LSL_EA
        JSR     SHIFTCOM
        LEA     LSL_OP,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        CMP.B   #0,D6
        BEQ     PRINT_BYTE
        CMP.B   #1,D6
        BEQ     PRINT_WORD
        CMP.B   #2,D6
        BEQ     PRINT_LONG
        BRA     ENDPROGRAM
        
        
*---------------------------LSR_EA------------------------------------
LSR_EA
        JSR     SHIFTCOM
        LEA     LSR_OP,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        CMP.B   #0,D6
        BEQ     PRINT_BYTE
        CMP.B   #1,D6
        BEQ     PRINT_WORD
        CMP.B   #2,D6
        BEQ     PRINT_LONG
        BRA     ENDPROGRAM
                

*---------------------------------MOVE_EA----------------------------------
*Parse the effective address of a move opcode
MOVE_EA

                    MOVE.B  #0,NUM_EXP_WRDS            *Zero out number of expansion words
                    MOVE.B  #2,NUM_OPERANDS         ;Move always has 2 operands                    
                    
                    MOVE.L  #MASK_13_12,D7         *Load the mask for size
                    JSR     APPLYMASK
                    MOVE.L  D7,D6                
                  
                    JSR     LOAD12BY3
                    JSR     EXP2OPER      
 
move_attribute                    
                    LEA     MOVE_OP,A1
                    MOVE.B  #14,D0
                    TRAP    #15                   
                    
                    
                    *Calculate attribute
                    CMP.W   #1,D6                      ; 1 is byte
                    BEQ     PRINT_BYTE
                    CMP.W   #2,D6                      ; Size determines attribute
                    BEQ     PRINT_LONG                 ; 2 is long
                    BRA     PRINT_WORD                  ; 3 is word (No check for invalid values)    

*------------------------------------------MOVEA_EA----------------------------------------------------------
MOVEA_EA
                MOVE.B  #0,NUM_EXP_WRDS
                MOVE.B  #2,NUM_OPERANDS             ; MOVEA always has 2 operands
                
                MOVE    #1,D4                       ; MOVEA always has a destination address register
                
                MOVE.L  #MASK_13_12,D7              ; Mask for size
                JSR     APPLYMASK
                MOVE.L  D7,D0                       ; Move for exmpansion wrd and attribute calculations
                
                JSR     LOAD12BY3

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
                BNE     PRINT_WORD                  ; Size of 3 indicates word so only 1 expansion
                JSR     INCREMENT_WRD_CNT           ; Size of 2 indicates long so need another expansion
                BRA     PRINT_LONG          
                

                
                *Calculate attribute
movea_attribute
                CMP.W   #2,D0                       ; Size determines attribute
                BEQ     PRINT_LONG                  ; 2 is long
                BRA     PRINT_WORD                  ; 3 is word (No check for invalid values)

              

movea_unsupported
                BRA     PRINT_BAD
        
*---------------------------------MOVEM_EA--------------------------
MOVEM_EA
        LEA     MOVEM_OP,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        MOVE.B  #0,NUM_EXP_WRDS
        BRA PRINT
        
*---------------------------MULS_EA------------------------------------
MULS_EA
        
        JSR     MULDIV
        
        LEA     MULS_OP,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        *
        CMP.B   #7,D4       ;D4 Holds bits 8-6
        BEQ     PRINT_BYTE
        CMP.B   #0,D4
        BEQ     PRINT_BYTE
        
        
      
        
*---------------------------NEG_EA------------------------------------
NEG_EA
        MOVE.B  #0,NUM_EXP_WRDS
        MOVE.B  #1,NUM_OPERANDS ;Neg always has a single operand
        JSR     LOAD12BY3
        *MOVE.L  D2,D4           ;Only one operand with neg need to move
        *MOVE.L  D3,D5           ;What 12by3 calls operand 2 to operand 1
        JSR     EAWCHKS       
        
        LEA     NEG_OP,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        MOVE.L  MASK_7_6,D7
        ANDI.L  #$00C00000,D7   ;Work around the sign extension   
        JSR     APPLYMASK       ;Size is in D7
        
        CMP.B   #0,D7           ;Check for size
        BEQ     PRINT_BYTE
        CMP.B   #1,D7           
        BEQ     PRINT_WORD
        CMP.B   #2,D7
        BEQ     PRINT_LONG     
       
        
*---------------------------NOT_EA------------------------------------
NOT_EA
        MOVE.B  #0,NUM_EXP_WRDS
        MOVE.B  #1,NUM_OPERANDS ;Not always has a single operand
        JSR     LOAD12BY3
        MOVE.L  D2,D4           ;Only one operand with neg need to move
        MOVE.L  D3,D5           ;What 12by3 calls operand 2 to operand 1
        JSR     EAWCHKS

        LEA     NOT_OP,A1
        MOVE.B  #14,D0
        TRAP    #15
        
         MOVE.L  MASK_7_6,D7
        ANDI.L  #$00C00000,D7   ;Work around the sign extension   
        JSR     APPLYMASK       ;Size is in D7
        
        CMP.B   #0,D7           ;Check for size
        BEQ     PRINT_BYTE
        CMP.B   #1,D7           
        BEQ     PRINT_WORD
        CMP.B   #2,D7
        BEQ     PRINT_LONG
        
*---------------------------ORI_EA------------------------------------
ORI_EA

        LEA     ORI_OP,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        MOVE.B  #0,NUM_EXP_WRDS
        BRA PRINT
        
*---------------------------ROL_EA------------------------------------
ROL_EA
        JSR     SHIFTCOM

        LEA     ROL_OP,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        CMP.B   #0,D6
        BEQ     PRINT_BYTE
        CMP.B   #1,D6
        BEQ     PRINT_WORD
        CMP.B   #2,D6
        BEQ     PRINT_LONG
        BRA     ENDPROGRAM

        
*---------------------------ROR_EA------------------------------------
ROR_EA
        JSR     SHIFTCOM
        
        LEA     ROR_OP,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        CMP.B   #0,D6
        BEQ     PRINT_BYTE
        CMP.B   #1,D6
        BEQ     PRINT_WORD
        CMP.B   #2,D6
        BEQ     PRINT_LONG
        BRA     ENDPROGRAM

        
*---------------------------RTS_EA------------------------------------
RTS_EA
        LEA     RTS_OP,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        MOVE.B  #0,NUM_EXP_WRDS
        MOVE.B  #0,NUM_OPERANDS
        BRA PRINT 
        
*-------------------------------SUB_EA-------------------------------
SUB_EA

        LEA     SUB_OP,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        MOVE.B  #0,NUM_EXP_WRDS
        BRA PRINT
        
*-----------------------------SUBA_EA---------------------------------
SUBA_EA

        LEA     SUBA_OP,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        MOVE.B  #0,NUM_EXP_WRDS
        BRA PRINT
        
*---------------------------SUBI_EA------------------------------------
SUBI_EA
        LEA     SUBI_OP,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        MOVE.B  #0,NUM_EXP_WRDS
        BRA PRINT



*-------------------End Program--------------------------------------
ENDPROGRAM
            END         START            ; last line of source



















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

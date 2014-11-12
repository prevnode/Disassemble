*-----------------------------------------------------------
* Title      :  DISSEMBLER PROTOTYPE I/O
* Written by :  BRANDAN HAERTEL, ERICK HOUSE, GARY MIXSON
* Date       :  10/5/2014
* Description:  SPLASH SCREEN AND SIMPLE LOOP THROUGH 10
*               10 MEMORY LOCATIONS
*-----------------------------------------------------------
    
START:      ORG         $1000            ; first instruction of program

* Put program code here
*-----------------------------------------------------------
MAIN        
            LEA         SPLASH,A1           ; put the GETSRTHEX message into A1
            MOVE        #14,D0              ; trap task #14 to print the message to screen
            TRAP        #15                 ; trap #15 I/O

* StartHex
* prompt the user for a starting address in hex
* this does not error check!
*-----------------------------------------------------------
STARTHEX
            LEA         GETSRTHEX,A1        ; put the GETSRTHEX message into A1
            MOVE.B      #14,D0              ; trap task #14 to print the message to screen
            TRAP        #15                 ; trap #15 I/O
            
            MOVE.B      #2,D0               ; read a string in from the keyboard
            TRAP        #15                 ; trap #15 I/O
            
            MOVE.L      A1,$6000            ; store the starting address in D2
            JSR         ASCIITOHEX          ; convert string to hex address
            BRA         ENDHEX

* EndHex
* prompt the user for a ending address in hex
* this does not error check!
*-----------------------------------------------------------
ENDHEX
            LEA         GETENDHEX,A1        ; put the GETENDHEX message into A1
            MOVE.B      #14,D0              ; trap task #14 to print the message to screen
            TRAP        #15                 ; trap #15 I/O
            
            MOVE.B      #2,D0               ; read a string in from the keyboard
            TRAP        #15                 ; trap #15 I/O

            MOVE.L      A1,$600A            ; store the starting address in D6
            JSR         ASCIITOHEX          ; convert the string to hex address
            BRA         PROMPTRUNAGAIN      
            
            *CLR         A1                  ; clear A1

* PromptRunAgain
* ask to run the program again, if Y then call MAIN
* if N then END program
*-----------------------------------------------------------
PROMPTRUNAGAIN     
            LEA         RUNAGAIN,A1         ; put message into A1
            MOVE        #14,D0              ; trap task #14 to print the message to screen
            TRAP        #15                 ; trap #15 I/O
            
            MOVE.B      #2,D0               ; trap task 5 grabs a single character
            TRAP        #15                 ; trap #15 I/O
            CMP.L       #$59,D1             ; compare Y to D1
            BEQ         START               ; brach to Reset if D1 == Y
            
            CMP.B       #$79,D1             ; compare y to D1
            BEQ         START               ; brach to Reset if D1 == y
            BRA         ENDPROGRAM          ; else branch to end

* Reset
* prep the program to run again
*-----------------------------------------------------------
RESET
            MOVE.B      #11,D0              ; clear the screen
            MOVE.W      #$FF00,D1           ; clear the screen
            TRAP        #15                 ; send trap task command
            
            CLR         D0                  ; clear the data register
            CLR         D1                  ; clear the data register
            CLR         D2                  ; clear the data register
            CLR         D3                  ; clear the data register
            CLR         D4                  ; clear the data register
            CLR         D5                  ; clear the data register
            CLR         D6                  ; clear the data register
            CLR         D7                  ; clear the data register
            
            SUBA.L      A0,A0               ; clear the acess register
            SUBA.L      A1,A1               ; clear the acess register
            SUBA.L      A2,A2               ; clear the acess register
            SUBA.L      A3,A3               ; clear the acess register
            SUBA.L      A4,A4               ; clear the acess register
            SUBA.L      A5,A5               ; clear the acess register
            SUBA.L      A6,A6               ; clear the acess register

            BRA         START               ; branch back to start
            
* AsciiToHex
* turn the ascii letter in A1 to hex
* result to added to D6
*-----------------------------------------------------------
ASCIITOHEX
            LEA         EXEASCII,A1         ; put message into A1
            MOVE        #14,D0              ; trap task #14 to print the message to screen
            TRAP        #15                 ; trap #15 I/O

ASCIITOHEXQUIT
            RTS                             ; return back

* Put variables and constants here
*-----------------------------------------------------------
CR          EQU         $0D                 ; Carriage Return
LF          EQU         $0A                 ; Line Feed
BS          EQU         $08                 ; Backspace
HT          EQU         $09                 ; Tab (horizontal 5 characters)
LF          EQU         $0A                  ;New line (line feed)
VT          EQU         $0B                  ;Vertical tab (4 lines)
FF          EQU         $0C                 ; Form Feed (Always end printing with a Form Feed.)
NUM_EXP_WRDS    DC.B    0                   ; Number of expansion words after the opcode

* Main Splash Screen to be displayed at begining of program
*-----------------------------------------------------------
SPLASH      DC.B        '        ____ ___  __ __                        ',CR,LF
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

GETSRTHEX   DC.B        'Enter Starting Hex Address Of Program: ',CR,LF,0
GETENDHEX   DC.B        'Enter Ending Hex Address Of Program: ',CR,LF,0
RUNAGAIN    DC.B        'Would You Like To Dissasmble Anouther Program? (Y/N): ',CR,LF,0
CONFIRMSRT  DC.B        'Starting address is stored',CR,LF,0
CONFIRMEND  DC.B        'Ending address is stored',CR,LF,0
EXEASCII    DC.B        'Executing ASCII',CR,LF,0

*----------------------------------------------Increment Expansion Word Count-----------------------------------------
INCREMENT_WRD_CNT       
                    ADD     #1,NUM_EXP_WRDS
                    RTS
                    
*-----------------------------Invalid Opcode---------------------------
*Used when the word read in is garbage/unsupported opcode/invalid ea 
invalid_opcode

inv_mem     DC.B    '1000'
inv_code    DC.B    'DATA'
inv_operand DC.B    '$WXYZ'

            MOVE.L  inv_mem,A1
            MOVE.L  inv_code,A2
            MOVE.L  inv_operand,A3
            RTS


*-----------------------------------NOP_EA------------------------------ 
*NOP doesn't actually have an ea but hey you gotta start somewhere
nop_ea

nop_str     DC.B    'NOP'

            MOVE.L  nop_str,A1

            RTS

*------------------------------------ADD EA------------------------------------
add_ea
register_msk        EQU     %00001110000000000000000000000000
opmode_msk          EQU     %00000001110000000000000000000000
ea_mode_msk         EQU     %00000000001110000000000000000000
ea_reg_msk          EQU     %00000000000001110000000000000000

                    MOVE.L  #$DA430000,$1600    *Test data corresponds to ADD D3,D5
                    


*---------------------------------MOVE_EA----------------------------------
*Parse the effective address of a move opcode
move_ea
move_str            DC.B    'MOVE'
size_msk            EQU     %00110000000000000000000000000000
destin_reg_msk      EQU     %00001110000000000000000000000000
destin_mod_msk      EQU     %00000001110000000000000000000000
source_mod_msk      EQU     %00000000001110000000000000000000
source_reg_msk      EQU     %00000000000001110000000000000000

                    CLR     NUM_EXP_WRDS         *Zero out number of expansion words
                    *JSR     INCREMENT_WRD_CNT                

                    *MOVE.L  #$1C050000,$1600       *Test data that corresponds to MOVE.B D5,D6
                    *MOVE.L  #$1C381400,$1600       *Test data corresponds to  MOVE.B    $1400,D6
                    MOVE.L  #$23C30165,$1600         *Test data corresponds to MOVE.L D3,$16500000
                    MOVE.W  #0000,$1604              *Completes test data
                    
                    MOVE.L  $1600,$1610            *Make a copy
                    MOVE.L  #size_msk,D7           *Load the mask
                    AND.L   D7,$1610               *Apply the mask to the copy
                    MOVE.L  $1610,D7               *Move the remaining bits into a reg to be shifted
                    MOVE.L  #28,D6                 *Lots of bits to shift
                    LSR.L   D6,D7                  *Shift bits to the LSB
                    MOVE.L  D7,D0                  *Move the size for display
                  
                    MOVE.L  $1600,$1610            *Make a copy
                    MOVE.L  #destin_reg_msk,D7     *Load the mask                   
                    AND.L   D7,$1610               *Apply the mask to the copy
                    MOVE.L  $1610,D7               *Move the remaining bits into a register to be shifted
                    MOVE.L  #25,D6                 *Going to shift a lot of bits
                    LSR.L   D6,D7                  *Move the bits to the LSB                    
                    MOVE.L  D7,D1                  *Move the finished destination reg in place for display                    
                    
                    MOVE.L  $1600,$1610            *Make a copy
                    MOVE.L  #destin_mod_msk,D7     *Load the mask
                    AND.L   D7,$1610               *Apply the mask to the copy
                    MOVE.L  $1610,D7               *Move the remaining bits into a reg to be shifted
                    MOVE.L  #22,D6                 *Lots of bits to shift
                    LSR.L   D6,D7                  *Shift bits to the LSB
                    MOVE.L  D7,D2                  *Move the mode for display                  
                    
                    MOVE.L  $1600,$1610            *Make a copy
                    MOVE.L  #source_mod_msk,D7     *Load the mask
                    AND.L   D7,$1610               *Apply the mask to the copy
                    MOVE.L  $1610,D7               *Move the remaining bits into a reg to be shifted
                    MOVE.L  #19,D6                 *Lots of bits to shift
                    LSR.L   D6,D7                  *Shift bits to the LSB
                    MOVE.L  D7,D3                  *Move the mode for display
                    
                    MOVE.L  $1600,$1610            *Make a copy
                    MOVE.L  #source_reg_msk,D7     *Load the mask
                    AND.L   D7,$1610               *Apply the mask to the copy
                    MOVE.L  $1610,D7               *Move the remaining bits into a reg to be shifted
                    MOVE.L  #16,D6                 *Lots of bits to shift
                    LSR.L   D6,D7                  *Shift bits to the LSB
                    MOVE.L  D7,D4                  *Move the reg num for display
                    
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
src_expansion       CMP.W   #7,D3                   
                    BLT     fin_move_ea             *Mode less than 7 don't have expansion words
                    JSR     INCREMENT_WRD_CNT       *At lease one more word
                    CMP.W   #1,D4                   *Reg 1 means long word
                    BLT     fin_move_ea             *Reg 0 is single word
                    JSR     INCREMENT_WRD_CNT
                    CMP.W   #4,D4                   *Register 4 indicates immediate data     
                    BNE     fin_move_ea             *If not immediate data then wer're done
                    CMP.W   #2,D0                   *If immediate then look at the size
                    BNE     fin_move_ea             *Less than 2 means a single word and we've already added that
                    JSR     INCREMENT_WRD_CNT       *Size is 2 (cant be greater) so add additonal word 
fin_move_ea
                    
*--------------------------------------------------------------------------------------------------------


* EndProgram
*-----------------------------------------------------------
ENDPROGRAM
            END         START            ; last line of source







*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

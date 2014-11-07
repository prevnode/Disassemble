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
            MOVE.L      (A1),D2             ; store the starting address in D6

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
            MOVE.L      (A1),D3             ; store the starting address in D6

* PromptRunAgain
* ask to run the program again, if Y then call MAIN
* if N then END program
*-----------------------------------------------------------
PROMPTRUNAGAIN     
            LEA         RUNAGAIN,A1         ; put message into A1
            MOVE        #14,D0              ; trap task #14 to print the message to screen
            TRAP        #15                 ; trap #15 I/O
            
            MOVE.B      #5,D0               ; trap task 5 grabs a single character
            TRAP        #15                 ; trap #15 I/O
            CMP.L       #$59,D1             ; compare Y to D1
            BEQ         RESET               ; brach to Reset if D1 == Y
            
            CMP.B       #$79,D1             ; compare y to D1
            BEQ         RESET               ; brach to Reset if D1 == y
            BRA         ENDPROGRAM          ; else branch to end

* Reset
* prep the program to run again
*-----------------------------------------------------------
RESET
            MOVE.B      #11,D0
            MOVE.W      #$FF00,D1
            TRAP        #15
            
            CLR         D0
            CLR         D1
            CLR         D2
            CLR         D3
            CLR         D4
            CLR         D5
            CLR         D6
            CLR         D7
            
            SUBA.L      A0,A0
            SUBA.L      A1,A1
            SUBA.L      A2,A2
            SUBA.L      A3,A3
            SUBA.L      A4,A4
            SUBA.L      A5,A5
            SUBA.L      A6,A6

            BRA         START 

* Put variables and constants here
*-----------------------------------------------------------
CR          EQU         $0D                 ; Carriage Return
LF          EQU         $0A                 ; Line Feed

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

* EndProgram
*-----------------------------------------------------------
ENDPROGRAM
            END         START            ; last line of source





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

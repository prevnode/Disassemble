*-----------------------------------------------------------
* Title      :  DISSEMBLER PROTOTYPE I/O
* Written by :  BRANDAN HAERTEL, GARY MIXSON, ERICK HOUSE
* Date       :  10/5/2014
* Description:  SPLASH SCREEN AND SIMPLE LOOP THROUGH 10
*               10 MEMORY LOCATIONS
*-----------------------------------------------------------
    
START:      ORG         $1000            ; first instruction of program

* Put program code here
*-----------------------------------------------------------
MAIN        
            LEA         SPLASH,A1
            MOVE        #14,D0
            TRAP        #15

* PromptStartHex
* prompt the user for a starting address in hex
* this does not error check!
*-----------------------------------------------------------
PROMPTSTARTHEX
            LEA         GETSRTHEX,A1        ; put the GETSRTHEX message into A1
            MOVE        #14,D0              ; trap task #14 to print the message to screen
            TRAP        #15                 ; trap #15 I/O

* PromptEndHex
* prompt the user for a ending address in hex
* this does not error check!
*-----------------------------------------------------------
PROMPTENDHEX
            LEA         GETENDHEX,A1        ; put the GETENDHEX message into A1
            MOVE        #14,D0              ; trap task #14 to print the message to screen
            TRAP        #15                 ; trap #15 I/O

* PromptRunAgain
* ask to run the program again, if Y then call MAIN
* if N then END program
*-----------------------------------------------------------
PROMPTRUNAGAIN     
            LEA         RUNAGAIN,A1         ; put the RUNAGAIN message into A1
            MOVE        #14,D0              ; trap task #14 to print the message to screen
            TRAP        #15                 ; trap #15 I/O

* Put variables and constants here
*-----------------------------------------------------------
CR          EQU         $0D             ; Carriage Return
LF          EQU         $0A             ; Line Feed

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

* End
*-----------------------------------------------------------
            END         START            ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

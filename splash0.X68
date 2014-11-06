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
MAIN        LEA         SPLASH,A1
            MOVE        #14,D0
            TRAP        #15

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

*-----------------------------------------------------------
* Title      :  DISSEMBLER PROTOTYPE I/O
* Written by :  BRANDAN HAERTEL, ERICK HOUSE, GARY MIXSON
* Date       :  10/5/2014
* Description:  SPLASH SCREEN AND SIMPLE LOOP THROUGH 10
*               10 MEMORY LOCATIONS
*-----------------------------------------------------------
    
START:      ORG         $1000            | first instruction of program

MASK        EQU         %11110000000000000000000000000000

* D0,D1,D7 OPEN
* CONVERT D3 TO ASCII HEX

            MOVE.L      #$A00F551F,D3

            MOVE.B      #$8,D0
            
LOOP        MOVE.L      D3,D7
            ANDI.L      #MASK,D7
            MOVE.B      D0,D6
            SUBI.B      #1,D6
            MULU        #4,D6
            ROR.L       D6,D7
            
            CMPI.B      #9,D7
            BLE         CONV_NUM
            BRA         CONV_ALPHA
            
CONV_NUM    ADDI.B      #30,D7
            BRA         CONV_MOVE
            
CONV_ALPHA  ADDI.B      #42,D7
            BRA         CONV_MOVE
            
CONV_MOVE   SUBI.L      #4,D6
            ROL.L       D6,D7
            ADD.L       D7,D1
            

* EndProgram
*-----------------------------------------------------------
ENDPROGRAM
            END         START            | last line of source







*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

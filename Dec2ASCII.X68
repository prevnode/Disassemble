*-----------------------------------------------------------
* Title      :  DISSEMBLER PROTOTYPE I/O
* Written by :  BRANDAN HAERTEL, ERICK HOUSE, GARY MIXSON
* Date       :  10/5/2014
* Description:  SPLASH SCREEN AND SIMPLE LOOP THROUGH 10
*               10 MEMORY LOCATIONS
*-----------------------------------------------------------
    
START:      ORG         $1000            | first instruction of program

            MOVE.L      #$A100FF6B,D1
            MOVE.B      #$8,D0
            
PUSH_LOOP   CMPI.B      #$0,D0
            BEQ         HEX_PULL
            MOVE.B      D1,D3
            LSR.L       #4,D1
            ANDI.B      #$F,D3
            CMPI.B      #$9,D3
            BLT         HEX_NUM
            BRA         HEX_ALP
            
HEX_NUM     ADDI.B      #$30,D3
            BRA         HEX_AGAIN
HEX_ALP     ADD.B       #$37,D3
            BRA         HEX_AGAIN
HEX_AGAIN   MOVE.B      D3,-(SP)
            SUBI.B      #$1,D0
            BRA         PUSH_LOOP

HEX_PULL    MOVE.B      #$8,D1
PULL_LOOP   MOVE.B     (SP)+,HEX_MSG
            LEA         HEX_MSG,A1
            MOVE.B      #14,D0
            TRAP        #15
            SUBI.B      #$1,D1
            CMPI.B      #$0,D1
            BGT         PULL_LOOP
            
HEX_MSG     DC.B        'A',0
* EndProgram
*-----------------------------------------------------------
ENDPROGRAM
            END         START            | last line of source








*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

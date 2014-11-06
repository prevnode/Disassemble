*System equates
hexdata          EQU     $1600                *Leave your hex data here if you'd like it to be converted to bin

bindata          EQU     $1610                *Find your bin data here after calling hex2bin

*-----------------------------------HEX TO BINARY-----------------------
*Replaces the data in register D7 with its binary form
*Bin numbers
hex0           EQU      %0000
hex1           EQU      %0001
hex2           EQU      %0010
hex3           EQU      %0011
hex4           EQU      %0100
hex5           EQU      %0101
hex6           EQU      %0110
hex7           EQU      %0111
hex8           EQU      %1000
hex9           EQU      %1001
hexA           EQU      %1010
hexB           EQU      %1011
hexC           EQU      %1100
hexD           EQU      %1101
hexE           EQU      %1110
hexF           EQU      %1111

hex2bin        MOVE.L   #$ABCDEFAB,hexdata *more test data

               
startcnvt      MOVE.B   hexdata,D7
               LSR      #4,D7
               
               CMP.B    #0,D7
               BEQ      push0 

               CMP.B    #$A,D7
               BEQ      pushA       
               
               STOP     #$2700

push0          MOVE.B   hex0,hexdata
                
               STOP     #$2700

pushA          MOVE.B   #hexA,hexdata

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

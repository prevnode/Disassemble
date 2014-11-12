*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here
    MOVE.B      D5,D6       *Data Register Direct
    MOVE.B      A5,A6       *Address Register Direct
    MOVE.B      (A5),A6     *Address Register Indirect
    MOVE.B      #256,D6     *Immediate Data
    MOVE.B      (A5)+,D6    *Address Register with Postincrement
    MOVE.B      -(A5),D6    *Address Register with Predecrement
    



    MOVE.W    D2,A2
    MOVE.L    D3,$1650000
    MOVE.B    #14,D6
    MOVE.W    #14,D6
    MOVE.L    #1455,D6
    MOVE.L    #1455,A6
    MOVE.L    #145555,D6


    ADD       D3,D5    
    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

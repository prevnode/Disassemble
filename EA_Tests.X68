*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $8888
START:                  ; first instruction of program
    
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

*----------------------CMP VARIANTS--------------------------
CMPVARIANTS
    CMP         D1,D2
    CMP         A1,D2
    CMP         $0010,D2
    CMP         $1234FFFF,D2
    CMP         #14,D2
    CMP.L       #$12345,D2
    
    
 
    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

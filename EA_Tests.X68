*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $8888
START:                  ; first instruction of program

*---------------LEA VARIANTS-----------------------------------

    LEA         $3453, A6
    LEA         $10004000, A3
    LEA         (A5),A6


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

*---------------------------MULUS VARIANTS---------------------
    MULS.W      $1234,D2
    MULS        D3,D4
    
*-----------------------------DIVS VARIANTS--------------------
    DIVS        $12345678,D3
    DIVS        D6,D7

*------------------NOT VARIANTS--------------------------------
    
    NOT.B       (A1)
    NOT.B       (A2)+
    NOT.B       D0
    NOT.B       $34643699
    NOT.B       $6991
    NOT.W       (A0)
    NOT.W       $1000
    NOT.W       $10004000
    NOT.W       D4
    NOT.L       -(A0)
    NOT.L       (A0)
    NOT.L       (A3)
    NOT.L       D3

*---------------SHIFT VARIANTS-----------------------------------
    
    ASL.B       #3,D0
    ASL.W       #%100,D0
    ASL.L       #3,D0
    ASL         (A0)+
    
    ASR.B       #$3,D3
    ASR.W       #3,D0
    ASR.L       #3,D0

    LSL.B       #3,D0
    LSL.W       D1,D0
    LSL.L       D3,D4
    LSL         $1000
    
    LSR.B       #3,D0
    LSR.W       #3,D0
    LSR.L       #3,D0
    LSR         $10004000
    
    ROR.B       #3,D0
    ROR.W       #3,D0
    ROR.L       #3,D0
    ROR         (A1)

    ROL.B       #3,D0
    ROL.W       #3,D0
    ROL         -(A2)
    


*------------------BCC VARIANTS--------------------------------
    
    BEQ         TESTJMP 
    BLT         TESTJMP
    BNE         TESTJMP
    BHI         TESTJMP
    BRA         TESTJMP
    JSR         TESTJMP
    RTS  

TESTJMP       
    
*------------------NEG VARIANTS--------------------------------
    
    NEG.B       (A1)
    NEG.B       (A2)+
    NEG.B       D0
    NEG.B       $34643699
    NEG.B       $6991
    NEG.W       (A0)
    NEG.W       $1000
    NEG.W       $10004000
    NEG.W       D4
    NEG.L       -(A0)
    NEG.L       (A0)
    NEG.L       (A3)
    NEG.L       D3
    
    
*--------------------CMP VARIANTS------------------------------
    CMPA        D3,A2
    CMPA        A2,A4
    CMPA        $1234,A3

    CMP         D1,D2           ;Data register direct
    CMP         A1,D2           ;Address register direct
    CMP         $0010,D2        ;
    CMP         $1234FFFF,D2
    CMP         #14,D2
    CMP.L       #$12345,D2   
    

    
    
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
    
    *--------------------BTST VARIANTS-----------------------
    BTST    D3,#1234
    BTST    D7,D2
    BTST    D7,$1600
    BTST    D7,$12345678
    BTST    #12345678,D2
    BTST.L  #$12345678, D2
    BTST    #$12345678, D2


    
    
 
    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

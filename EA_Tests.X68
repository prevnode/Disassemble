*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $8888
START:                  ; first instruction of program

*--------------EOR Varitants-------------
    EOR     D2,$ACDB
    EOR.L   D7,-(A4)
    EOR     D3,$87654321
    EOR.B   D2,(A6)+


*-----------------EORI Variants-------------------
    EORI        #$21,D2
    EORI        #$129,$1234
    EORI.L      #$FE,$12345678
    EORI.L      #$ABCDEFAD,D7


*----------------------CMPI VARIANTS----------------
    CMPI        #3, D0
    CMPI        #$454, $2324
    CMPI.W      #$4564, D3
    CMPI.L      #$AB,$12345678  


*--------------------------SUBI VARIANTS----------------
    
    SUBI.L    #$ABCDEFED,$12345678    
    SUBI    #45,$1234
    SUBI    #$AA,D6
    SUBI    #$1234,$5678
    SUBI    #$AB,(A2)
    *SUBI    #$5,$1234          ;Assmbler converts to addq need to note
    *SUBI    #2,D7              ;Assembler converts to addq need to note
    *SUBI    #3,$12345678       ;Assembler converts to addq need to note
    
    ASL.B       #3,D0
    ASL.W       #%100,D0
    ASL.L       #3,D0
    ASL         (A0)+ ;output ROL.L $E603E640 (Assembler converts to ROL need further investigation)
    
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

   
*--------------------BTST VARIANTS-----------------------
    BTST    #12345678,D2
    BTST.L  #$12345678, D2
    BTST    #$12345678, D2
    BTST    D3,#1234
    BTST    D7,D2
    BTST.L  D7,D2
    BTST    D7,$1600
    BTST    D7,$12345678
    BTST    #1,D7
    
*---------------------AND VARIANTS-----------------------------
    AND     $1234,D5
    AND     D5,$1234
    AND     D7,D6
    AND     $12345678,D2
    AND     (A2),D3
    AND     (A3)+,D4
    AND.B   -(A6),D2
    AND.L   $1234,D7

*------------------------ADDQ VARIANTS---------------
    ADDQ    #3,D5
    ADDQ.W  #7,$12345678
    ADDQ.L  #5,$2468
    ADDQ.B  #8,$12345678


*-----------------SUBA VARIANTS---------------------------
    SUBA.W  $1234,A6
    SUBA.L  $5678,A5
    SUBA    D5,A6
    SUBA    -(A3),A4

*--------------------ADDA VARIANTS---------------------------
    ADDA.W  $1234,A6
    ADDA.L  $5678,A5
    ADDA    D5,A6
    ADDA    -(A3),A4

*---------------------ADD VARIANTS-----------------------------
    ADD     $1234,D5
    ADD     D5,$1234
    ADD     D7,D6
    ADD     $12345678,D2
    ADD     (A2),D3
    ADD     (A3)+,D4
    ADD.B   -(A6),D2
    ADD.L   $1234,D7
   
   
*---------------------SUB VARIANTS-----------------------------
    SUB     $1234,D5
    SUB     D5,$1234
    SUB     D7,D6
    SUB     $12345678,D2
    SUB     (A2),D3
    SUB     (A3)+,D4
    SUB.B   -(A6),D2
    SUB.L   $1234,D7

*--------------------MOVEM VARIANTS--------------------------
    MOVEM.L     A0-A3/D0-D7, -(A7)
    
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
    ASL         (A0)+ ;output ROL.L $E603E640
    
    ASR.B       #$3,D3 ;output MULS.L $3,D0
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
    


*------------------BCC VARIANTS + RTS/JSR-----------------------
    
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
    NEG.L       -(A0) ; prints MOVEM, then garbage
    NEG.L       (A0)  ; same here
    NEG.L       (A3)
    NEG.L       D3
    
    
*--------------------CMP VARIANTS------------------------------
    CMPA        D3,A2
    CMPA        A2,A4
    CMPA        $1234,A3

    CMP         D1,D2           ;Data register direct
    CMP         A1,D2           ;Address register direct
    CMP.W       $0010,D2        ;
    CMP         $1234FFFF,D2
    CMP         #14,D2
    CMP.L       #$12345,D2   
    
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
    
 
    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

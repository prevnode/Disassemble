*-----------------------------------------------------------
* Title      : Test Code
* Written by : Curtis Andersson
* Date       : 11/11/14
* Description: Test Code to help with debugging
*-----------------------------------------------------------
    ORG    $8888
START:                  ; first instruction of program


;-------------- CMP -------------------;

    Cmp.B       D2,D4
    Cmp.W       A7,D2
    Cmp.W       (A6),D3
    Cmp.W       (A7)+,D2
    Cmp.W       -(A3),D2
    Cmp.B       $1234,D7
    Cmp.W       $12345678,D3
    Cmp.B       $12,D2
    Cmp.W       #1245,D5
    Cmp.L       #12345678,D5
        
    CmpA.W      D4,A5
    CmpA.W      A4,A5
    CmpA.W      (A4),A5
    CmpA.W      (A4)+,A5
    CmpA.W      -(A4),A5
    CmpA.W      $1234,A5
    CmpA.L      $11111111,A5
    CmpA.W      #$FFFF,A4
    CmpA.L      #$AAAAFFFF,A6
    CmpA.L      (A4)+,A5


;--------- IMMEDIATE FUNCTIONS ---------;

    CmpI.W      #$ABCD, D4
    CmpI.B      #$12,D4
    CmpI.W      #$1234,(A4)
    CmpI.L      #$12345678,(A4)+
    CmpI.W      #$12,-(A7)
    CmpI.L      #$87654321, $12345678
    CmpI.B      #12,$1234
    
    Ori.L       #$12345678,D1
    OrI.B       #$02,(A6)
    OrI.L       #12,(A5)+
    Ori.L       #$1234,-(A1)
    Ori.L       #$12345678,$1234
    Ori.B       #$12,$12345678
    
    SubI.W      #1423,-(A3)
    SubI.B      #12,D3
    SubI.L       #$12345678,D1
    SubI.B       #$02,(A6)
    SubI.L       #12,(A5)+
    SubI.L       #$1234,-(A1)
    SubI.L       #$12345678,$1234
    SubI.B       #$12,$12345678

    EorI.L      #$ABCE1452,(A5)
    EorI.B      #255,$FFFFA000
    EorI.W      #$ABCD, D4
    EorI.B      #$12,D4
    EorI.W      #$1234,(A4)
    EorI.L      #$12345678,(A4)+
    EorI.W      #$12,-(A7)
    EorI.L      #$87654321, $12345678
    EorI.B      #12,$1234

;-------------- MOVE -----------------;

    Move.B      $4214,D1
    Move.W      -(A5),D2
    Move.L      A5, (A3)+
    Move.W      $8000,D4
    Move.B      $80001000, -(A2)
    Move.B      #12, D7
    Move.L      #$1234, $1234
    Move.L      #$12345678,$7000

    MoveA.W     #$3000,A0
    MoveA.L     #$12345678,A3
    MoveA.L     D1,A5
    MoveA.W     $1234,A2
    MoveA.W     12345678,A1
    
    MOVEM.L     D1/D2/D3, -(SP)
    MOVEM.W     D0/A1/A2, -(SP)
    MOVEM.L     (SP)+,D1/D2/D3
    MOVEM.W     (SP)+,D0/A1/A2
    MOVEM.L     D1-D5/A3-A6, -(SP)
    MOVEM.W     (SP)+, D0-D7/A0-A7
    
;-------------- ADD ------------------;

    Add.B       D1,D2
    Add.W       D2,(A1)
    Add.L       (A3)+,D1
   ; Add.L       #$1234,D3       ; Defaults to AddI
    Add.W       D1,$1234
    Add.L       $1234,D1
    Add.L       $12345678,D1
    Add.L       D6,$1234
    Add.W       D6,$12345678    

    AddA.W      $1234,A4
    AddA.W      $89AB,A4
    AddA.L      $1234,A5
    AddA.L      $12345678,A7
    AddA.W      #$1234,A7
    AddA.L      #$12345678,A7
    AddA.W      D1,A2
    AddA.W      -(A3),A2
    AddA.W      A3,A2
    AddA.W      (A3),A2
    AddA.W      (A3)+,A2
    
    AddQ.B      #1,D0
    AddQ.W      #2,A3
    AddQ.W      #3,(A3)
    AddQ.L      #4,$8000
    AddQ.W      #5,(A3)+
    AddQ.W      #6,-(A6)
    AddQ.W      #7,$12345678
    AddQ.W      #8,$12348000       
    AddQ.W      #$8,$7000 
     
    
;-------------- SUB ------------------;

    Sub.B       -(A3),D5
    Sub.W       D7, $12345678
    Sub.L       D4, D6
    Sub.B       D2,D4
    Sub.W       A7,D2
    Sub.W       (A6),D3
    Sub.W       (A7)+,D2
    Sub.W       -(A3),D2
    Sub.B       $1234,D7
    Sub.W       $12345678,D3
    Sub.B       $12,D2
    Sub.W       #1245,D5
    Sub.L       #12345678,D5
    
    Sub.W       D4,(A3)
    Sub.W       D2,(A4)+
    Sub.W       D3,-(A3)
    Sub.W       D2,$1234
    Sub.W       D2,$12345678

    SubA.L      D1,A4
    SubA.W      A1,A2
    SubA.W      (A1),A2
    SubA.W      (A1)+,A2
    SubA.W      -(A1),A2
    SubA.W      $1234,A2
    SubA.L      $12345678,A2
    SubA.W      #$1234,A2
    SubA.L      #$12345678,A3 ;output ADDQ $3,$B802


    
;------------ BCC & Jumps --------------;

    Bra         $1234
    Beq         $5678
    Bne         $1111
    Blt         $9999
    Bhi         $1000
    
    Jsr         $ABCD
    Jsr         (A6)
    Jsr         $1234
    Jsr         $12345678
    Rts
    
;--------- SHIFT FUNCTIONS -------------;

    ASL.B       D1, D2
    Asl.B       #8,D1
    Asr.W       #3,D1
    Asl.L       #6,D1
    ASR.L       #5, D4
    ASR         (A3)
    Asr.W       (A4)+
    Asl.W       -(A3)
    Asr.W       $1234
    Asl.W       $11111118
    
    LSL.L       D2,D3
    LSR.B       #1,D4
    LSL         $8000
    LSL.B       D1, D2
    LSL.B       #8,D1
    LSR.W       #3,D1
    LSL.L       #6,D1
    LSR.L       #5, D4
    LSR         (A3)
    LSR.W       (A4)+
    LSL.W       -(A3)
    LSR.W       $1234
    LSL.W       $11111118

    
    ROR.L       D1,D5
    ROL.B       #1,D2
    ROL.B       #2,D2
    ROL.B       #3,D2
    ROL.B       #4,D2
    ROL.B       #5,D2
    ROL.B       #6,D2
    ROL.B       #7,D2
    ROL.B       #8,D2
    
        
;------- Neg - Not - Muls - Divs -------;

    Neg.L       D1
    Neg.W       (A3)
    Neg.B       (A6)+
    Neg.B       -(A6)
    Neg.L       $1234
    Neg.B       $12345678
    
    Not.L       -(A2)
    Not.B       D3
    Not.W       $7532
    Not.L       D1
    Not.W       (A3)
    Not.B       (A6)+
    Not.B       -(A6)
    Not.L       $1234
    Not.B       $12345678

    Muls.W      $9764, D4
    Muls.W      #15, D6
    Muls.W      (A6),D3
    Muls.W      (A3)+,D1
    Muls.W      -(A2),D7
    Muls.W      $1234,D5
    Muls.W      $12345678,D1
    Muls.W      #$8888,D0
    
    Divs.W      #3,D7
    Divs.W      (A2),D3
    Divs.W      $9764, D4
    Divs.W      #15, D6
    Divs.W      (A6),D3
    Divs.W      (A3)+,D1
    Divs.W      -(A2),D7
    Divs.W      $AAAA,D5
    Divs.W      $1234CCCC,D1
    Divs.W      #$8888,D0

    
;------- BTST - EOR - AND ------;
    
    BTST.L      D0,D1
    BTST.B      D2,(A3)
    BTST.B      D2,(A2)+          
    BTST.B      D2,-(A2)
    BTST.B      D2,$AAAA
    BTST.B      D2,$CCCCBBBB
    BTST.B      D2,#$AA
    BTST.B      D2,#$11
    BTST.L      #$8011,D1      
    BTST.B      D0,$7000        
    BTST.B      #$8,$8000
    BTST.L      #$12,D1
    BTST.B      #$33,(A3)
    BTST.B      #$44,(A2)+          
    BTST.B      #$FF,-(A2)
    BTST.B      #$AA,$AAAA
    BTST.B      #$DD,$CCCCBBBB
      
    
    EOR.B       D0,$1000
    EOR.W       D0,D1
    EOR.L       D1,$4000
    EOR.W       D0,(A1)
    EOR.W       D0,(A2)+
    EOR.L       D0,-(A6)
    EOR.B       D0,$1234
    EOR.B       D0,$12345678    
    
    AND.B       $1000,D0
    AND.W       D1,$1000
    AND.L       D1,D0
    AND.W      #3,D7
    AND.B      (A2),D3
    AND.W      $9764, D4
    AND.L      #15, D6
    AND.W      (A6),D3
    AND.B      (A3)+,D1
    AND.L      -(A2),D7
    AND.W      $AAAA,D5
    AND.W      $1234CCCC,D1
    AND.L      #$8888,D0
    AND.L      D0,D1
    AND.B      D2,(A3)
    AND.B      D2,(A2)+          
    AND.B      D2,-(A2)
    AND.B      D2,$AAAA
    AND.B      D2,$CCCCBBBB
    
    
;---------- LEA ----------;

    Lea         (A5),A6
    Lea         $1234,A2
    Lea         $12345678,A5    

    END    START












*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

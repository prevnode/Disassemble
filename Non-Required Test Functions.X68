
    ORG    $8888
START:                  ; first instruction of program
    TRAP    #15
    STOP    #$2700              ; Has extra word
    CLR     D0
    ADDI    #10,$1000           ; Has 2 extra word
    ADDX.B  D0,D1
    ADDX.W  D0,D1
    ADDX.L  D0,D1
    ABCD    D0,D1
    ANDI.B  #10,$1000
    ANDI.W  #10,$1000
    ANDI.L  #$12345678,$1000
    BCC     $1111
    BCS     $1234
    BGE     $1000
    BGT     $1555
    BLE     $5000
    BLS     $1234
    BMI     $1236
    BPL     $5555
    BVC     $3456
    BVS     $6666
    BCHG    D0,$1000            ; Converts to OrI
    BCHG    #$10,$1000          
    BCLR    D0,$1000            ; Converts to OrI
    BCLR    #$10,$1000
    BSET    D0,$1000
    BSET    #$10,$1000
    BSR     $1000
    CMPM.B  (A1)+,(A2)+         ; Converts to Eor
    CMPM.W  (A1)+,(A2)+
    CMPM.L  (A1)+,(A2)+
    Mulu    $1000,D1
    Nbcd    $2000
    NegX    $1000
    Nop
    Or.B    $1000,D1
    Or.B    D1,$1000
    Or.W    $1000,D1
    Or.W    D1,$1000
    Or.L    $1000,D1
    Or.L    D1,$1000
    Pea     $1000
    Roxl.B  D1,D2
    Roxl.B  #1,D1
    Roxl.W  $1000
    Roxl.W  D1,D2
    Roxl.W  #1,D1
    Roxl.L  D1,D2
    Roxl.L  #1,D1
    Sbcd    D1,D2
    Sbcd    -(A1),-(A2)
    SCC     $1111
    SCS     $1234
    SEQ     $1000
    SF      $1234
    SGE     $1000
    SGT     $1555
    SHI     $5544
    SLE     $5000
    SLS     $1234
    SMI     $1236
    SNE     $4444
    SPL     $5555
    ST      $6789
    SVC     $3456
    SVS     $6666
    TST.B   $1000
    TST.W   $1000
    TST.L   $1000  

    END    START        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

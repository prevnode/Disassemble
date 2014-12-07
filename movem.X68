*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program


        MOVE.W  #$9067,D1
        
*        MOVE.W  #$8000,D1
*        MOVE.W  #$4000,D1
*        MOVE.W  #$2000,D1
*        MOVE.W  #$1000,D1
*        
*        MOVE.W  #$0800,D1
*        MOVE.W  #$0400,D1
*        MOVE.W  #$0200,D1
*        MOVE.W  #$0100,D1
*        
*        MOVE.W  #$0080,D1
*        MOVE.W  #$0040,D1
*        MOVE.W  #$0020,D1
*        MOVE.W  #$0010,D1
*        
*        MOVE.W  #$0008,D1
*        MOVE.W  #$0004,D1
*        MOVE.W  #$0002,D1
*        MOVE.W  #$0001,D1

MOVEM_LIST_EA
        
MMNGA7  CLR     D0
        MOVE.W  D1,D0
        ANDI.W  #$8000,D0
        CMPI.W  #$8000,D0
        BNE     MMNGA6
        LEA     MMA7,A1
        MOVE.B  #14,D0
        TRAP    #15
        
MMNGA6  CLR     D0
        MOVE.W  D1,D0
        ANDI.W  #$4000,D0
        CMPI.W  #$4000,D0
        BNE     MMNGA5
        LEA     MMA6,A1
        MOVE.B  #14,D0
        TRAP    #15
        
MMNGA5  CLR     D0
        MOVE.W  D1,D0
        ANDI.W  #$2000,D0
        CMPI.W  #$2000,D0
        BNE     MMNGA4
        LEA     MMA5,A1
        MOVE.B  #14,D0
        TRAP    #15
        
MMNGA4  CLR     D0
        MOVE.W  D1,D0
        ANDI.W  #$1000,D0
        CMPI.W  #$1000,D0
        BNE     MMNGA3
        LEA     MMA4,A1
        MOVE.B  #14,D0
        TRAP    #15
		
MMNGA3  CLR     D0
        MOVE.W  D1,D0
        ANDI.W  #$0800,D0
        CMPI.W  #$0800,D0
        BNE     MMNGA2
        LEA     MMA3,A1
        MOVE.B  #14,D0
        TRAP    #15
		
MMNGA2  CLR     D0
        MOVE.W  D1,D0
        ANDI.W  #$0400,D0
        CMPI.W  #$0400,D0
        BNE     MMNGA1
        LEA     MMA2,A1
        MOVE.B  #14,D0
        TRAP    #15
		
MMNGA1  CLR     D0
        MOVE.W  D1,D0
        ANDI.W  #$0200,D0
        CMPI.W  #$0200,D0
        BNE     MMNGA0
        LEA     MMA1,A1
        MOVE.B  #14,D0
        TRAP    #15
		
MMNGA0  CLR     D0
        MOVE.W  D1,D0
        ANDI.W  #$0100,D0
        CMPI.W  #$0100,D0
        BNE     MMNGD7
        LEA     MMA0,A1
        MOVE.B  #14,D0
        TRAP    #15

MMNGD7  CLR     D0
        MOVE.W  D1,D0
        ANDI.W  #$0080,D0
        CMPI.W  #$0080,D0
        BNE     MMNGD6
        LEA     MMD7,A1
        MOVE.B  #14,D0
        TRAP    #15
		
MMNGD6  CLR     D0
        MOVE.W  D1,D0
        ANDI.W  #$0040,D0
        CMPI.W  #$0040,D0
        BNE     MMNGD5
        LEA     MMD6,A1
        MOVE.B  #14,D0
        TRAP    #15
		
MMNGD5  CLR     D0
        MOVE.W  D1,D0
        ANDI.W  #$0020,D0
        CMPI.W  #$0020,D0
        BNE     MMNGD4
        LEA     MMD5,A1
        MOVE.B  #14,D0
        TRAP    #15
		
MMNGD4  CLR     D0
        MOVE.W  D1,D0
        ANDI.W  #$0010,D0
        CMPI.W  #$0010,D0
        BNE     MMNGD3
        LEA     MMD4,A1
        MOVE.B  #14,D0
        TRAP    #15
		
MMNGD3  CLR     D0
        MOVE.W  D1,D0
        ANDI.W  #$0008,D0
        CMPI.W  #$0008,D0
        BNE     MMNGD2
        LEA     MMD3,A1
        MOVE.B  #14,D0
        TRAP    #15
		
MMNGD2  CLR     D0
        MOVE.W  D1,D0
        ANDI.W  #$0004,D0
        CMPI.W  #$0004,D0
        BNE     MMNGD1
        LEA     MMD2,A1
        MOVE.B  #14,D0
        TRAP    #15
		
MMNGD1  CLR     D0
        MOVE.W  D1,D0
        ANDI.W  #$0002,D0
        CMPI.W  #$0002,D0
        BNE     MMNGD0
        LEA     MMD1,A1
        MOVE.B  #14,D0
        TRAP    #15
		
MMNGD0  CLR     D0
        MOVE.W  D1,D0
        ANDI.W  #$0001,D0
        CMPI.W  #$0001,D0
        BNE     MMNGFINISH
        LEA     MMD0,A1
        MOVE.B  #14,D0
        TRAP    #15
		
MMNGFINISH
        CLR     D0
        BRA     ENDPROG
        RTS
        
MOVEM_EA_LIST
        BRA     MMNSD0

MMNSD0  CLR     D0
        MOVE.W  D1,D0
        ANDI.W  #$0001,D0
        CMPI.W  #$0001,D0
        BNE     MNGD1
        LEA     MMD0,A1
        MOVE.B  #14,D0
        TRAP    #15
		
MMNSD1  CLR     D0
        MOVE.W  D1,D0
        ANDI.W  #$0002,D0
        CMPI.W  #$0002,D0
        BNE     MMNSD2
        LEA     MMD1,A1
        MOVE.B  #14,D0
        TRAP    #15

MMNSD2  CLR     D0
        MOVE.W  D1,D0
        ANDI.W  #$0004,D0
        CMPI.W  #$0004,D0
        BNE     MMNSD3
        LEA     MMD2,A1
        MOVE.B  #14,D0
        TRAP    #15
		
MMNSD3  CLR     D0
        MOVE.W  D1,D0
        ANDI.W  #$0008,D0
        CMPI.W  #$0008,D0
        BNE     MMNSD4
        LEA     MMD3,A1
        MOVE.B  #14,D0
        TRAP    #15
		
MMNSD4  CLR     D0
        MOVE.W  D1,D0
        ANDI.W  #$0010,D0
        CMPI.W  #$0010,D0
        BNE     MMNSD5
        LEA     MMD4,A1
        MOVE.B  #14,D0
        TRAP    #15
		
MMNSD5  CLR     D0
        MOVE.W  D1,D0
        ANDI.W  #$0020,D0
        CMPI.W  #$0020,D0
        BNE     MMNSD6
        LEA     MMD5,A1
        MOVE.B  #14,D0
        TRAP    #15
		
MMNSD6  CLR     D0
        MOVE.W  D1,D0
        ANDI.W  #$0040,D0
        CMPI.W  #$0040,D0
        BNE     MMNSD7
        LEA     MMD6,A1
        MOVE.B  #14,D0
        TRAP    #15
		
MMNSD7  CLR     D0
        MOVE.W  D1,D0
        ANDI.W  #$0080,D0
        CMPI.W  #$0080,D0
        BNE     MMNSA0
        LEA     MMD7,A1
        MOVE.B  #14,D0
        TRAP    #15
		
MMNSA0  CLR     D0
        MOVE.W  D1,D0
        ANDI.W  #$0100,D0
        CMPI.W  #$0100,D0
        BNE     MMNSA1
        LEA     MMA0,A1
        MOVE.B  #14,D0
        TRAP    #15
		
MMNSA1  CLR     D0
        MOVE.W  D1,D0
        ANDI.W  #$0200,D0
        CMPI.W  #$0200,D0
        BNE     MMNSA2
        LEA     MMA1,A1
        MOVE.B  #14,D0
        TRAP    #15
		
MMNSA2  CLR     D0
        MOVE.W  D1,D0
        ANDI.W  #$0400,D0
        CMPI.W  #$0400,D0
        BNE     MMNSA3
        LEA     MMA2,A1
        MOVE.B  #14,D0
        TRAP    #15
		
MMNSA3  CLR     D0
        MOVE.W  D1,D0
        ANDI.W  #$0800,D0
        CMPI.W  #$0800,D0
        BNE     MMNSA4
        LEA     MMA3,A1
        MOVE.B  #14,D0
        TRAP    #15
		
MMNSA4  CLR     D0
        MOVE.W  D1,D0
        ANDI.W  #$1000,D0
        CMPI.W  #$1000,D0
        BNE     MMNSA5
        LEA     MMA4,A1
        MOVE.B  #14,D0
        TRAP    #15
		
MMNSA5  CLR     D0
        MOVE.W  D1,D0
        ANDI.W  #$2000,D0
        CMPI.W  #$2000,D0
        BNE     MMNSA6
        LEA     MMA5,A1
        MOVE.B  #14,D0
        TRAP    #15
		
MMNSA6  CLR     D0
        MOVE.W  D1,D0
        ANDI.W  #$4000,D0
        CMPI.W  #$4000,D0
        BNE     MMNSA7
        LEA     MMA6,A1
        MOVE.B  #14,D0
        TRAP    #15
		
MMNSA7  CLR     D0
        MOVE.W  D1,D0
        ANDI.W  #$8000,D0
        CMPI.W  #$8000,D0
        BNE     MMNSFINISH
        LEA     MMA7,A1
        MOVE.B  #14,D0
        TRAP    #15
		
MMNSFINISH
		RTS
		
		
MMA7    DC.W    'A7 ',0
MMA6    DC.W    'A6 ',0
MMA5    DC.W    'A5 ',0
MMA4    DC.W    'A4 ',0
MMA3    DC.W    'A3 ',0
MMA2    DC.W    'A2 ',0
MMA1    DC.W    'A1 ',0
MMA0    DC.W    'A0 ',0
MMD7    DC.W    'D7 ',0
MMD6    DC.W    'D6 ',0
MMD5    DC.W    'D5 ',0
MMD4    DC.W    'D4 ',0
MMD3    DC.W    'D3 ',0
MMD2    DC.W    'D2 ',0
MMD1    DC.W    'D1 ',0
MMD0    DC.W    'D0 ',0
    
    

* Put variables and constants here
ENDPROG
    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

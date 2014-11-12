*-----------------------------------------------------------
* Title      :  DISSEMBLER PROTOTYPE I/O
* Written by :  BRANDAN HAERTEL
*               GARY MIXSON
*               ERICK HOUSE
* Date       :  10/5/2014
* Description:  SPLASH SCREEN AND SIMPLE LOOP THROUGH 10
*               10 MEMORY LOCATIONS
*-----------------------------------------------------------


*-----------------------SPLASH SCREEN------------------------------------
CR          EQU         $0D
LF          EQU         $0A

SPLASH2     DC.B    '        ____ ___  __ __                        ',CR,LF
            DC.B    '       / __/( _ )/ //_/                        ',CR,LF
            DC.B    '      / _ \/ _  / ,<                           ',CR,LF
            DC.B    '      \___/\___/_/|_|  __      _               ',CR,LF
            DC.B    '        / __/ /__ ____/ /_____(_)___           ',CR,LF
            DC.B    '       / _// / -_) __/ __/ __/ / __/           ',CR,LF
            DC.B    '      /___/_/\__/\__/\__/_/_/_/\__/        __  ',CR,LF
            DC.B    '        / __/ /  ___ ___  / /  ___ _______/ /__',CR,LF
            DC.B    '       _\ \/ _ \/ -_) _ \/ _ \/ -_) __/ _  (_-<',CR,LF
            DC.B    '      /___/_//_/\__/ .__/_//_/\__/_/  \_,_/___/',CR,LF
            DC.B    '                  /_/                          ',CR,LF,0

* End


*--------------------------System equates----------------------------------
 

stack           EQU      $A000

example         EQU      %1101111001100001    * I made up bits 0 to 11      

shift           EQU     12                   * Shift 12 bits

byte_str        DC.B    '.B'                 *Byte sized 

word_str        DC.B    '.W'                 *Word sized

long_str        DC.B    '.L'                 *Long sized

num_expan_wrds  DS.B    0



*-----------------------------------------------------------


                 ORG     $400
                 BRA    move_ea         *Testing the move ea sr
                 
MAIN             
                 LEA    SPLASH2,A1
                 MOVE   #14,D0
                 TRAP   #15
                 
                
*----------------------------------------------Increment Expansion Word Count-----------------------------------------
INCREMENT_WRD_CNT       
                    ADD     #1,num_expan_wrds
                    RTS

               
                 
*----------------------------------Begining of Example code from project addendem---------------------------- 

start_opword     LEA     stack,SP        *Load the SP

                 LEA     jmp_table,A0    *Index into the table

                 CLR.L   D0              *Zero it

                 MOVE.W  #example,D0     *We'll play with it here

                 MOVE.B  #shift,D1       *Shift 12 bits to the right  

                 LSR.W   D1,D0           *Move the bits

*

* Consider the next instruction. Why do we have to multiply the index 

* by 6? How many bytes does a single jump table entry require? 

 

               MULU        #6,D0       *Form offset                                 

               JSR         0(A0,D0)     *Jump indirect with index

                    

jmp_table      JMP         code0000     *Bit manip /Movep / Immediate

               JMP         code0001     *Move.b

               JMP         code0010     *Move.l

               JMP         code0011     *Move.w

               JMP         code0100     *Misc

               JMP         code0101     *Addq/SubQ/Scc/DBcc

               JMP         code0110     *Bsr/Bra/Bcc

               JMP         code0111     *MoveQ

               JMP         code1000     *OR/DIV/SBCD

               JMP         code1001     *SUB/SUBX

               JMP         code1010     *Unassigned

               JMP         code1011     *Cmp/Eor

               JMP         code1100     *AND/MUL/ABCD/EXG

               JMP         code1101     *ADD/ADDA/ADDX

               JMP         code1110     *SHIFT/ROTATE

               JMP         code1111     *SPECIAL/RESERVED       

 

*The following subroutines will get filled in as you decode the instructions . For *now, just exit gracefully.

 

code0000       STOP        #$2700

code0001       STOP        #$2700

code0010       STOP        #$2700

code0011       STOP        #$2700

code0100       STOP        #$2700

code0101       STOP        #$2700

code0110       STOP        #$2700

code0111       STOP        #$2700

code1000       STOP        #$2700

code1001       STOP        #$2700

code1010       STOP        #$2700

 

* Next we put in the next level of decoding. I just stuck this BRA

* instruction here so it would look different. If this was your real

* code, you would decode to the next level. Perhaps this would be

* another jump table to the 8 possible op-codes at the next level.

 

code1011        BRA        code1011

  

code1100       STOP        #$2700

code1101       STOP        #$2700

code1110       STOP        #$2700

code1111       STOP        #$2700

*-----------------------------Invalid Opcode---------------------------
*Used when the word read in is garbage/unsupported opcode/invalid ea 
invalid_opcode

inv_mem     DC.B    '1000'
inv_code    DC.B    'DATA'
inv_operand DC.B    '$WXYZ'

            MOVE.L  inv_mem,A1
            MOVE.L  inv_code,A2
            MOVE.L  inv_operand,A3
            RTS


*-----------------------------------NOP_EA------------------------------ 
*NOP doesn't actually have an ea but hey you gotta start somewhere
nop_ea

nop_str     DC.B    'NOP'

            MOVE.L  nop_str,A1

            RTS
*-------------------------------------------------------------------------

*------------------------------------ADD------------------------------------
add_ea
register_msk        EQU     %00001110000000000000000000000000
opmode_msk          EQU     %00000001110000000000000000000000
ea_mode_msk         EQU     %00000000001110000000000000000000
ea_reg_msk          EQU     %00000000000001110000000000000000

                    MOVE.L  #$DA430000,$1600    *Test data corresponds to ADD D3,D5
                    


*---------------------------------MOVE_EA----------------------------------
*Parse the effective address of a move opcode
move_ea
move_str            DC.B    'MOVE'
size_msk            EQU     %00110000000000000000000000000000
destin_reg_msk      EQU     %00001110000000000000000000000000
destin_mod_msk      EQU     %00000001110000000000000000000000
source_mod_msk      EQU     %00000000001110000000000000000000
source_reg_msk      EQU     %00000000000001110000000000000000

                    CLR     num_expan_wrds         *Zero out number of expansion words
                    *JSR     INCREMENT_WRD_CNT                

                    *MOVE.L  #$1C050000,$1600       *Test data that corresponds to MOVE.B D5,D6
                    *MOVE.L  #$1C381400,$1600       *Test data corresponds to  MOVE.B    $1400,D6
                    MOVE.L  #$23C30165,$1600         *Test data corresponds to MOVE.L D3,$16500000
                    MOVE.W  #0000,$1604              *Completes test data
                    
                    MOVE.L  $1600,$1610            *Make a copy
                    MOVE.L  #size_msk,D7           *Load the mask
                    AND.L   D7,$1610               *Apply the mask to the copy
                    MOVE.L  $1610,D7               *Move the remaining bits into a reg to be shifted
                    MOVE.L  #28,D6                 *Lots of bits to shift
                    LSR.L   D6,D7                  *Shift bits to the LSB
                    MOVE.L  D7,D0                  *Move the size for display
                  
                    MOVE.L  $1600,$1610            *Make a copy
                    MOVE.L  #destin_reg_msk,D7     *Load the mask                   
                    AND.L   D7,$1610               *Apply the mask to the copy
                    MOVE.L  $1610,D7               *Move the remaining bits into a register to be shifted
                    MOVE.L  #25,D6                 *Going to shift a lot of bits
                    LSR.L   D6,D7                  *Move the bits to the LSB                    
                    MOVE.L  D7,D1                  *Move the finished destination reg in place for display                    
                    
                    MOVE.L  $1600,$1610            *Make a copy
                    MOVE.L  #destin_mod_msk,D7     *Load the mask
                    AND.L   D7,$1610               *Apply the mask to the copy
                    MOVE.L  $1610,D7               *Move the remaining bits into a reg to be shifted
                    MOVE.L  #22,D6                 *Lots of bits to shift
                    LSR.L   D6,D7                  *Shift bits to the LSB
                    MOVE.L  D7,D2                  *Move the mode for display                  
                    
                    MOVE.L  $1600,$1610            *Make a copy
                    MOVE.L  #source_mod_msk,D7     *Load the mask
                    AND.L   D7,$1610               *Apply the mask to the copy
                    MOVE.L  $1610,D7               *Move the remaining bits into a reg to be shifted
                    MOVE.L  #19,D6                 *Lots of bits to shift
                    LSR.L   D6,D7                  *Shift bits to the LSB
                    MOVE.L  D7,D3                  *Move the mode for display
                    
                    MOVE.L  $1600,$1610            *Make a copy
                    MOVE.L  #source_reg_msk,D7     *Load the mask
                    AND.L   D7,$1610               *Apply the mask to the copy
                    MOVE.L  $1610,D7               *Move the remaining bits into a reg to be shifted
                    MOVE.L  #16,D6                 *Lots of bits to shift
                    LSR.L   D6,D7                  *Shift bits to the LSB
                    MOVE.L  D7,D4                  *Move the reg num for display
                    
*Calculate number of expansion words
                    *Destination side
                    CMP.W   #7,D2                  *Destination modes below 7 do not have expansion words 
                    BLT     src_expansion
                    JSR     INCREMENT_WRD_CNT
                    CMP.W   #1,D1                  *001 in destination register
                    BNE     src_expansion
                    JSR     INCREMENT_WRD_CNT
                    
*Calculate number of expansion words
                    *Source Side
src_expansion       CMP.W   #7,D3                   
                    BLT     fin_move_ea             *Mode less than 7 don't have expansion words
                    JSR     INCREMENT_WRD_CNT       *At lease one more word
                    CMP.W   #1,D4                   *Reg 1 means long word
                    BLT     fin_move_ea             *Reg 0 is single word
                    JSR     INCREMENT_WRD_CNT
                    CMP.W   #4,D4                   *Register 4 indicates immediate data     
                    BNE     fin_move_ea             *If not immediate data then wer're done
                    CMP.W   #2,D0                   *If immediate then look at the size
                    BNE     fin_move_ea             *Less than 2 means a single word and we've already added that
                    JSR     INCREMENT_WRD_CNT       *Size is 2 (cant be greater) so add additonal word 
fin_move_ea
                    END   $400
*--------------------------------------------------------------------------------------------------------

*----------------------------------------Format Mode----------------------------------------------------
*Builds a string describing the EA expect to come here via jsr
*D1 spcifies the register value, D2 specifies the mode, A1 specifies the destination 
FORMAT_MODE

    DC.B    '('     OPEN_PAR
    DC.B    ')'     CLOSE_PAR
    DC.W    '-('    PRE_DEC
    DC.W    ')+'    POS_INC
    DC.B    '#'     IMMEDIATE
    
    RTS
*----------------------------------------------------------------------------------------------------------------------
                    






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

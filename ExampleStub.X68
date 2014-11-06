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
 

stack            EQU      $A000

example          EQU      %1101111001100001    * I made up bits 0 to 11      

shift            EQU     12                   * Shift 12 bits  

*-----------------------------------------------------------


                 ORG     $400
                 
                 
MAIN             LEA    SPLASH2,A1
                 MOVE   #14,D0
                 TRAP   #15
                 
                 BRA    hex2bin
                 
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

*-----------------------------------HEX TO BINARY-----------------------
*Replaces the data in register D7 with its binary form
hex2bin        MOVE.L   #$FFFFFFFF,D7 *Manually load some test data
               STOP     #$2700






*-----------------------------------NOP_EA------------------------------ 
*NOP doesn't actually have an ea but hey you gotta start somewhere

nop_ea      


               END   $400 


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

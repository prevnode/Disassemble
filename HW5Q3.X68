*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------


        
START:         ORG    $8888                


*--------------GET INPUT------------------------------------------ 

HEXMSG         LEA      GETHEXMSG,A1
               MOVE.B   #14,D0
               TRAP     #15
               
GETHEX         MOVE.B   #2,D0
               TRAP     #15
               
               CMP.B    #8,D1
               CLR.B    D1
               MOVE.B   #0,D1
               BEQ      ASCIITOHEX
               BRA      INVALIDINPUT
               
*--------------GET INPUT------------------------------------------

 
             
*-----------------CONVERT ASCII TO HEX----------------------------               

ASCIITOHEX     CMP.B    #8,D1          
               BLT      CONVERT
               MOVE.L   D4,USERINPUT
               BRA      IEEE
                              
CONVERT        CLR.B     D5
               MOVE.B    (A1)+,D5
               CMPI.B    #$40, D5
               BLT       CONVERTNUM
               BRA       CONVERTLETTER
                         
CONVERTNUM     SUBI.B    #$30,D5
               LSL.L     #4,D4
               ADD.B     D5,D4
               ADDI.B    #1,D1
               BRA       ASCIITOHEX
              
CONVERTLETTER  SUBI.B    #$37,D5
               LSL.L     #4,D4
               ADD.B     D5,D4
               ADDI.B    #1,D1
               BRA       ASCIITOHEX

*-----------------CONVERT ASCII TO HEX----------------------------

 
 
*-----------------DETERMINE IEEE---------------------------- 
IEEE           MOVE.L   USERINPUT, D4
               JSR      SIGN
               JSR      EXPONENT
               JSR      MANTISSA
               BRA      EXITPROGRAM
                              
SIGN           MOVE.L    D4,D5
               MOVE.L    #31,D2
               LSR.L     D2,D5
               CMP.B     #0,D5
               BEQ       PRINTPOS
               
               LEA      NEGSIGNMSG, A1
               MOVE.B   #14,D0
               TRAP     #15

               RTS
               
PRINTPOS       LEA      POSSIGNMSG, A1
               MOVE.B   #14,D0
               TRAP     #15 

               RTS     

EXPONENT       MOVE.L    D4,D5
               LSL.L    #1,D5
               MOVE.L   #24,D2
               LSR.L    D2,D5

               LEA      EXPONENTMSG, A1
               MOVE.B   #14,D0
               TRAP     #15
               
               CLR.L    D1
               MOVE.W   D5,D1
               MOVE.B   #3,D0
               TRAP     #15
               
               LEA      NL, A1
               MOVE.B   #14,D0
               TRAP     #15

               RTS 


MANTISSA       MOVE.L   D4,D5
               MOVE.L   #9,D2
               LSL.L    D2,D5
               LSR.L    D2,D5
               CLR.L    D0
               MOVE.B   #22,D0
               JSR      COUNTMANTISSA
  
               LEA      MANTISSAMSG, A1
               MOVE.B   #14,D0
               TRAP     #15
               
               CLR.L    D1
               MOVE.W   D7,D1
               MOVE.B   #3,D0
               TRAP     #15

               RTS      
               
COUNTMANTISSA  MOVE.L   D5,D6
               CMPI     #0,D0
               BGT      LOOP
               
               RTS
               
LOOP           LSR.L    D0,D6
               ANDI     #%00000000000000000000001, D6
               CMPI     #1,D6
               BEQ      INCREMENT
               SUBI     #1,D0
               BRA      COUNTMANTISSA
               
INCREMENT      ADDI     #1,D7
               SUBI     #1,D0
               BRA      COUNTMANTISSA
                          


*-------------------OUTPUT-----------------------------------------
CR             EQU       $0D
LF             EQU       $0A
   
GETHEXMSG      DC.B     'Enter a 8 digit IEEE floating point number in hex:  ',0
NOT8CHARMSG    DC.B     'That is not 8 characters ',CR,LF,0
NEGSIGNMSG     DC.B     'Sign Bit: -',CR,LF,0
POSSIGNMSG     DC.B     'Sign Bit: +',CR,LF,0
NL             DC.B     '',CR,LF,0
EXPONENTMSG    DC.B     'Exponent: ',0
MANTISSAMSG    DC.B     'Mantissa: ',0

*-------------------OUTPUT-----------------------------------------

INVALIDINPUT  LEA      NOT8CHARMSG,A1
              MOVE.B   #14,D0
              TRAP     #15
              
EXITPROGRAM

USERINPUT     DS.L  1
    END    START        ; last line of source


*               MOVE.B   (A1),D2
*               CLR.W    D2
*               MOVE.B   (A1),D2
*               MOVE.W   D2, $2000
*               MOVE.W   $2000, D4




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

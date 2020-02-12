
#include "p16f887.inc"

; CONFIG1
; __config 0x20F4
 __CONFIG _CONFIG1, _FOSC_INTRC_NOCLKOUT & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_OFF & _IESO_OFF & _FCMEN_OFF & _LVP_OFF
; CONFIG2
; __config 0xFFFF
 __CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF
;Defining the Macros or variables
    COUNT_1 EQU 0x20
    COUNT_2 EQU 0x21
    COUNT_3 EQU 0X22
RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

; TODO ADD INTERRUPTS HERE IF USED

MAIN_PROG CODE                      ; let linker place main program

START
 ;Switching to Bank1
 BSF STATUS,RP0  ;Moving to Bank 1 for the Initilisation of PORTA,PORTB,PORTC
 BCF STATUS,RP1 ; 
 CLRF TRISA      ;Setting PORTA as Output
 CLRF TRISB	 ;Setting PORTB as Output
 CLRF TRISC	 ;Setting PORTC as Output
 MOVLW 0X60
 MOVWF OSCCON
 ;Switching back to Bank0
 BCF STATUS,RP1  ;Moving to Bank 0 for the Initilisation of PORTA,PORTB,PORTC
 BCF STATUS,RP0  ;
 CLRF PORTA      ;Clearing PORTA  
 CLRF PORTB	 ;Clearing PORTB 
 CLRF PORTC	 ;Clearing PORTC 
 AGAIN                         ; loop forever
    MOVLW 0xFF	 ;
    MOVWF PORTA	 ;Making PORTA all Pins High 
    MOVLW 0xFF	 ;
    MOVWF PORTB	 ;Making PORTB all Pins High 
    MOVLW 0xFF	 ;
    MOVWF PORTC	 ;Making PORTB all Pins High 
    CALL Delay   
    MOVLW 0x00	 ;
    MOVWF PORTA	 ;Making PORTA all Pins Low 
    MOVLW 0x00	 ;
    MOVWF PORTB	 ;Making PORTB all Pins Low 
    MOVLW 0x00	 ;
    MOVWF PORTC	 ;Making PORTB all Pins Low 
    CALL Delay
    GOTO AGAIN
    
  ;Delay sub-routine
          ORG 24H
  Delay 
	  MOVLW D'20'
	  MOVWF COUNT_3
    LOOP1 MOVLW D'100'
	  MOVWF COUNT_2
    LOOP2 MOVLW D'250'
	  MOVWF COUNT_1
    LOOP3 NOP
	  NOP
	  DECF  COUNT_1,F
	  BNZ   LOOP3
	  DECF  COUNT_2,F
	  BNZ   LOOP2
	  DECF  COUNT_3,F
	  BNZ   LOOP1
  RETURN  
    
    
END

	    
    
    
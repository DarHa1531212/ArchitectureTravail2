
;*******************************************************************************
;                                                                              *
;    Filename:	main.asm                                                       *
;    Date:  25 oct 2018                                                        *
;    File Version: 0.0.0.1                                                     *
;    Author:	Hans Darmstadt-Bélanger                                        *
;    Company: N/A                                                              *
;    Description:   Un programme de multiplication de deux		       *
;		chiffres à virgule flottante                                   *
;                                                                              *
;*******************************************************************************
;                                                                              *
;    Revision History:							       *
;		25 oct 2018: première version				       *
;                                                                              *
;*******************************************************************************

; TODO PLACE VARIABLE DEFINITIONS GO HERE
LIST	p=18F4680 
    
CONFIG	OSC = ECIO   
CONFIG	FCMEN = OFF        
CONFIG	IESO = OFF       
CONFIG	PWRT = ON           
CONFIG	BOREN = OFF        
CONFIG	BORV = 2          
CONFIG	WDT = OFF          
CONFIG	WDTPS = 256       
CONFIG	MCLRE = ON          
CONFIG	LPT1OSC = OFF      
CONFIG	PBADEN = OFF        
CONFIG	STVREN = ON     
CONFIG	LVP = OFF         
CONFIG	XINST = OFF       
CONFIG	DEBUG = OFF       

#include	 <p18f4680.inc>				

ZERO_EQU	equ	0x00	
	
Zone_udata1	udata 0x60 					

    A_octet3  res  1
    A_octet2  res  1
    A_octet1  res  1
    A_octet0  res  1
    B_octet3  res  1    
    B_octet2  res  1
    B_octet1  res  1
    B_octet0  res  1
  
Zone_udata2 udata 0x80  

   A_signe  res  1
   A_exposant  res  1 
   A_fraction  res  1
   B_signe  res  1
   B_exposant  res  1
   B_fraction  res  1
   Temporaire_octet3 res 1
   Temporaire_octet2 res 1
   Temporaire_octet1 res 1
   Temporaire_octet0 res 1
   Resultat_octet3 res 1
   Resultat_octet2 res 1
   Resultat_octet1 res 1
   Resultat_octet0 res 1
	
RST_CODE 	code 000h 	
				
	goto Start		

PRG_CODE 	code 020h	

Start	

;*******************************************************************************
; Reset Vector
;*******************************************************************************

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program



; TODO INSERT ISR HERE

;*******************************************************************************
; MAIN PROGRAM
;*******************************************************************************

MAIN_PROG CODE                      ; let linker place main program

 ;Nom: Hans Darmstadt-Bélanger
 START
 ; nbreA    =	18
 ;	    =	01000001
 movlw b'01000001'
 movwf A_octet3
 
 ;		10010000
 movlw b'10010000'
 movwf A_octet2

 ;		00000000
 
 movlw b'00000000'
 movwf A_octet1
 ;		00000000
 
 movlw b'00000000'
 movwf A_octet0
 
 ; nbreB    =	9.5
 ;	    =	01000001
 movlw b'01000001'
 movwf B_octet3
 
 ;		00011000
 movlw b'00011000'
 movwf B_octet2

 ;		00000000
 movlw b'00000000'
 movwf B_octet1
 
 ;		00000000
 movlw b'00000000'
 movwf B_octet0

;Nom: Hans Darmstadt-Bélanger
;But: à partir de l'octet A_octet3, déterminer si le nombre est positif ou négatif
ExtraireSigneNombreA


 
ExtraireExposantNombreA
 
ExtraireFractionNombreA
 
ExtraireSigneNombreB
 
ExtraireExposantNombreB
 
ExtraireFractionSigneB
 
AdditionnerExposants
 
MultiplierFractions
 
NormaliserLeResultat
 
EcrireResultatFinal
    END
    
    
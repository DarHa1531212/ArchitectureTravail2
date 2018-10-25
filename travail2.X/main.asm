
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

PRG_CODE	code 020h

 ;Nom: Hans Darmstadt-Bélanger
Start
  
 goto InitialiserVariablesAZero
 
 
  
  ;Nom: Hans Darmstadt-Belanger
  ;But: Initialiser les différents octets
InitialiserVariablesAEtB
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
 
 goto ExtraireSigneNombreA
 

 ;Nom: Hans Darmstadt-Bélanger
 ;But: initialiser toutes les variables déclarées à 0
InitialiserVariablesAZero
 clrf WREG
 movwf  A_signe
 movwf  A_exposant
 movwf A_fraction
 movwf B_signe
 movwf B_exposant
 movwf B_fraction
 movwf B_fraction
 movwf Temporaire_octet3
 movwf Temporaire_octet3
 movwf Temporaire_octet2
 movwf Temporaire_octet1
 movwf Temporaire_octet0
 movwf Resultat_octet3
 movwf Resultat_octet2
 movwf Resultat_octet1
 movwf Resultat_octet0
  
  goto InitialiserVariablesAEtB
	
;Nom: Hans Darmstadt-Bélanger
;But: à partir de l'octet A_octet3, déterminer si le nombre est positif ou négatif
ExtraireSigneNombreA
 BTFSC A_octet3, 7
 BSF  A_signe, 0
 goto ExtraireSigneNombreB
 
;Nom: Hans Darmstadt-Bélanger
 ;But: sous-routine qui trouve l'exposant du nombre A
ExtraireExposantNombreA
 movff A_octet3, A_exposant
 rlncf A_exposant
 ;teste le bit  7 de l'octet A_octet2, si 0, sauter la prochaine ligne
 ;assigner 0 au bit 0 de A_exposant
  BTFSC A_octet2, 7
 bsf  A_exposant, 0
  
  BTFSS A_octet2, 7
 bcf A_exposant, 0
 
ExtraireFractionNombreA
 
;Nom: Hans Darmstadt-Bélanger
;But: à partir de l'octet B_octet3, déterminer si le nombre est positif ou négatif
ExtraireSigneNombreB
    BTFSC B_octet3, 7
   BSF B_signe, 0
    goto ExtraireExposantNombreA
 
ExtraireExposantNombreB
 
ExtraireFractionSigneB
 
AdditionnerExposants
 
MultiplierFractions
 
NormaliserLeResultat
 
EcrireResultatFinal
    END
    
    
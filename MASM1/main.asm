;--------------------------------------------------------------
;CMPR 154 - Fall 2023
;Team Name: Death Eaters
;Team Member Names: Genesis Bejarano, Guadalupe Roman Sanchez, Albert H, Abby 
;Creation Date: 
;Collaboration: 
;
;--------------------------------------------------------------
 
INCLUDE Irvine32.inc

.data  ; VARIABLES FOR THIS PROJECT!!

mainMenu BYTE "*** Death Eaters ***",0dh, 0ah, 0dh, 0ah, 0dh, 0ah,
			  "*** MAIN MENU ***",0dh, 0ah, 0dh, 0ah,
			  "Please Select one of the following: ",0dh, 0ah, 0dh, 0ah,
			  "	1: Display my available credit ",0dh, 0ah,
			  "	2: Add credits to my account ",0dh, 0ah,
			  "	3: Play the guessing game ",0dh, 0ah,
			  "	4: Display my statistics ",0dh, 0ah,
			  "	5: To exit",0dh, 0ah,
			  "	Choice : ",0

displayMaxError BYTE "=> ERROR: Maximum allowable credit is $20.00. TRY AGAIN!",0

				  
menuOpt1 BYTE "=> Your available balance is : $",0
menuOpt2 BYTE "=> Please enter the amount you would like to add : $",0

option2VALID BYTE "=> Credits added to account. . . ",0


balance WORD 0		; initlize the balance to 0 
MAXB	DWORD 20	; max credit is 20 
amount  WORD 0		; User's input 
countGuesses WORD 0 ; user's total of guesses

menuChoice WORD ? 	; 


menuERROR BYTE "ERROR: Invalid Input must be from 1-5. TRY AGAIN! ", 0 

randVal DWORD 10
displayGuessMessage BYTE "Enter your guess: ",0
displayWinMessage BYTE "Congratulations, you guessed correctly!",0
 
.code
main PROC

read: 
	call clrscr  ; clear screen 

	mov edx,OFFSET mainMenu     ; calling the main menu
	call WriteString			; displays the main menu

	;;;;;;;;;;;;;;   validate user input  menuChoice       ;;;;;;;;;;;;;;;;;;;

	call ReadInt				; Now we need to read the user input 
	cmp eax, 1
	jl badInput						
	cmp eax, 5
	ja badInput					
	jno goodInput				; validates it 

badInput: 
	mov edx, OFFSET menuERROR	; display ERROR 
	call WriteString 
	mov eax, 1500				; delay 3 seconds 
	call Delay
	jmp read					; go input again

goodInput:
	mov menuChoice, ax			; store good value

	
	COMMENT !

		Here we are going to check what the user inputed
		and jump to where needed. 
	!

	cmp eax, 1
	je option1					;  jump to option 1


	cmp eax, 2
	je option2					; jump to option 2

	
	cmp eax, 3 
	je option3					; jump to option 3

	
	cmp eax, 4 
	je option4					; jump to option 4
	
	cmp eax, 5 
	je option5					; jump to option 5

	COMMENT !

				WRITE THE OPTIONS 1-5 UNDER THIS COMMENT BLOCK

	!


option1: 
	call Clrscr
	mov edx,OFFSET menuOpt1     ;calling the main menu
	call WriteString
	mov ax, balance				
	call WriteDec				


	mov eax, 2500				; delay 3 seconds 
	call Delay

	jmp read					; go back to main menu


option2:
	call Clrscr
	mov edx,OFFSET menuOpt2    ;calling the main menu
	call WriteString
	
grabInput:

	call ReadDec               ;grabbing user input

	cmp eax, 20			       ; if ( eax <=20 )	
	jbe validAmount	

	
	mov edx, OFFSET displayMaxError		; display ERROR 
	call WriteString 
	mov eax, 2000						; delay 2 seconds 
	call Delay
	jmp option2							; go input again

validAmount:
	
	mov amount, ax				        ; get the total amount 
    add balance, ax						; add the amount into balance 

	
	mov edx, OFFSET option2VALID		; display we got their amount  
	call WriteString 
	mov eax, 2000						; delay 2 seconds 
	call Delay

	jmp read 


option3:
	;--------------Display Balance---------------------
	call Clrscr
	mov edx,OFFSET menuOpt1     ;calling the main menu
	call WriteString
	
	;--------Generating Random Number-------
	mov eax,0010
	call RandomRange
	inc eax
	mov randVal,eax
	call dumpRegs
	mov eax, randVal
	
	call WriteDec				


	mov eax, 2500				; delay 3 seconds 
	call Delay


	;---------Grab user input---------------------
	;displayGuessMessage
	mov edx, OFFSET displayGuessMessage		; display Guess message

	call WriteString 
	mov eax, 2000						; delay 2 seconds 
	call Delay
	;Grab user guess
	mov eax, 0
	call readDec

	;-----------Cmp Guess---------------

	;Comparing random value with user guess
	cmp eax, randVal
	
	;jump if equal WIN

	je Win


	mov eax, 2500				; delay 3 seconds 
	call Delay

	
	;cmp with 






	jmp read					; go back to main menu


Win:
	mov edx, OFFSET displayWinMessage		; display Win message

	call WriteString 
	mov eax, 2000						; delay 2 seconds 
	call Delay
	jmp read 



option4:


option5:
	call Clrscr							; Clear Screen
	exit								; exit


exit

main endp
end main
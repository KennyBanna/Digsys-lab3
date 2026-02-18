;
; lab3_2.asm
;
; Created: 2026-02-16 11:19:06
; Author : Oskar
;


; Replace with your application code



;
; lab3_2.asm
;
; Created: 2026-02-16 11:19:06
; Author : Oskar
;


; Replace with your application code

; 2.2 How do you allocate 5 bytes on the stack?
; n the subroutine, sample the state of the buttons B1 to B6 in a loop and save the five latest in the
/*array. The first sample shall be placed at index zero (arr[0]), the fifth sample at index four. After
saving the values, simply return from the subroutine.
? Remember that when you borrow something, you must return it.
• In the main function, call your subroutine in a forever-loop.
• Start the debugger and step through each sample to verify that you can read the values of the buttons.
Also check the stack to verify that the samples are placed at the correct addresses.*/

#define STACK_H 0x3E ; Address to the high byte of the stack pointer
#define STACK_L 0x3D ; Low 

#define XL r26
#define XH r27
#define YL r28
#define YH r29
#define ZL r30
#define ZH r31

; Address to Button 1-6 on the card
#define PINA 0x00
#define DDRA 0x01

start:
	ldi r16, 0x00
	out DDRA, r16 ; DDRA = 0b00000000

loop:
	call sample_buttons
	rjmp loop

sample_buttons:
	; Allocate space on stack
	push XL
	push XH
	in XL, STACK_L
	in XH, STACK_H
	sbiw X, 5
	out STACK_L, XL
	out STACK_H, XH
	
	; ======================
	in r16, PINA
	ldi r17, ~(1 << 0)   ; Load bitmask for button 1 (index 0)
	and r16, r17
	st X+, r16

	in r16, PINA
	ldi r17, ~(1 << 1)   ; Load bitmask for button 2 (index 1)
	and r16, r17
	st X+, r16
	
	in r16, PINA
	ldi r17, ~(1 << 2)   ; Load bitmask for button 3 (index 2)
	and r16, r17
	st X+, r16

	in r16, PINA
	ldi r17, ~(1 << 3)   ; Load bitmask for button 3 (index 2)
	and r16, r17
	st X+, r16

	in r16, PINA
	ldi r17, ~(1 << 4)   ; Load bitmask for button 3 (index 2)
	and r16, r17
	st X+, r16
	; ======================

	; Epilogue
	in XL, STACK_L
	in XH, STACK_H
	adiw X, 5
	out STACK_L, XL
	out STACK_H, XH
	pop XL
	pop XH
	ret

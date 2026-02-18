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

; 2.1 How do you allocate 10 integers on the stack?
#define STACK_H 0x3E ; Address to the high byte of the stack pointer
#define STACK_L 0x3D ; Low 

#define XL r26
#define XH r27
#define YL r28
#define YH r29
#define ZL r30
#define ZH r31

start:
    inc r16
	rjmp start
	call func
end:
	jmp end


func:
	push XL 
	push XH
	in XL, STACK_L
	in XH, STACK_H
	sbiw X, 20
	out STACK_L, XL
	out STACK_H, XH

// zero-init function stack
	ldi r16, 20
	func_zero_init_loop:
		ld X, 0
		adiw X, 1
		subi r16, 2
		brne func_zero_init_loop


	in XL, STACK_L
	in XH, STACK_H
	adiw X, 20
	out STACK_L, XL
	out STACK_H, XH
	ret
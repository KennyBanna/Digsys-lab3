;
; lab3_1_hello.asm
;
; Created: 2026-02-13 16:46:12
; Author : Oskar
;


; Replace with your application code

#define PORTB 0x05	; LED port on the circuit board TODO todo vilken port
#define DDRB 0x04   ; Data direction TODO vilke port 


start:
	ldi r16, 0xff
	out DDRB, r16

blink:
	call delay_0_1s
	; Set 2nd pin of LED
	in   r16, PORTB
	ldi  r17, (1 << 3)
	eor	 r16, r17
	out  PORTB, r16

	jmp blink

delay_0_1s:   ; delay 0.1s
	ldi r22, 5 ; napkin math 5 * 9 cycles = 45 cycles = 
	ldi r23, 0 ; 256
	ldi r24, 0 ; 256

outer_loop:  ; clock cycles: 2 + (325 125 * 5) = 1 625 627 cycles = CLOSE ENOUGH
	dec r22
	breq done
middle_inner: ; clock cycles per run: 255 * 1275 = 325 125 cycles
	dec r23
	breq outer_loop
inner_loop:  ; clock cycles per run: 5 * 255 = 1275 cycles
	dec r24
	breq middle_inner
	jmp inner_loop
done:
	ret

/*
 * lab3_3.S
 *
 * Created: 2026-02-18 11:25:10
 *  Author: Oskar
 */ 

#define PINA  0x00
#define DDRA  0x01 // Probably not needed?
#define DDRB  0x004
#define PORTB 0x005

.global led_on
.global led_off
.global check_button

; input argument is in r24 (r25 not used)
/*shift:
	ld r22, r24
	shift_loop:
		breq 

		ret*/

left_shift:
	ldi r16, 1					; Let r16 be the bit mask, starting at 0 (0b00000001) 
	left_shift_loop:
		cpi r24, 0				; If r24, input value is 0, (we shift 0 times more)
		breq left_shift_done	; If the value is 0 we are done
		lsl r16					; Else we left shift the bitmask
		dec r24					; and decrement r24
		rjmp left_shift_loop

left_shift_done:
	ret

led_on:
	in r23, PORTB				; read state of leds

	call left_shift				; get bitmask 
	
	or r23, r16           
	out PORTB, r23				; output
	ret

led_off:
	in r23, PORTB				; read state of leds
	call left_shift				; get bit mask

	ldi r17, 0xff
	eor r16, r17				; invert the bits (for example 0b10000000 becomes 0b01111111)
	and r23, r16				; use bitwise AND with mask to set LED off
	out PORTB, r23
	ret

check_button:
	in r23, PINA				; read state of button
	call left_shift				; get bit mask

	lsl r16
	lsl r16
	and r23, r16				; button read AND bit mask for button				
	brne button_is_pressed
	rjmp button_is_not_pressed
	
button_is_pressed:
	ldi r24, 1
	ret

button_is_not_pressed:
	ldi r24, 0
	ret

/*
Lab Question 3.1
When calling the subroutine, led_on, what is being pushed to the stack and why?
- The return address of previous PC


Lab Question 3.2
When the ret instruction is executed, what happens with the stack pointer?

- It increment back to it's previous value (started at 0x40fd, then popped back there)


Lab Question 3.3
In the check_button subroutine, comment out the instruction where you place the return value
in r24 and run the code. Does the LED blink? If so, why?

	it doesn't blink
	The value at r24 is used in the left shift subroutine where it gets set to 0, so it will always "return false" so led_on never runs	
	
*/

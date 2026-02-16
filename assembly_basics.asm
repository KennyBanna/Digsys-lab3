Lab 3 digsys

1.1 Write an assembly program that load the values 3 and 4 into r16 an r17
add the result to r17

ldi r16, 3
ldi r17, 4
add r17, r16

1.2 Assume a user have entered their age in a program. The value is stored in register r16. Write a
program such that if the age is above or equal to 18, you store the value 1 in register r24, otherwise
you store the value 2 in r24. After the check, you shall just enter an infinite loop.

checkAge:
    ld r17, r16 // load r17 with what is in r16
    sub r17, 18 // load the difference between r17 and the val 18 to r17
    brlo lower
    ldi r24, 1
    rjmp end
    
lower: 
    ldi r24, 2

end:
    rjmp end


1.3 Write a program that checks if a button is pressed. If it is, an LED shall be turned on, otherwise the
LED shall be turned off. The button is connected on pin 2 (3rd pin) at address 0x12. The LED is
connected on pin 1 (2nd pin) at address 0x15. Remember to not change the other pins as they may
be used for other devices. The code should run in an infinite loop.


#define BTN 0x12
#define LED 0x15
#define BTN_PIN 3 
#define LED_PIN 2

loop:
    ld r23, BTN // Loads r23 with value at button on adress 0x12
    ldi r24, (1 << BTN_PIN)
    and r23, r24
    breq off       // Button was not pushed
    rjmp on

off:
    ldi r23, LED                // Load the current value of LED
    ldi r24, ~(1 << LED_PIN)    // Bit mask for and operation
    and r23, r24
    out LED, r23                // Load value back onto LED
    rjmp loop  

on: 
    ld r23, LED
    ld r24, (1 << LED_PIN)
    or r23, r24
    out LED r23
    rjmp loop

1.4 Translate the following C program into AVR assembly. Assume that the global variable input is
located in register r20, and that a is located in register r24.

# include <avr/io.h>

char input;
int main()

{
    uint8_t a;

    if (input < 12) {
        a = 3;
    } else if (input == 12) {
        a = 2;
    } else {
        a = 5; // input > 12
    }
    while (1); // infinite loop
}

#define INPUT, r20
#define a, r24

main: 
    ld r16, INPUT       // Load r16 with the value of input
    ldi r17, 12         // Load r17 with 12
    sub r16, r17        // r16 = r16 - 12
    breq equal          // == 0
    brlo lower          // < 0
    
    ld a, 5             // > 0
	rjmp end

equal:
    ld a, 2
    rjmp end

lower:
    ld a, 3

end:
    rjmp end    


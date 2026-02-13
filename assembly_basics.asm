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
    rjmp end


end:
    rjmp end


1.3 Write a program that checks if a button is pressed. If it is, an LED shall be turned on, otherwise the
LED shall be turned off. The button is connected on pin 2 (3rd pin) at address 0x12. The LED is
connected on pin 1 (2nd pin) at address 0x15. Remember to not change the other pins as they may
be used for other devices. The code should run in an infinite loop.

1.3 Write a program that checks if a button is pressed. If it is, an LED shall be turned on, otherwise the
LED shall be turned off. The button is connected on pin 2 (3rd pin) at address 0x12. The LED is
connected on pin 1 (2nd pin) at address 0x15. Remember to not change the other pins as they may
be used for other devices. The code should run in an infinite loop.
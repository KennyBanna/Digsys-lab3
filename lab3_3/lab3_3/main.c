/*
 * lab3_3.c
 *
 * Created: 2026-02-18 11:11:00
 * Author : Oskar
 */ 

#define F_CPU 16000000
#include <avr/io.h>
#include <util/delay.h>

extern char led_on(char);
extern char led_off(char);
extern char check_button(char);


int main(void)
{
	char led_val = 3;
	char button_val = 1;
	DDRA = 0x00;
	DDRB = 0xff; // initialize LEDs
	
    /* Replace with your application code */
    while (1) 
    {
		char button_state = check_button(button_val);
		if(button_state > 0){
			led_on(led_val);
			_delay_ms(500);
			led_off(led_val);
			_delay_ms(500);	
		}
	}
}



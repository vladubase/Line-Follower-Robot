/****
	*	@name		DMotor_linefollower
	*	@file 		InitTIM.c
	*
	*	@author 	Uladzislau 'vladubase' Dubatouka
	*				<vladubase@gmail.com>
	*	@version	V1.0
	*	@date 		02-February-2021
	*	@link		https://github.com/vladubase/Line-Follower-Robot
	*
*****/


/************************************** Includes **************************************/

#include <avr/io.h>


/************************************** Function **************************************/

void InitTIM (void) {
	// Motors
	// Output mode
	DDRB |= (1 << DDB3);	// OC2A
	DDRD |= (1 << DDD6) |	// OC0A
			(1 << DDD5) |	// OC0B
			(1 << DDD3);	// OC2B
	
	// Timer/Counter(s) initialization
	// Timer/Counter 0
	// Fast PWM Mode
	// Clear OC0A on Compare Match, set OC0A at BOTTOM (non-inverting mode)
	// TOP = 0xFF
	// Prescaler: 1:64
	TCCR0A |= (1 << COM0A1) | (1 << COM0B1) | (1 << WGM01) | (1 << WGM00);
	TCCR0A &= ~((1 << COM0A0) | (1 << COM0B0) | (1 << 3) | (1 << 2));
	TCCR0B |= (1 << CS01) | (1 << CS00);
	TCCR0B &= ~((1 << FOC0A) | (1 << FOC0B) | (1 << 5) | (1 << 4) | (1 << WGM02) | (1 << CS02));
	TCNT0  = 0x00;
	TIMSK0 = 0x00;
	OCR0A  = 0x00;	OCR0B  = 0x00;

	// Timer/Counter 2
	// Fast PWM Mode
	// Clear OC0A on Compare Match, set OC0A at BOTTOM (non-inverting mode)
	// TOP = 0xFF
	// Prescaler: 1:64
	TCCR2A |= (1 << COM2A1) | (1 << COM2B1) | (1 << WGM21) | (1 << WGM20);
	TCCR2A &= ~((1 << COM2A0) | (1 << COM2B0) | (1 << 3) | (1 << 2));
	TCCR2B |= (1 << CS22);
	TCCR2B &= ~((1 << FOC2A) | (1 << FOC2B) | (1 << 5) | (1 << 4) | (1 << WGM22) | (1 << CS21) | (1 << CS20));
	TCNT2  = 0x00;
	TIMSK2 = 0x00;
	OCR2A  = 0x00;	OCR2B  = 0x00;
}

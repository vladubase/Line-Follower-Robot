/****
	*	@name		DMotor_linefollower
	*	@file 		InitSYS.c
	*
	*	@author 	Uladzislau 'vladubase' Dubatouka
	*				<vladubase@gmail.com>
	*
*****/


/************************************** Includes **************************************/

#include "../inc/InitSYS.h"


/************************************** Function **************************************/

void InitSYS (void) {
	// Motors
	// Output mode
		DDRB |= (1 << DDB3);	// OC2A
		DDRD |= (1 << DDD6) |	// OC0A
				(1 << DDD5) |	// OC0B
				(1 << DDD3);	// OC2B

	// SensorLine
	// Input mode
		DDRB &= ~((1 << DDB2) | (1 << DDB1) | (1 << DDB0));
		DDRD &= ~(1 << DDD7);

	// Infrared Sensor
	// Input mode
		#ifdef READ_SENSOR_IR
			DDRx &= ~(1 << DDxx);
		#endif /* READ_SENSOR_IR */

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
	
	// Timer/Counter 1
	// Fast PWM 10-bit Mode
	// Clear OC1A/OC1B on Compare Match, set OC1A/OC1B at BOTTOM (non-inverting mode)
	// TOP = 0x03FF
	// Prescaler: 1:64
		TCCR1A |= (1 << COM1A1) | (1 << COM1B1) | (1 << WGM11) | (1 << WGM10);
		TCCR1A &= ~((1 << COM1A0) | (1 << COM1B0) | (1 << 3) | (1 << 2));
		TCCR1B |= (1 << WGM12) | (1 << CS11) | (1 << CS10);
		TCCR1B &= ~((1 << ICNC1) | (1 << ICES1) | (1 << 5) | (1 << WGM13) | (1 << CS12));
		TCCR1C = 0x00;
		TCNT1H = 0x00;	TCNT1L = 0x00;
		TIMSK1 = 0x00;
		ICR1H  = 0x00;	ICR1L  = 0x00;
		OCR1AH = 0x00;	OCR1AL = 0x00;
		OCR1BH = 0x00;	OCR1BL = 0x00;

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

	// Crystal Oscillator division factor: 1
		#pragma optsize-
			CLKPR |= (1 << CLKPCE);
			CLKPR = 0x00;
		#ifdef _OPTIMIZE_SIZE_
			#pragma optsize+
		#endif /* _OPTIMIZE_SIZE_ */
}

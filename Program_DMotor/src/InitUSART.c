/****
	*	@name		DMotor_linefollower
	*	@file 		InitUSART.c
	*
	*	@author 	Uladzislau 'vladubase' Dubatouka
	*				<vladubase@gmail.com>
	*	@version	V1.0
	*	@date 		02-February-2021
	*	@link		https://github.com/vladubase/Line-Follower-Robot
	*
*****/


/************************************** Includes **************************************/

#include "../inc/InitUSART.h"


/************************************** Function **************************************/

void InitUSART () {
	/* Set baud rate */
	UBRR0H = (uint8_t) (MYUBRR >> 8);
	UBRR0L = (uint8_t) MYUBRR;
	
	/* Enable receiver and transmitter */
	UCSR0B = (1 << RXEN0) | (1 << TXEN0);
	
	/* Set frame format: 8data, 2stop bit */
	UCSR0C = (1 << USBS0) | (3 << UCSZ00);
}

uint8_t USART_Receive (void) {
	/* Wait for data to be received */
	while (!(UCSR0A & (1 << RXC0)));
	
	/* Get and return received data from buffer */
	return UDR0;
}

void USART_Transmit(uint8_t data) {
	/* Wait for empty transmit buffer */
	while (!(UCSR0A & (1 << UDRE)));
	
	/* Put data into buffer, sends the data */
	UDR0 = data;
}

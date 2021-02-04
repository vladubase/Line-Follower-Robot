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
	/* Set baud rate 230400 */
	UBRR0 = 4;											// F_CPU / (USART_BAUD * 16) - 1.
	
	/* Enable receiver and transmitter */
	UCSR0B |= (1 << RXEN0) | (1 << TXEN0);
	
	/* Set frame format: 8data, 1 stop bit */
	UCSR0C |= (1 << UCSZ01) | (1 << UCSZ00);
}

uint8_t USART_ReceiveByte (void) {
	/* Wait for data to be received */
	while (!(UCSR0A & (1 << RXC0)));
	
	/* Get and return received data from buffer */
	return UDR0;
}

void USART_SendByte (uint8_t data) {
	/* Wait for empty transmit buffer */
	while (!(UCSR0A & (1 << UDRE0)));
	
	/* Put data into buffer, sends the data */
	UDR0 = data;
}

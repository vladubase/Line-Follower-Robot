#ifndef _INIT_USART_H_
#define _INIT_USART_H_

/****
	*	@name		DMotor_linefollower
	*	@file 		InitUSART.h
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


/*************************************** Defines **************************************/

#define	FOSC	(uint32_t) 20e6							// Clock Speed
#define	BAUD	(uint16_t) 9600
#define	MYUBRR	(uint8_t) FOSC / 16 / BAUD - 1

/********************************* Function  prototypes *******************************/

void InitUSART (void);
uint8_t USART_Receive (void);
void USART_Transmit(uint8_t data);


#endif /* _INIT_USART_H_ */

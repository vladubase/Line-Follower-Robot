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

#define	F_CPU		(uint32_t)	20e6									// Clock Speed
#define	USART_BAUD	(uint16_t)	230400

/********************************* Function  prototypes *******************************/

void InitUSART (void);
int8_t USART_ReceiveByte (void);
void USART_SendByte (int8_t data);


#endif /* _INIT_USART_H_ */

#ifndef _INIT_UART_H_
#define _INIT_UART_H_

/**
*	@name		STM32F0_UART
*	@file 		InitUART.h
*
*	@author 	Uladzislau 'vladubase' Dubatouka
*				<vladubase@gmail.com>
*	@version	V1.2
*	@date 		24-January-2021
*	@link		https://github.com/vladubase/STM32_Lib/tree/main/STM32F0/Projects/STM32F0_UART
*
*/


/************************************** Includes **************************************/

#include "stm32f0xx.h"
#include "stdint.h"
#include "stdbool.h"


/************************************** Defines ***************************************/

#define f_AHB			((uint32_t)	48e6)
#define USART1_BAUDRATE	((uint32_t)	230400)


/********************************* Function  prototypes *******************************/

void InitUART (void);
void InitUSART1 (void);
void USART1_SendByte (char chr);
void USART1_SendString (char* str);


#endif /* _INIT_UART_H_ */

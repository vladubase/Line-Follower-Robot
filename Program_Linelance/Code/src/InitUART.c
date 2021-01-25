/**
*	@name		Linelance_linefollower
*	@file 		InitUART.c
*
*	@author 	Uladzislau 'vladubase' Dubatouka
*				<vladubase@gmail.com>
*	@version	V1.0
*	@date 		25-January-2021
*	@link		https://github.com/vladubase/Line-Follower-Robot/tree/master/Program_Linelance
*
*/


/************************************** Includes **************************************/

#include "InitUART.h"


/************************************* Functions **************************************/

void InitUART (void) {
	InitUSART1 ();
}


/************************************** USART 1 ***************************************/

void InitUSART1 (void) {
/*
*	@brief	This function setup USART 1.
*	
*/
	
	RCC->AHBENR |= RCC_AHBENR_GPIOAEN;			// GPIOA clock enable.
	RCC->APB2ENR |= RCC_APB2ENR_USART1EN;		// USART1 clock enable.
	
	/* ************************** PA10 RX ************************ */
	// Alternate function mode.
	GPIOA->MODER |= GPIO_MODER_MODER10_1;
	
	// High speed.
	// @note	Refer to the device datasheet.
	GPIOA->OSPEEDR |= GPIO_OSPEEDER_OSPEEDR10;

	/* ************************** PA9  TX ************************ */
	// Alternate function mode.
	GPIOA->MODER |= GPIO_MODER_MODER9_1;
	
	// High speed.
	// @note	Refer to the device datasheet.
	GPIOA->OSPEEDR |= GPIO_OSPEEDER_OSPEEDR10;
	
	// GPIO alternate function.
	GPIOA->AFR[1] = (1 << (1 * 4)) |
		(1 << (2 * 4));
	
	USART1->CR1 |= USART_CR1_UE;				// USART Enable.
	USART1->CR1 &= ~USART_CR1_M;				// Word - 8 data bits.
	USART1->CR2 &= ~USART_CR2_STOP;				// 1 stop bit.
	USART1->BRR = (f_AHB + USART1_BAUDRATE / 2) / 
		USART1_BAUDRATE;						// 
	USART1->CR1 |= USART_CR1_RE |				// Receiver Enable.
		USART_CR1_TE;							// Transmitter Enable.
}

void USART1_SendByte (char chr) {
	while (!(USART1->ISR & USART_ISR_TC));		// Wait Transmission complete flag.
	
	USART1->TDR = chr;
}

void USART1_SendString (char* str) {
	uint8_t i = 0;
	
	while (str[i]) {
		USART1_SendByte (str[i++]);
	}
}

/****
	*	@name		Linelance_linefollower
	*	@file 		InitI2C.c
	*
	*	@author 	Uladzislau 'vladubase' Dubatouka
	*				<vladubase@gmail.com>
	*	@version	V1.0
	*	@date 		29-October-2020
	*
*****/


/************************************** Includes **************************************/

#include "InitI2C.h"


/************************************** Functions **************************************/

void InitI2C (void) {
   /*
	*	@brief	This function setup I2C.
	*	@param	None.
	*	@retval	None
	*/
	
	// GPIOA clock enable
	RCC->AHBENR |= RCC_AHBENR_GPIOAEN;
	
	// PA10..9:
	// Alternative function mode - I2C
	GPIOA->MODER |= GPIO_MODER_MODER10_1 | GPIO_MODER_MODER9_1;
	GPIOA->OSPEEDR |= GPIO_OSPEEDR_OSPEEDR10 | GPIO_OSPEEDR_OSPEEDR10;	// High speed
	RCC->APB1ENR |= RCC_APB1ENR_I2C1EN;									// Enable I2C1
	
}

void I2C_Start (void) {
   /*
	*	@brief	Generate START condition.
	*	@param	None.
	*	@retval	None
	*/
	
	
}

void I2C_Stop (void) {
   /*
	*	@brief	Generate STOP condition.
	*	@param	None.
	*	@retval	None
	*/
	
	
}

void I2C_SendByte (uint8_t byte) {
   /*
	*	@brief	Generate START condition.
	*	@param	A byte message.
	*	@retval	None
	*/
	
	
}

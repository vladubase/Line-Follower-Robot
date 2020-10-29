/****
	*	@name		Linelance_linefollower
	*	@file 		InitGPIO.c
	*
	*	@author 	Uladzislau 'vladubase' Dubatouka
	*				<vladubase@gmail.com>
	*	@version	V1.0
	*	@date 		29-October-2020
	*
*****/


/************************************** Includes **************************************/

#include "InitGPIO.h"


/************************************** Function **************************************/

void InitGPIO (void) {
   /*
	*	@brief	This function setup GPIO.
	*	@param	None.
	*	@retval	None
	*/
	
	RCC->AHBENR |= RCC_AHBENR_GPIOAEN;			// GPIOA clock enable
	RCC->AHBENR |= RCC_AHBENR_GPIOBEN;			// GPIOB clock enable
	
	// PA14..13:
	// Alternative function mode - SWD
	GPIOA->MODER |= GPIO_MODER_MODER14_1 | GPIO_MODER_MODER13_1;
	
	// PA7..0:
	// Analog mode
	GPIOA->MODER |= GPIO_MODER_MODER7 | GPIO_MODER_MODER6 | GPIO_MODER_MODER5 | GPIO_MODER_MODER4 |
		GPIO_MODER_MODER3 | GPIO_MODER_MODER2 | GPIO_MODER_MODER1 | GPIO_MODER_MODER0;
	
	// PB1:
	// General purpose output mode
	GPIOB->MODER |= GPIO_MODER_MODER1_0;
}

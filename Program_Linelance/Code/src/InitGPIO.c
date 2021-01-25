/**
*	@file 		InitGPIO.c
*
*	@author 	Uladzislau 'vladubase' Dubatouka
*				<vladubase@gmail.com>
*	@version	V1.1
*	@date 		11-November-2020
*	@link		https://github.com/vladubase/STM32_Lib/tree/main/STM32F0/Projects/STM32F0_GPIO
*
*/


/************************************** Includes **************************************/

#include "InitGPIO.h"


/************************************** Function **************************************/

void InitGPIO (void) {
/**
*	@brief	This function setup GPIO.
*			Port B1 as output 1.
*	@param	None.
*	@retval	None.
*/
	
	RCC->AHBENR |= RCC_AHBENR_GPIOBEN;			// GPIOB clock enable.
	
	
	/* **************************** PB1 ************************** */
	
	// General purpose output mode.
	GPIOB->MODER |= GPIO_MODER_MODER1_0;
	
	// Output push-pull (reset state).
	GPIOB->OTYPER &= ~GPIO_OTYPER_OT_1;
	
	// High speed.
	// @note	Refer to the device datasheet.
	GPIOB->OSPEEDR |= GPIO_OSPEEDER_OSPEEDR1;
}

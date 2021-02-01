/****
	*	@name		STM32F0_GPIO
	*	@file 		InitGPIO.c
	*
	*	@author 	Uladzislau 'vladubase' Dubatouka
	*				<vladubase@gmail.com>
	*	@version	V1.2
	*	@date 		10-January-2021
	*	@link		https://github.com/vladubase/STM32_Lib/tree/main/STM32F0/Projects/STM32F0_GPIO
	*
*****/


/************************************** Includes **************************************/

#include "InitGPIO.h"


/************************************** Function **************************************/

void InitGPIO (void) {
   /*
	*	@brief	This function setup GPIO.
	*			Port A7..0 as input.
	*/
	
	RCC->AHBENR |= RCC_AHBENR_GPIOAEN;			// GPIOA clock enable.
	
	
	/* ************************** PA7..0 ************************* */
	
	// General purpose input mode.
	GPIOA->MODER &= ~(GPIO_MODER_MODER7 | GPIO_MODER_MODER6 |
		GPIO_MODER_MODER5 | GPIO_MODER_MODER4 |
		GPIO_MODER_MODER3 | GPIO_MODER_MODER2 |
		GPIO_MODER_MODER1 | GPIO_MODER_MODER0);
	
	// Output push-pull (reset state).
	GPIOA->OTYPER &= ~(GPIO_OTYPER_OT_7 | GPIO_OTYPER_OT_6 |
		GPIO_OTYPER_OT_5 | GPIO_OTYPER_OT_4 |
		GPIO_OTYPER_OT_3 | GPIO_OTYPER_OT_2 |
		GPIO_OTYPER_OT_1 | GPIO_OTYPER_OT_0);
	
	// High speed.
	// @note	Refer to the device datasheet.
	GPIOA->OSPEEDR |= GPIO_OSPEEDER_OSPEEDR7 | GPIO_OSPEEDER_OSPEEDR6 |
		GPIO_OSPEEDER_OSPEEDR5 | GPIO_OSPEEDER_OSPEEDR4 |
		GPIO_OSPEEDER_OSPEEDR3 | GPIO_OSPEEDER_OSPEEDR2 |
		GPIO_OSPEEDER_OSPEEDR1 | GPIO_OSPEEDER_OSPEEDR0;
	
	// Pull-down.
	GPIOA->PUPDR |= GPIO_PUPDR_PUPDR7_1 | GPIO_PUPDR_PUPDR6_1 |
		GPIO_PUPDR_PUPDR5_1 | GPIO_PUPDR_PUPDR4_1 |
		GPIO_PUPDR_PUPDR3_1 | GPIO_PUPDR_PUPDR2_1 |
		GPIO_PUPDR_PUPDR1_1 | GPIO_PUPDR_PUPDR0_1;
}

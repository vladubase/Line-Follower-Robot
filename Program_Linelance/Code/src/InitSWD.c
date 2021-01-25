/****
	*	@file 		InitSWD.c
	*
	*	@author 	Uladzislau 'vladubase' Dubatouka
	*				<vladubase@gmail.com>
	*	@version	V1.0
	*	@date 		2-November-2020
	*	@link		https://github.com/vladubase/STM32_Lib/tree/main/STM32F0/Projects/STM32F0_SWD
	*
*****/


/************************************** Includes **************************************/

#include "InitSWD.h"


/************************************** Function **************************************/

void InitSWD (void) {
   /*
	*	@brief	This function setup Serial Wire Debug.
	*	@param	None.
	*	@retval	None
	*/
	
	RCC->AHBENR |= RCC_AHBENR_GPIOAEN;			// GPIOA clock enable
	
	// PA14..13:
	// Alternative function mode - SWD
	GPIOA->MODER |= GPIO_MODER_MODER14_1 | GPIO_MODER_MODER13_1;
}

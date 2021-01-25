/****
	*	@name		STM32F0_RCC_PLL_48MHz
	*	@file 		InitRCC.c
	*
	*	@author 	Uladzislau 'vladubase' Dubatouka
	*				<vladubase@gmail.com>
	*	@version	V1.2
	*	@date 		10-January-2021
	*	@link		https://github.com/vladubase/STM32_Lib/tree/main/STM32F0/Projects/STM32F0_RCC_PLL_48MHz
	*
*****/


/************************************** Includes **************************************/

#include "InitRCC.h"


/************************************** Function **************************************/

void InitRCC (void) {
   /*
	*	@brief	This function setup RCC. HSE will be used as PLL clock source.
	*			Use external crystal on 24 MHz. HCLK output is 48 MHz.
	*/

	/* Test if PLL is used as System clock */
	if ((RCC->CFGR & RCC_CFGR_SWS) == RCC_CFGR_SWS_PLL) {
		RCC->CFGR &= (uint32_t) (~RCC_CFGR_SW);	// Select HSI as system clock.
		while ((RCC->CFGR & RCC_CFGR_SWS) != 	// Wait for HSI switched.
			RCC_CFGR_SWS_HSI);
	}
	
	RCC->CR |= (uint32_t)RCC_CR_PLLON; 			// External High Speed clock enable.
	while (!(RCC->CR & RCC_CR_PLLRDY));			// External High Speed clock ready flag.
	
	RCC->CFGR |= RCC_CFGR_HPRE_DIV1 |			// SYSCLK not divided. AHB = SYSCLK.
		RCC_CFGR_PPRE_DIV1;						// APB = SYSCLK.
	
	RCC->CFGR |= RCC_CFGR_PLLSRC_PREDIV1 | 		// PREDIV1 clock selected as PLL entry clock source.
		RCC_CFGR_PLLXTPRE_PREDIV1 | 			// PREDIV1 clock not divided for PLL entry.
		RCC_CFGR_PLLMULL2; 						// PLL input clock * 2: 24 MHz * 2 = 48 MHz.
	
	RCC->CR |= RCC_CR_PLLON;					// PLL enable.
	while(!(RCC->CR & RCC_CR_PLLRDY));      	// PLL clock ready flag.
	
	/* System clock MUX - PLLCLK */
	RCC->CFGR |= (uint32_t)RCC_CFGR_SW_PLL;		// Select source SYSCLK = PLL.
	while((RCC->CFGR & (uint32_t)RCC_CFGR_SWS) !=	// Wait till PLL is used.
		(uint32_t)RCC_CFGR_SWS_PLL);
	
	/* Configure Flash */
	FLASH->ACR = FLASH_ACR_PRFTBE |				// Prefetch buffer enable.
		FLASH_ACR_LATENCY;						// One wait state as 24 MHz < SYSCLK = 48 MHz.
}

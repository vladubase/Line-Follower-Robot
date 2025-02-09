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
	*	@brief	This function setup RCC. HSI will be used as PLL clock source.
	*			HCLK output is 48 MHz.
	*/

	/* Test if PLL is used as System clock */
	if ((RCC->CFGR & RCC_CFGR_SWS) == RCC_CFGR_SWS_PLL) {
		RCC->CFGR &= (uint32_t) (~RCC_CFGR_SW);	// Select HSI as system clock.
		while ((RCC->CFGR & RCC_CFGR_SWS) != 	// Wait for HSI switched.
			RCC_CFGR_SWS_HSI);
	}
	
	RCC->CR &= (uint32_t) (~RCC_CR_PLLON);		// Disable the PLL.
	while ((RCC->CR & RCC_CR_PLLRDY) != 0);		// PLL clock ready flag.
	
	RCC->CR |= (uint32_t)RCC_CR_HSION; 			// Internal High Speed clock enable.
	while (!(RCC->CR & RCC_CR_HSIRDY));			// Internal High Speed clock ready flag.
	
	RCC->CFGR |= RCC_CFGR_HPRE_DIV1 |			// SYSCLK not divided. AHB = SYSCLK.
		RCC_CFGR_PPRE_DIV1;						// APB = SYSCLK.
	
	RCC->CFGR |= RCC_CFGR_PLLSRC_PREDIV1 | 		// PREDIV1 clock selected as PLL entry clock source.
		RCC_CFGR_PLLXTPRE_PREDIV1 | 			// PREDIV1 clock not divided for PLL entry.
		RCC_CFGR_PLLMULL12; 					// PLL input clock * 12: 4 MHz * 12 = 48 MHz.
												// 4 MHz: HSI (8 MHz) is divided by 2 when timing PLL.
	
	RCC->CR |= RCC_CR_PLLON;					// PLL enable.
	while ((RCC->CR & RCC_CR_PLLRDY) != 0);		// PLL clock ready flag.
	
	/* System clock MUX - PLLCLK */
	RCC->CFGR |= (uint32_t)RCC_CFGR_SW_PLL;		// Select source SYSCLK = PLL.
	while ((RCC->CFGR & RCC_CFGR_SWS) !=		// Wait till PLL is used.
		RCC_CFGR_SWS_PLL);
	
	/* Configure Flash */
	FLASH->ACR = FLASH_ACR_PRFTBE |				// Prefetch buffer enable.
		FLASH_ACR_LATENCY;						// One wait state as 24 MHz < SYSCLK = 48 MHz.
}

/**
*	@name		STM32F0_TIM
*	@file 		InitTIM.c
*
*	@author 	Uladzislau 'vladubase' Dubatouka
*				<vladubase@gmail.com>
*	@version	V1.0
*	@date 		14-November-2020
*	@link		https://github.com/vladubase/STM32_Lib/tree/main/STM32F0/Projects/STM32F0_TIM
*
*/


/************************************** Includes **************************************/

#include "InitTIM.h"


/************************************** Function **************************************/

void InitTIM (void) {
	InitTIM14 ();
}

void InitTIM14 (void) {
/**
*	@brief	This function setup TIM1.
*	@param	None.
*	@retval	None.
*/
	
	RCC->AHBENR |= RCC_AHBENR_GPIOBEN;			// I/O port A clock enable.
	
	RCC->APB2ENR |= RCC_APB1ENR_TIM14EN;		// TIM14 clock enable.
		
	/* ******************** PB1 TIM14 Channel 1******************** */
	// Alternate function mode.
	GPIOB->MODER |= GPIO_MODER_MODER1_1;
	
	// Output push-pull (reset state).
	GPIOB->OTYPER &= ~GPIO_OTYPER_OT_1;
	
	// High speed - 48 MHz.
	// @note	Refer to the device datasheet.
	GPIOB->OSPEEDR |= GPIO_OSPEEDR_OSPEEDR1;
	
	// No pull-up, pull-down.
	GPIOB->PUPDR &= ~GPIO_PUPDR_PUPDR1;
	
	
	/* ********************** Prescaler value ******************** */
	TIM14->PSC = TIM14_PSC;						// Prescaler Value.
	TIM14->PSC = TIM14_ARR;						// Actual auto-reload Value (period).
	
	
	/* ********************* Non-inverting Mode ****************** */
	TIM14->CCMR1 |= TIM_CCMR1_OC1M_2 | 			// Output Compare 1 Mode. PWM mode 1.
				   TIM_CCMR1_OC1M_1;
	
	
	/* ****************** Capture/Compare 1 output *************** */
	TIM14->CCER |= TIM_CCER_CC1E;				// On - OC1 signal is output.
	TIM14->CCER &= ~TIM_CCER_CC1P;				// OC1 active high.
	
	
	/* ******************** Direction of counting **************** */
	//TIM14->CR1 &= TIM_CR1_DIR;					// Counter used as upcounter.
	
	
	TIM14->CR1 |= TIM_CR1_CEN;					// Counter enabled.
}

/**
*	@name		STM32F0_ADC
*	@file 		InitADC.c
*
*	@author 	Uladzislau 'vladubase' Dubatouka
*				<vladubase@gmail.com>
*	@version	V1.2
*	@date 		27-January-2021
*	@link		https://github.com/vladubase/STM32_Lib/tree/main/STM32F0/Projects/STM32F0_ADC
*
*/


/************************************** Includes **************************************/

#include "InitADC.h"


/************************************** Function **************************************/

void InitADC (void) {
	InitADC1 ();
}

void InitADC1 (void) {
/**
*	@brief	This function setup ADC1 channel 1.
*	@param	None.
*	@retval	None.
*/
	
	RCC->AHBENR |= RCC_AHBENR_GPIOAEN;			// I/O port A clock enable.
	
	RCC->APB2ENR |= RCC_APB2ENR_ADC1EN;			// ADC1 clock enable.
	RCC->CR2 |= RCC_CR2_HSI14ON;				// HSI14 oscillator ON.
	while (!(RCC->CR2 & RCC_CR2_HSI14RDY));		// HSI14 oscillator ready flag.
	
	/* ******************* PA7..0 ADC_IN[7..0] ******************* */
	// Analog mode.
	GPIOA->MODER |= GPIO_MODER_MODER7 | GPIO_MODER_MODER6 | 
		GPIO_MODER_MODER5 | GPIO_MODER_MODER4 | 
		GPIO_MODER_MODER3 | GPIO_MODER_MODER2 | 
		GPIO_MODER_MODER1 | GPIO_MODER_MODER0;
	
	// Medium speed - 10 MHz.
	// @note	Refer to the device datasheet.
	GPIOA->OSPEEDR |= GPIO_OSPEEDR_OSPEEDR7_0 | GPIO_OSPEEDR_OSPEEDR6_0 | 
		GPIO_OSPEEDR_OSPEEDR5_0 | GPIO_OSPEEDR_OSPEEDR4_0 |
		GPIO_OSPEEDR_OSPEEDR3_0 | GPIO_OSPEEDR_OSPEEDR2_0 |
		GPIO_OSPEEDR_OSPEEDR1_0 | GPIO_OSPEEDR_OSPEEDR0_0;
	
	// No pull-up, pull-down.
	GPIOA->PUPDR &= ~(GPIO_PUPDR_PUPDR7 | GPIO_PUPDR_PUPDR6 |
		GPIO_PUPDR_PUPDR5 | GPIO_PUPDR_PUPDR4 |
		GPIO_PUPDR_PUPDR3 | GPIO_PUPDR_PUPDR2 |
		GPIO_PUPDR_PUPDR1 | GPIO_PUPDR_PUPDR0);
	
	
	/* *********************************************************** */	
	if (ADC1->CR & ADC_CR_ADEN)					// ADC enable command should be turned off.
		ADC1->CR |= ADC_CR_ADDIS;				// ADC disable command.
	while ((ADC1->CR & ADC_CR_ADEN) != 0);
	ADC1->CFGR1 &= ~ADC_CFGR1_DMAEN;			// DMA disabled.
	
	ADC1->CR |= ADC_CR_ADCAL;					// ADC calibration.
	while (ADC1->CR & ADC_CR_ADCAL);			// Read at 1 means that a calibration is in progress.
	
	ADC1->CFGR1 &= ~(ADC_CFGR1_RES |			// 12-bits data resolution.
		ADC_CFGR1_CONT |						// Single conversion.
		ADC_CFGR1_SCANDIR);						// Upward scan (from CHSEL0 to CHSEL17).
	
	ADC1->CR |= ADC_CR_ADEN;					// Enable the ADC.
	
	// Sampling time selection.
	ADC1->SMPR |= ADC_SMPR_SMP;					// Common 12.5 ADC clock cycles +239.5 cycles.
	
//	// ADC channel selection.
//	ADC1->CHSELR |= ADC_CHSELR_CHSEL7 | ADC_CHSELR_CHSEL6 |	// Input Channels 7..0 are selected for conversion.
//		ADC_CHSELR_CHSEL5 | ADC_CHSELR_CHSEL4 |
//		ADC_CHSELR_CHSEL3 | ADC_CHSELR_CHSEL2 |
//		ADC_CHSELR_CHSEL1 | ADC_CHSELR_CHSEL0;
}

uint16_t ADC1_StartConversion (void) {
/**
*	@brief	Start ADC conversion.
*	@param	None.
*	@retval	Return the conversion result from the last converted channel.
*/
	
	ADC1->CR |= ADC_CR_ADSTART;					// ADC start conversion.	
	while (!(ADC1->CR & ADC_CR_ADSTART));		// Wait end of conversion.
	
	return ADC1->DR;
}

/****
	*	@name		STM32F0_DMA
	*	@file 		InitDMA.c
	*
	*	@author 	Uladzislau 'vladubase' Dubatouka
	*				<vladubase@gmail.com>
	*	@version	V0.1
	*	@date 		30-January-2021
	*	@link		https://github.com/vladubase/STM32_Lib/tree/main/STM32F0/Projects/STM32F0_DMA
	*
*****/


/************************************** Includes **************************************/

#include "InitDMA.h"


/*********************************** Global varibles **********************************/

uint8_t ADC_array[] = {0};


/************************************** Function **************************************/

void InitDMA (void) {
	InitDMA_ADC1 ();
}

// DMA USART1
void InitDMA_ADC1 (void) {
   /*
	*	@brief	This function setup DMA: USART1 as transmitter. Channel 4.
	*	@param	None.
	*	@retval	None.
	*/	
	
	RCC->AHBENR |= RCC_AHBENR_DMA1EN;				// DMA1 clock enable.
	ADC1->CFGR1 |= ADC_CFGR1_DMAEN;					// Enable DMA transfer on ADC.
	
	DMA1_Channel1->CPAR = (uint32_t) (&(ADC1->DR));	// Configure the peripheral data register address.
	DMA1_Channel1->CMAR = (uint32_t)(ADC_array);	// Configure the memory address.
	DMA1_Channel1->CNDTR = 8;						// Configure the number of DMA tranfer to be performs on channel 1.
	DMA1_Channel1->CCR |= DMA_CCR_MINC | 			// Memory increment mode enabled.
		DMA_CCR_MSIZE_0 | 							// Memory size 16-bits.
		DMA_CCR_PSIZE_0 | 							// Peripheral size 16-bits.
		DMA_CCR_TEIE | 								// Transfer error interrupt enable.
		DMA_CCR_TCIE ; 								// Transfer complete interrupt enable
	DMA1_Channel1->CCR |= DMA_CCR_EN;				// Enable DMA Channel 1.
	
	
	/* **************** Configure NVIC for DMA **************** */
	NVIC_EnableIRQ(DMA1_Channel1_IRQn);
	NVIC_SetPriority(DMA1_Channel1_IRQn,0);
}

void DMA_ADC_ReadSensors (void) {
	DMA1_Channel1->CCR 	&= ~DMA_CCR_EN;				// Channel disabled.
	
	DMA1_Channel1->CNDTR = sizeof (ADC_array) - 1;
	DMA1->IFCR |= DMA_IFCR_CTCIF4;					// Transfer Complete clear.
	
	DMA1_Channel1->CCR 	|= DMA_CCR_EN;				// Channel enabled.
}

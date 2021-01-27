#ifndef _INIT_ADC_H_
#define _INIT_ADC_H_

/**
*	@name		STM32F0_ADC
*	@file 		InitADC.h
*
*	@author 	Uladzislau 'vladubase' Dubatouka
*				<vladubase@gmail.com>
*	@version	V1.2
*	@date 		27-January-2021
*	@link		https://github.com/vladubase/STM32_Lib/tree/main/STM32F0/Projects/STM32F0_ADC
*
*/


/************************************** Includes **************************************/

#include "stm32f0xx.h"


/************************************** Defines ***************************************/

#define ADC1_LSB	((float)	3.363 / 4096)	// ADC Least significant bit. LSB = Vref / (2 ^ 12-bit res).


/********************************* Function  prototypes *******************************/

void InitADC (void);
void InitADC1CH1 (void);
uint16_t ADC1_StartConversion (void);


#endif /* _INIT_ADC_H_ */

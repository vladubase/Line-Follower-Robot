#ifndef _INIT_TIM_H_
#define _INIT_TIM_H_

/**
*	@name		STM32F0_TIM
*	@file 		InitTIM.h
*
*	@author 	Uladzislau 'vladubase' Dubatouka
*				<vladubase@gmail.com>
*	@version	V1.0
*	@date 		14-November-2020
*	@link		https://github.com/vladubase/STM32_Lib/tree/main/STM32F0/Projects/STM32F0_TIM
*
*/


/************************************** Includes **************************************/

#include "stm32f0xx.h"
#include "stdint.h"
#include "stdbool.h"


/************************************** Defines ***************************************/

#define TIM14_PSC	((uint16_t)	8 - 1)			// Prescaller.
#define TIM14_ARR	((uint16_t)	1000)			// Period.


/********************************* Function  prototypes *******************************/

void InitTIM (void);
void InitTIM14 (void);


#endif /* _INIT_TIM_H_ */

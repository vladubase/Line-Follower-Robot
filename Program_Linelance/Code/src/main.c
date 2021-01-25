/**
*	@name		Linelance_linefollower
*	@file 		main.c
*
*	@author 	Uladzislau 'vladubase' Dubatouka
*				<vladubase@gmail.com>.
*	@version	V1.0
*	@date 		25-January-2021
*	@link		https://github.com/vladubase/Linelance
*
*/


/************************************** Include ***************************************/

#include "main.h"


/**************************************** Main ****************************************/

int main (void) {
	// DEFINITION OF VARIABLES
		uint32_t i = 0;
		
	// MICROCONTROLLER INITIALIZATION
		//InitRCC ();
		InitSWD ();
		InitGPIO ();
		InitUSART1 ();
		//InitTIM14 ();
	
	// MAIN CYCLE
		while (1) {
			GPIOB->ODR |= GPIO_ODR_1;
			
			
			
//			for (i = 0; i < TIM14_ARR; i++) {
//				TIM14->CCR1 = i;						// CH1 duty cycle.
//			}
			
			//USART1_SendString ("MSFGovno");
		}
}

/****
	*	@name		Linelance_linefollower
	*	@file 		main.c
	*
	*	@author 	Uladzislau 'vladubase' Dubatouka
	*				<vladubase@gmail.com>.
	*	@version	V1.0
	*	@date 		29-October-2020
	*
*****/


/************************************** Includes **************************************/

#include "main.h"


/**************************************** Main ****************************************/

int main (void) {
	// DEFINITION OF VARIABLES
		
		
	// MICROCONTROLLER INITIALIZATION
		InitRCC ();
		InitGPIO ();
		InitI2C ();
	
	// MAIN CYCLE
		while (true) {
			GPIOB->BSRR |= GPIO_BSRR_BS_1;				// Output log.1
		}
}

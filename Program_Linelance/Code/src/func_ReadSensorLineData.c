/****
	*	@name		Linelance_linefollower
	*	@file 		func_ReadSensorLineData.c
	*
	*	@author 	Uladzislau 'vladubase' Dubatouka
	*				<vladubase@gmail.com>
	*	@version	V1.0
	*	@date 		01-February-2021
	*	@link		https://github.com/vladubase/Linelance
	*
*****/


/************************************** Includes **************************************/

#include "func_ReadSensorLineData.h"


/************************************** Function **************************************/

void ReadSensorLineData (void) {
   /*
	*	@brief	This function setup GPIO.
	*/
	
	// DEFINITION OF VARIABLES
		extern bool line_data[];
		uint8_t i = 0;
		char port_num[1];
		char port_state[1];
	
	// FUNCTION
		for (i = 0; i < 8; i++) {
			line_data[i] = ((GPIOA->IDR) & (1 << i));
				
			sprintf (port_num, "%u", i);
			USART1_SendString ("PORT ");
			USART1_SendString (port_num);
			USART1_SendString (", VALUE ");
			sprintf (port_state, "%u", line_data[i]);
			USART1_SendString (port_state);
			USART1_SendString ("\r\n");
		}
	
}

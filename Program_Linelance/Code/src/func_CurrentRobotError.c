/****
	*	@name		Linelance_linefollower
	*	@file 		func_CurrentRobotError.c
	*
	*	@author 	Uladzislau 'vladubase' Dubatouka
	*				<vladubase@gmail.com>
	*	@version	V1.0
	*	@date 		01-February-2021
	*	@link		https://github.com/vladubase/Linelance
	*
*****/


/************************************** Includes **************************************/

#include "func_CurrentRobotError.h"


/************************************** Function **************************************/

float CurrentRobotError (void) {
   /*
	*	@brief	This function setup GPIO.
	*/
	
	// DEFINITION OF VARIABLES
		extern bool line_data[];
		uint8_t i = 0;
		float current_error = 0.0;
	
	// FUNCTION
		for (i = 0; i < 8; i++) {
			if (line_data[i] != 0) {
			// If the data on the i-th sensor is zero,
			// then the sensor is located above the black line.
			// Odd degree to preserve the sign '-'.
            current_error += pow (8 / 2 - 0.5 - i, 3);	// (8 sensors / 2 - 0.5 - i)^3.
			}
		}
	
	return current_error;	
}

/****
	*	@name		Linelance_linefollower
	*	@file 		func_CurrentRobotError.c
	*
	*	@author 	Uladzislau 'vladubase' Dubatouka
	*				<vladubase@gmail.com>
	*	@version	V1.0
	*	@date 		13-February-2021
	*	@link		https://github.com/vladubase/Linelance
	*
*****/


/************************************** Includes **************************************/

#include "func_CurrentRobotError.h"


/************************************** Function **************************************/

float CurrentRobotError (void) {
   /*
	*	@brief	This function calculate robot error relatively sensor line.
	*/
	
	// DEFINITION OF VARIABLES
		extern bool line_data[];
		uint8_t i = 0;
		float current_error = 0.0;
		int8_t power_of_sensor[8] = {-15, -7, -5, -3, 3, 5, 7, 15};
	
	// FUNCTION
		for (i = 0; i < 8; i++) {
			//	If the data on the i-th sensor is zero,
			//	then the sensor is located above the black line.
			if (line_data[i] != 0) {
				current_error += power_of_sensor[i];
			}
		}
	
	return current_error;
}

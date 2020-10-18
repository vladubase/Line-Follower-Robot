/****
	*	@name		DMotor_linefollower
	*	@file 		ReadSensorLineData.c
	*
	*	@author 	Uladzislau 'vladubase' Dubatouka
	*				<vladubase@gmail.com>
	*
*****/


/************************************** Includes **************************************/

#include "ReadSensorLineData.h"


/************************************** Function **************************************/

float CurrentRobotError (void) {
	register uint8_t i = 0;
	register float current_error = 0.0;
	
	ReadSensorLineData ();

	for (i = 0; i < QTY_OF_SENSORS; i++) {
		if (line_data[i] != 0) {
			// If the data on the i-th sensor is zero,
			// then the sensor is located above the black line.
			// Odd degree to preserve the sign '-'
			current_error += pow (QTY_OF_SENSORS / 2 - 0.5 - i, 3);
		}
	}

	return current_error;
}

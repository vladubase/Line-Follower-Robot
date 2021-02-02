/****
	*	@name		DMotor_linefollower
	*	@file 		InitSYS.c
	*
	*	@author 	Uladzislau 'vladubase' Dubatouka
	*				<vladubase@gmail.com>
	*	@version	V1.0
	*	@date 		02-February-2021
	*	@link		https://github.com/vladubase/Line-Follower-Robot
	*
*****/


/************************************** Includes **************************************/

#include "../inc/InitSYS.h"


/************************************** Function **************************************/

void InitSYS (void) {
	// Infrared Sensor
	// Input mode
		#ifdef READ_SENSOR_IR
			DDRx &= ~(1 << DDxx);
		#endif /* READ_SENSOR_IR */

	// Crystal Oscillator division factor: 1
		#pragma optsize-
			CLKPR |= (1 << CLKPCE);
			CLKPR = 0x00;
		#ifdef _OPTIMIZE_SIZE_
			#pragma optsize+
		#endif /* _OPTIMIZE_SIZE_ */
}

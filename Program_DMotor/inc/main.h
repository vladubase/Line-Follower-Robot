#ifndef _MAIN_H_
#define _MAIN_H_

/****
	*	@name		DMotor_linefollower
	*	@file 		main.h
	*
	*	@author 	Uladzislau 'vladubase' Dubatouka
	*				<vladubase@gmail.com>
	*	@version	V1.0
	*	@date 		02-February-2021
	*	@link		https://github.com/vladubase/Line-Follower-Robot
	*
*****/


/************************************** Includes **************************************/

#include <avr/io.h>
#include <util/delay.h>
#include <stdbool.h>
#include <stdint.h>


/*************************************** Defines **************************************/

// CLOCK
#define		F_CPU				((uint32_t)	20000000)	// Quartz resonator clock frequency.

// GENERAL PARAMETERS
#define		MOTOR_POWER			((float)	0.65)		// Speed of robot in percents.

//#define	READ_IR_SENSOR		PINx & (1 << DDxx)


/*********************************** User Includes ************************************/

#include "InitSYS.h"
#include "InitTIM.h"
#include "InitUSART.h"


#endif /* _MAIN_H_ */

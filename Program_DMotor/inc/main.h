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
#define		F_CPU				((uint32_t)	20000000)	// Quartz resonator clock frequency
// FUSE_CKSEL[1..2] 011

// GENERAL PARAMETERS
#define		AVG_SPEED			((uint8_t)	127)		// Average speed of robot

#define		MOTORS_NOT_PERFECT	false 					// Do the motors have different real parameters (e.g. Speed, Torque, etc.)?
#if MOTORS_NOT_PERFECT
	// There is nothing perfect ;)
	#define	L_MOTOR_MISMATCH	((float)	1.0)		// Coefficients of motor power difference
	#define	R_MOTOR_MISMATCH	((float)	1.07)
#endif /* MOTORS_NOT_PERFECT */

//#define	READ_IR_SENSOR		PINx & (1 << DDxx)


/*********************************** User Includes ************************************/

#include "InitSYS.h"
#include "InitTIM.h"
#include "InitUSART.h"


#endif /* _MAIN_H_ */

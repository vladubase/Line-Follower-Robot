#ifndef _MAIN_H_
#define _MAIN_H_

/****
	*	@name		DMotor_linefollower
	*	@file 		main.h
	*
	*	@author 	Uladzislau 'vladubase' Dubatouka
	*				<vladubase@gmail.com>
	*
*****/


/************************************** Includes **************************************/

#include <avr/io.h>
#include <util/delay.h>
#include <math.h>
#include <stdbool.h>
#include <stdint.h>
#include "InitSYS.h"
#include "InitI2C.h"
#include "ReadSensorLineData.h"
//#include "CurrentRobotError.h"


/*************************************** Defines **************************************/

// CLOCK
#define		F_CPU				((uint32_t)	20000000)	// Quartz resonator clock frequency

// GENERAL PARAMETERS
#define		QTY_OF_SENSORS		8U						// Quantity of sensors
#define		AVG_SPEED			((uint8_t)	155)		// Average speed of robot

#define		MOTORS_NOT_PERFECT	false 					// Do the motors have different real parameters (e.g. Speed, Torque, etc.)?
#if MOTORS_NOT_PERFECT
	// There is nothing perfect ;)
	#define	L_MOTOR_MISMATCH	((float)	1.0)		// Coefficients of motor power difference
	#define	R_MOTOR_MISMATCH	((float)	1.07)
#endif /* MOTORS_NOT_PERFECT */

// PID
// Setup: P -> PD -> PID
#define		kP					((float)	0.02)		// Proportional	feedback coefficient
#define		kI					((uint8_t)	0)			// Integral 	feedback coefficient
#define		kD					((uint8_t)	0)			// Differential	feedback coefficient
#define		QTY_OF_ERR			((uint8_t)	10)			// Quantity of errors in memory during last (QTY_OF_ERR * MAIN_CYCLE_DELAY) ms
#define		MAIN_CYCLE_DELAY	((uint8_t)	2)			// The main cycle delay (in ms) for correct work of D-regulation

//#define	READ_IR_SENSOR		PINx & (1 << DDxx)


/*********************************** Global Variables *********************************/

float line_data[QTY_OF_SENSORS] = {0};					// Store current values from sensor line


#endif /* _MAIN_H_ */

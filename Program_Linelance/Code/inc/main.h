#ifndef _MAIN_H_
#define _MAIN_H_

/**
*	@name		Linelance_linefollower
*	@file 		main.h
*
*	@author 	Uladzislau 'vladubase' Dubatouka
*				<vladubase@gmail.com>
*	@version	V1.0
*	@date 		28-January-2021
*	@link		https://github.com/vladubase/Linelance
*
*/


/************************************** Includes **************************************/

#include "stm32f0xx.h"
#include "stdint.h"
#include "stdbool.h"
#include "stdio.h"


/************************************** Defines ***************************************/

// CLOCK
#define		f_SYSCLK			((uint32_t)	8000000)
#define		f_HCLK				((uint32_t)	8000000)

// GENERAL PARAMETERS
#define		QTY_OF_SENSORS		8U						// Quantity of sensors.

#define		MOTORS_NOT_PERFECT	false 					// Do the motors have different real parameters (e.g. Speed, Torque, etc.)?
#if MOTORS_NOT_PERFECT									// There is nothing perfect ;)
	#define	L_MOTOR_MISMATCH	((float)	1.0)		// Coefficients of motor power difference.
	#define	R_MOTOR_MISMATCH	((float)	1.07)
#endif /* MOTORS_NOT_PERFECT */

// PID
// Setup: P -> PD -> PID
#define		kP					((float)	1)			// Proportional	feedback coefficient.
#define		kI					((float)	0.025)		// Integral 	feedback coefficient.
#define		kD					((float)	0)			// Differential	feedback coefficient.
#define		QTY_OF_ERR			((uint8_t)	10)			// Quantity of errors in memory during last (QTY_OF_ERR * MAIN_CYCLE_DELAY) ms.
#define		MAIN_CYCLE_DELAY	((uint8_t)	5)			// The main cycle delay (in ms) for correct work of I- and D-regulation.


/********************************** Global variables **********************************/

bool line_data[QTY_OF_SENSORS];							// Store current values from sensor line.


/************************************** Includes **************************************/

// User headers.
#include "InitRCC.h"
#include "InitSWD.h"
#include "InitGPIO.h"
#include "InitUART.h"
//#include "InitTIM.h"
//#include "InitADC.h"
//#include "InitDMA.h"
#include "func_ReadSensorLineData.h"
#include "func_CurrentRobotError.h"


#endif /* _MAIN_H_ */

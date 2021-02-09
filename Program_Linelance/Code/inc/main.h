#ifndef _MAIN_H_
#define _MAIN_H_

/**
*	@name		Linelance_linefollower
*	@file 		main.h
*
*	@author 	Uladzislau 'vladubase' Dubatouka
*				<vladubase@gmail.com>
*	@version	V1.0
*	@date 		09-February-2021
*	@link		https://github.com/vladubase/Line-Follower-Robot
*
*/


/************************************** Includes **************************************/

#include "stm32f0xx.h"
#include "stdint.h"
#include "stdbool.h"
#include "stdio.h"


/************************************** Defines ***************************************/

// CLOCK
#define		f_SYSCLK			((uint32_t)	8e6)
#define		f_HCLK				((uint32_t)	8e6)

// GENERAL PARAMETERS
#define		QTY_OF_SENSORS		8U						// Quantity of sensors.

// PID
// Setup: P -> PD -> PID
#define		kP					((float)	8)			// Proportional	feedback coefficient.
#define		kI					((float)	0)			// Integral 	feedback coefficient.
#define		kD					((float)	0)			// Differential	feedback coefficient.
#define		PID_DIRECTION		1						// 0 - NORMAL,
														// 1 - REVERSE.
#define		QTY_OF_ERR			((uint8_t)	10)			// Quantity of errors in memory during last (QTY_OF_ERR * MAIN_CYCLE_DELAY) ms.
#define		MAIN_CYCLE_DELAY	((float)	0.050)		// The main cycle delay (in sec.) for correct work of I- and D-regulation.

#define		DEBUG				false


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

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

#include <util/delay.h>
#include <math.h>
#include <stdbool.h>
#include <stdint.h>
#include "InitSYS.h"
#include "InitI2C.h"
#include "ReadSensorLineData.h"
#include "CurrentRobotError.h"


/*************************************** Defines **************************************/

// CLOCK
#define		F_CPU				((uint32_t)	20000000)	// Quartz resonator clock frequency

// GENERAL PARAMETERS
#define		QTY_OF_SENSORS		8U						// Quantity of sensors
#define		AVG_SPEED			((uint8_t)	155)		// Average speed of robot

#define		MOTORS_NOT_PERFECT	true 					// Do the motors have different real parameters (e.g. Speed, Torque, etc.)?
#if MOTORS_NOT_PERFECT
// There is nothing perfect ;)
#define	L_MOTOR_MISMATCH		((float)	1.0)		// Coefficients of motor power difference
#define	R_MOTOR_MISMATCH		((float)	1.07)
#endif /* MOTORS_NOT_PERFECT */

// PID
// Setup: P -> PD -> PID
#define		kP					((uint8_t)	1)			// Proportional	feedback coefficient
#define		kI					((uint8_t)	0)			// Integral 	feedback coefficient
#define		kD					((uint8_t)	0)			// Differential	feedback coefficient
#define		QTY_OF_ERR			((uint8_t)	10)			// Quantity of errors in memory during last (QTY_OF_ERR * MAIN_CYCLE_DELAY) ms
#define		MAIN_CYCLE_DELAY	((uint8_t)	2)			// The main cycle delay (in ms) for correct work of D-regulation

// Sensor order in the right --> direction
#if (QTY_OF_SENSORS >= 1)
#define	READ_SENSOR_1		PIND & (1 << DDD2)
#endif /* QTY_OF_SENSORS >= 1 */
#if QTY_OF_SENSORS >= 2
#define	READ_SENSOR_2		PIND & (1 << DDD4)
#endif /* QTY_OF_SENSORS >= 2 */
#if QTY_OF_SENSORS >= 3
#define	READ_SENSOR_3		PINC & (1 << DDC5)
#endif /* QTY_OF_SENSORS >= 3 */
#if QTY_OF_SENSORS >= 4
#define	READ_SENSOR_4		PINC & (1 << DDC4)
#endif /* QTY_OF_SENSORS >= 4 */
#if QTY_OF_SENSORS >= 5
#define	READ_SENSOR_5		PINC & (1 << DDC3)
#endif /* QTY_OF_SENSORS >= 5 */
#if QTY_OF_SENSORS >= 6
#define	READ_SENSOR_6		PINC & (1 << DDC2)
#endif /* QTY_OF_SENSORS >= 6 */
#if QTY_OF_SENSORS >= 7
#define	READ_SENSOR_7		PINC & (1 << DDC1)
#endif /* QTY_OF_SENSORS >= 7 */
#if QTY_OF_SENSORS >= 8
#define	READ_SENSOR_8		PINC & (1 << DDC0)
#endif /* QTY_OF_SENSORS >= 8 */
#if QTY_OF_SENSORS >= 9
#define	READ_SENSOR_9		PINx & (1 << DDxx)
#endif /* QTY_OF_SENSORS >= 9 */
#if QTY_OF_SENSORS >= 10
#define	READ_SENSOR_10		PINx & (1 << DDxx)
#endif /* QTY_OF_SENSORS >= 10 */
#if QTY_OF_SENSORS >= 11
#define	READ_SENSOR_11		PINx & (1 << DDxx)
#endif /* QTY_OF_SENSORS >= 11 */
#if QTY_OF_SENSORS >= 12
#define	READ_SENSOR_12		PINx & (1 << DDxx)
#endif /* QTY_OF_SENSORS >= 12 */
#if QTY_OF_SENSORS >= 13
#define	READ_SENSOR_13		PINx & (1 << DDxx)
#endif /* QTY_OF_SENSORS >= 13 */
#if QTY_OF_SENSORS >= 14
#define	READ_SENSOR_14		PINx & (1 << DDxx)
#endif /* QTY_OF_SENSORS >= 14 */
#if QTY_OF_SENSORS >= 15
#define	READ_SENSOR_15		PINx & (1 << DDxx)
#endif /* QTY_OF_SENSORS >= 15 */
#if QTY_OF_SENSORS >= 16
#define	READ_SENSOR_16		PINx & (1 << DDxx)
#endif /* QTY_OF_SENSORS >= 16 */

//#define	READ_IR_SENSOR		PINx & (1 << DDxx)


/*********************************** Global Variables *********************************/

bool line_data[QTY_OF_SENSORS] = {0};					// Store current values from sensor line


#endif /* _MAIN_H_ */

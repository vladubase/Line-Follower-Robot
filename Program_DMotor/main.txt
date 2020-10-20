/****
	*	@name		DMotor_linefollower
	*	@file 		main.c
	*
	*	@author 	Uladzislau 'vladubase' Dubatouka
	*				<vladubase@gmail.com>.
	*	@version	V1.0
	*	@date 		Created on 2020.10.18.
	*
	*	@brief 		This program is controlling the Line following robot using PID regulator.
	*				It has a flexible settings system via #defines at the beginning of the .C main file.
	*				IO ports are configured through registers.
	*	
	*	@attention 	Before program Microcontroller check follow:
	*			@a		1. F_CPU - system clock of external quartz resonator (if needed clock division, see datasheet);
	*			@a		2. QTY_OF_SENSORS and used bits (see "Defines" section and "InitSys" function);
	*			@a		3. MOTORS_NOT_PERFECT parameter, if motors are not identical by speed, torque, gear ratio, etc.
	*			@a		4. PID coefficients
	*
	*  	@attention 	The usual procedure for setting up the PID regulator:
	*			@b		1. At a low speed, we adjust the P-controller (we select a value of kP such 
	*							that in the coolest turns the robot passes keeping the line close to its
	*							extreme sensors). kD and kI are equal to zero, i.e. use a pure P-regulator;
	*			@b		2. Increase the speed, select the value of kD. If the robot went without
	*							inertia when setting the P-controller, then the kP value can be left unchanged.
	*							If the robot has already gone with inertia, as is usually the case
	*							with fast robots, then the kP value will need to be lowered -
	*							we will see this by the fact that the robot will cease to deviate
	*							strongly from the line thanks to the help of the D-controller;
	*			@b		3. When the PD controller is configured, then I can be selected,
	*							reducing the deviation of the robot from the line. The values ??of
	*							the coefficients kD and kP are usually also somewhat lower.
	*							An i-controller is useful for racing where a line can make loops.
	*							Deviation of the robot from a straight line is fraught with
	*							the choice of the wrong direction of movement. When racing on tracks
	*							without loops, the PD controller is often used, since in the general
	*							case it allows you to develop a higher speed.
	*
	*   @note		4.25 ms for main cycle (not counting MAIN_CYCLE_DELAY) with 4 sensors in low-state.
	*				6 ms for main cycle (not counting MAIN_CYCLE_DELAY) with 15 sensors in low-state.
	*
*****/


/************************************** Includes **************************************/

#include "inc/main.h"


/**************************************** Main ****************************************/

void main (void) {
	// DEFINITION OF VARIABLES
	float error_history[QTY_OF_ERR] = {0};				// Storing the values of recent errors
	register float error_sum = 0.0;						// Sum of errors in history
	register uint8_t i = 0;
	register float P = 0.0;
	register float I = 0.0;
	register float D = 0.0;
	register float PID_total_correction = 0.0;      	// Sum of P, I, D
	register int16_t left_motor_speed = 0;
	register int16_t right_motor_speed = 0;

	// MICROCONTROLLER INITIALIZATION
	InitSYS ();
	

	// Waiting for a signal on IR sensor
	#ifdef READ_IR_SENSOR
		while (READ_IR_SENSOR) {
			LED_1_ON;
			_delay_ms (25);
			LED_1_OFF;
			_delay_ms (25);
		}
	#endif /* READ_IR_SENSOR */

	//delay_ms (5000);									// This delay is required by the competition rules
	
	
	// MAIN CYCLE
	while (true) {
		error_sum = 0.0;

	    // Shift error values
		for (i = 0; i < QTY_OF_ERR - 1; i++) {
			error_history[i] = error_history[i + 1];
		}
		error_history[QTY_OF_ERR - 1] = CurrentRobotError ();

		// Calculation of value P
		P = error_history[QTY_OF_ERR - 1] * kP;			// Current error * kP
		// Calculation of value I
		for (i = 0; i < QTY_OF_ERR; i++) {
			error_sum += error_history[i];
		}
		I = error_sum * kI;								// sum of errors * kI
		// Calculation of value D
		D = (error_history[QTY_OF_ERR - 1] -        	// (current error - error in past) * kD
        	error_history[0]) * kD;

		PID_total_correction = (P + I) + D;

		// 
		left_motor_speed  = AVG_SPEED - (uint16_t)PID_total_correction;
		right_motor_speed = AVG_SPEED + (uint16_t)PID_total_correction;

		// Validating a range of variables
		if (left_motor_speed > 255)
			left_motor_speed = 255;
		else if (left_motor_speed < 0)
			left_motor_speed = 0;
		if (right_motor_speed > 255)
			right_motor_speed = 255;
		else if (right_motor_speed < 0)
			right_motor_speed = 0;

		// Motors power difference compensation
		#if MOTORS_NOT_PERFECT
			OCR2A = 0;
			OCR2B = left_motor_speed * L_MOTOR_MISMATCH;
			OCR0A = 0;
			OCR0B = right_motor_speed * R_MOTOR_MISMATCH;
		#else
			OCR2A = 0;
			OCR2B = left_motor_speed;
			OCR0A = 0;
			OCR0B = right_motor_speed;
		#endif /* MOTORS_NOT_PERFECT */

		_delay_ms (MAIN_CYCLE_DELAY);
	}
}

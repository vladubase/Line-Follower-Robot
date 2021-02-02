/****
	*	@name		DMotor_linefollower
	*	@file 		main.c
	*
	*	@author 	Uladzislau 'vladubase' Dubatouka
	*				<vladubase@gmail.com>.
	*	@version	V1.0
	*	@date 		https://github.com/vladubase/Line-Follower-Robot
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
		char USART_message[1];
		uint8_t i = 0;
	
	// MICROCONTROLLER INITIALIZATION
		InitSYS ();
		InitTIM ();
		InitUSART ();
		
		DDRD |= (1 << DDD7);	// output
	
	// MAIN CYCLE
		while (true) {
			USART_message[0] = USART_Receive ();
			
			USART_Transmit ()
		}
}

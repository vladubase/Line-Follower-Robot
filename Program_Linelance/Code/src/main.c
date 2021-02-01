/**
*	@name		Linelance_linefollower
*	@file 		main.c
*
*	@author 	Uladzislau 'vladubase' Dubatouka
*				<vladubase@gmail.com>.
*	@version	V1.0
*	@date 		28-January-2021
*	@link		https://github.com/vladubase/Linelance
*
*/


/************************************** Include ***************************************/

#include "main.h"


/**************************************** Main ****************************************/

int main (void) {
	// DEFINITION OF VARIABLES		
		extern bool line_data[];					// Array of 1/0 states of sensors.
		uint32_t i = 0;
		float error_history[QTY_OF_ERR] = {0.0};	// Storing the values of recent errors.
		float error_sum = 0.0;						// Sum of errors in history.
		float P = 0.0;
		float I = 0.0;
		float D = 0.0;
		float PID_total_correction = 0.0;      		// Sum of P, I, D.
		int16_t left_motor_speed = 0;
		int16_t right_motor_speed = 0;
		
		char usart_message[10];
		
		
	// MICROCONTROLLER INITIALIZATION
		//InitRCC ();
		InitSWD ();
		InitGPIO ();
		InitUSART1 ();
		//InitTIM14 ();
		//InitADC ();
		//InitDMA_ADC1 ();
	
	// MAIN CYCLE
		while (1) {		
			error_sum = 0.0;
			
			ReadSensorLineData ();
			
			// Shift error values.
			for (i = 0; i < QTY_OF_ERR - 1; i++) {
				error_history[i] = error_history[i + 1];
			}
			error_history[QTY_OF_ERR - 1] = CurrentRobotError ();
			
			
			
			
//			// Calculation of value P.
//			P = error_history[QTY_OF_ERR - 1] * kP;	// Current error * kP.
//			// Calculation of value I.
//			for (i = 0; i < QTY_OF_ERR; i++) {
//				error_sum += error_history[i];
//			}
//			I = error_sum * kI;						// sum of errors * kI.
//			// Calculation of value D.
//			D = (error_history[QTY_OF_ERR - 1] -	// (current error - error in past) * kD.
//				error_history[0]) * kD;
//	
//			PID_total_correction = (P + I) + D;
//	
//			// 
//			left_motor_speed  = AVG_SPEED - (uint16_t)PID_total_correction;
//			right_motor_speed = AVG_SPEED + (uint16_t)PID_total_correction;
//	
//			// Validating a range of variables.
//			if (left_motor_speed > 255)
//				left_motor_speed = 255;
//			else if (left_motor_speed < 0)
//				left_motor_speed = 0;
//			if (right_motor_speed > 255)
//				right_motor_speed = 255;
//			else if (right_motor_speed < 0)
//				right_motor_speed = 0;

//			// Motors power difference compensation.
//			#if MOTORS_NOT_PERFECT
//				OCR2A = 0;
//				OCR2B = left_motor_speed * L_MOTOR_MISMATCH;
//				OCR0A = 0;
//				OCR0B = right_motor_speed * R_MOTOR_MISMATCH;
//			#else
//				OCR2A = 0;
//				OCR2B = left_motor_speed;
//				OCR0A = 0;
//				OCR0B = right_motor_speed;
//			#endif /* MOTORS_NOT_PERFECT */
//	
//			delay_ms (MAIN_CYCLE_DELAY);
		}
}

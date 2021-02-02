/**
*	@name		Linelance_linefollower
*	@file 		main.c
*
*	@author 	Uladzislau 'vladubase' Dubatouka
*				<vladubase@gmail.com>.
*	@version	V1.0
*	@date 		02-February-2021
*	@link		https://github.com/vladubase/Line-Follower-Robot
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
		float P = 0.0;
		float I = 0.0;
		float D = 0.0;
		float PID_total_correction = 0.0;      		// Sum of P, I, D.
		
//		char USART_message[10];
		
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
			PID_total_correction = 0.0;
			
			ReadSensorLineData ();
			
			// Shift error values.
			for (i = 0; i < QTY_OF_ERR - 1; i++) {
				error_history[i] = error_history[i + 1];
			}
			error_history[QTY_OF_ERR - 1] = -CurrentRobotError ();	// Current error.
			
			P = error_history[QTY_OF_ERR - 1];
			I += error_history[QTY_OF_ERR - 1] * MAIN_CYCLE_DELAY;
			D = (error_history[QTY_OF_ERR - 1] - error_history[QTY_OF_ERR - 2]) / MAIN_CYCLE_DELAY;
			
			PID_total_correction = (P*kP + I*kI) + D*kD;
			
//			sprintf (USART_message, "%f", PID_total_correction);
//			USART1_SendString ("PID_total_correction: ");
//			USART1_SendString (USART_message);						// Send delta to the DMotor module.
//			USART1_SendString ("\r\n");
//			
//			USART1_SendString ("error_history:");
//			for (i = 0; i < 8; i++) {
//				sprintf (USART_message, "%f", error_history[i]);
//				USART1_SendString (" ");
//				USART1_SendString (USART_message);					// Send delta to the DMotor module.
//			}
//			USART1_SendString ("\r\n\r\n");
			
			if (PID_total_correction > 127)		PID_total_correction = 127;
			if (PID_total_correction < -127)	PID_total_correction = -127;
			USART1_SendByte ((uint8_t) PID_total_correction);
			
			// Delay.
			for (i = 0; i < (1000000 * MAIN_CYCLE_DELAY) / 1000; i++) {
				__ASM ("nop");
			}
		}
}

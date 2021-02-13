/**
*	@name		Linelance_linefollower
*	@file 		main.c
*
*	@author 	Uladzislau 'vladubase' Dubatouka
*				<vladubase@gmail.com>.
*	@version	V1.0
*	@date 		13-February-2021
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
#if DEBUG
		char USART_message[1];
#endif
		
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
			#if PID_DIRECTION == 0
				error_history[QTY_OF_ERR - 1] = CurrentRobotError ();	// Current error.
			#endif
			#if PID_DIRECTION == 1
				error_history[QTY_OF_ERR - 1] = -CurrentRobotError ();	// Current error (opposite).
			#endif
			P = 0 - error_history[QTY_OF_ERR - 1];						// 0 is aim.
			I += (0 - error_history[QTY_OF_ERR - 1]) * MAIN_CYCLE_DELAY;
			D = (error_history[QTY_OF_ERR - 1] - error_history[QTY_OF_ERR - 2]) / MAIN_CYCLE_DELAY;
			
			PID_total_correction = (P*kP + I*kI) + D*kD;

#if DEBUG
/**/		sprintf (USART_message, "%f", PID_total_correction);
/**/		USART1_SendString ("PID_total_correction: ");
/**/		USART1_SendString (USART_message);
/**/		USART1_SendString ("\r\n");
/**/		
/**/		USART1_SendString ("error_history:");
/**/		for (i = 0; i < QTY_OF_ERR; i++) {
/**/			sprintf (USART_message, "%d", (int8_t)error_history[i]);
/**/			USART1_SendString ("\n\t");
/**/			USART1_SendString (USART_message);
/**/		}
/**/		USART1_SendString ("\r\n\r\n");
#endif

			if (PID_total_correction > 127.0)	PID_total_correction = 127.0;
			if (PID_total_correction < -127.0)	PID_total_correction = -127.0;
			USART1_SendByte ((int8_t)PID_total_correction);						// Send delta to the DMotor module.
			
			// Delay.
			for (i = 0; i < (1e5 * MAIN_CYCLE_DELAY); i++) {
				__ASM ("nop");
			}
		}
}

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
		uint32_t i = 0;
		uint16_t ADC_result = 0;
		char ADC_result_str[5] = {0};	
		char ADC_voltage_str[5] = {0};
		
	// MICROCONTROLLER INITIALIZATION
		InitRCC ();
		InitSWD ();
		InitGPIO ();
		InitUSART1 ();
		//InitTIM14 ();
		InitADC ();
	
	// MAIN CYCLE
		while (1) {
			ADC_result = ADC1_StartConversion ();	// Get data from ADC.
			
			// Convert value of ADC to char*.
			sprintf (ADC_result_str, "%u", ADC_result);
			sprintf (ADC_voltage_str, "%.3f", ADC_result * ADC1_LSB);
			
			// Send ADC value.
			USART1_SendString ("ADC value: ");
			USART1_SendString (ADC_result_str);
			USART1_SendString ("\r\n");
			
			// Send Voltage.
			USART1_SendString ("Voltage: ");
			USART1_SendString (ADC_voltage_str);
			USART1_SendString (" V\r\n\n");
			
			// No operation 1 sec.
			for (i = 0; i < 48e4; i++)
				__asm ("nop");
		}
}

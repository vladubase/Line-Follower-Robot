/****
	*	@name		DMotor_linefollower
	*	@file 		InitI2C.c
	*
	*	@author 	Uladzislau 'vladubase' Dubatouka
	*				<vladubase@gmail.com>
	*	@version	V1.0
	*	@date 		28-October-2020
	*
*****/


/************************************** Includes **************************************/

#include "../inc/InitI2C.h"


/************************************** Function **************************************/

void InitI2C (void) {
   /*
	*	@brief	This function setup I2C.
	*	@param	None.
	*	@retval	None
	*/
	
	// F_SCL = 100 kHz, TWPS = 0
	TWBR = 92;
}

void I2C_Start (void) {
   /*
	*	@brief	Generate START condition.
	*	@param	None.
	*	@retval	None
	*/
   
   TWCR = (1 << TWINT) | (1 << TWSTA) | (1 << TWEN);
   while (!(TWCR & (1 << TWINT)));
}

void I2C_Stop (void) {
   /*
	*	@brief	Generate STOP condition.
	*	@param	None.
	*	@retval	None
	*/
   
   TWCR = (1 << TWINT) | (1 << TWSTO) | (1 << TWEN);
}

void I2C_SendByte (uint8_t byte) {
   /*
	*	@brief	Generate START condition.
	*	@param	A byte message.
	*	@retval	None
	*/
   
   TWDR = byte;
   TWCR = (1 << TWINT) | (1 << TWEN);	// Enable data transferring.
   while (!(TWCR & (1 << TWINT)));
}

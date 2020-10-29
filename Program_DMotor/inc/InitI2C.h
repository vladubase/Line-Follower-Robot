#ifndef _INIT_I2C_H_
#define _INIT_I2C_H_

/****
	*	@name		DMotor_linefollower
	*	@file 		InitI2C.h
	*
	*	@author 	Uladzislau 'vladubase' Dubatouka
	*				<vladubase@gmail.com>
	*	@version	V1.0
	*	@date 		28-October-2020
	*
*****/


/************************************** Includes **************************************/

#include <avr/io.h>


/********************************* Function  prototypes *******************************/

void InitI2C (void);
void I2C_Start (void);
void I2C_Stop (void);
void I2C_SendByte (uint8_t byte);


#endif /* _INIT_I2C_H_ */

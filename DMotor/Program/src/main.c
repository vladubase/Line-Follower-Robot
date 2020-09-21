/**************************** Includes ****************************/

#include "main.h"

/****************************** Main ******************************/

void main (void) {

	InitSys ();

	// Waiting for a signal on IR sensor
	#ifdef SensorIR
		while (1){
			PORTx |= (1 << x);
				delay_ms(250);
			PORTx &= ~(1 << x);
				delay_ms(250);
			if (SensorIR == 1) {
				break;
			}
		}
	#endif

	delay_ms (1000);
	MoveForward ();

	while (1) {

		ReadSensorLineData ();
		FindRotationAngle ();

		if (angleOfRotation >= AngleDegToRad (5)) {
			while (angleOfRotation > AngleDegToRad (-3) && angleOfRotation < AngleDegToRad (3)) {
				MoveLeft ();
			}
		}
		else if (angleOfRotation <= AngleDegToRad (-5)) {
			while (angleOfRotation > AngleDegToRad (-3) && angleOfRotation < AngleDegToRad (3)) {
				MoveRight ();
			}
		}
		else {
			MoveForward ();
		}

    }

	MoveStop ();

}

/**************************** Includes ****************************/

#include "mega328p.h"
#include "mega328p_bits.h"
#include "delay.h"
#include "math.h"
#include "InitSys.h"
#include "FindLog.h"
#include "AngleDegToRad.h"
#include "ReadSensorLineData.h"
#include "FindRotationAngle.h"
#include "DirectionOfMovement.h"

/**************************** Functions ***************************/

void InitSys (void);
float FindLog (float base, float arg);
float AngleDegToRad (void);
unsigned short int ReadSensorLineData (unsigned short int lineData);
float FindRotationAngle (unsigned short int lineData);

void MoveForward (void);
void MoveStop (void);
void MoveLeft (void);
void MoveRight (void);

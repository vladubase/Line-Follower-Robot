/**************************** Includes ****************************/

#include "InitSys.h"
#include "math.h"

/**************************** Function ****************************/

float FindRotationAngle (unsigned short int lineData) {

    return tan ( (QTY_OF_SENSORS * DISTANCE_BTW_SENSORS / 2) - (FindLog (2, lineData) * DISTANCE_BTW_SENSORS / DISTANCE_WHEEL_TO_SENSORS) );

}

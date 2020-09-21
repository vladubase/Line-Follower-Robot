/**************************** Includes ****************************/

#include "ReadSensorLineData.h"

/**************************** Function ****************************/

unsigned short int ReadSensorLineData (void) {  

    #ifdef ReadSensor1
        sensorLineData |= (ReadSensor1 << 0);
    #endif
    #ifdef ReadSensor2
        sensorLineData |= (ReadSensor2 << 1);
    #endif
    #ifdef ReadSensor3
        sensorLineData |= (ReadSensor3 << 2);
    #endif
    #ifdef ReadSensor4
        sensorLineData |= (ReadSensor4 << 3);
    #endif
    #ifdef ReadSensor5
        sensorLineData |= (ReadSensor5 << 4);
    #endif
    #ifdef ReadSensor6
        sensorLineData |= (ReadSensor6 << 5);
    #endif
    #ifdef ReadSensor7
        sensorLineData |= (ReadSensor7 << 6);
    #endif
    #ifdef ReadSensor8
        sensorLineData |= (ReadSensor8 << 7);
    #endif
    #ifdef ReadSensor9
        sensorLineData |= (ReadSensor9 << 8);
    #endif
    #ifdef ReadSensor10
        sensorLineData |= (ReadSensor10 << 9);
    #endif
    #ifdef ReadSensor11
        sensorLineData |= (ReadSensor11 << 10);
    #endif
    #ifdef ReadSensor12
        sensorLineData |= (ReadSensor12 << 11);
    #endif
    #ifdef ReadSensor13
        sensorLineData |= (ReadSensor13 << 12);
    #endif
    #ifdef ReadSensor14
        sensorLineData |= (ReadSensor14 << 13);
    #endif
    #ifdef ReadSensor15
        sensorLineData |= (ReadSensor15 << 14);
    #endif
    #ifdef ReadSensor16
        sensorLineData |= (ReadSensor16 << 15);
    #endif

    return sensorLineData;

}

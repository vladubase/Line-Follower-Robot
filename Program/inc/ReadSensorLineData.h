/**************************** Includes ****************************/

#include "mega328p.h"
#include "mega328p_bits.h"
#include "InitSys.h"

/**************************** Function ****************************/

unsigned short int ReadSensorLineData (unsigned short int lineData) {  

    #ifdef ReadSensor1
        lineData |= (ReadSensor1 << 0);
    #endif
    #ifdef ReadSensor2
        lineData |= (ReadSensor2 << 1);
    #endif
    #ifdef ReadSensor3
        lineData |= (ReadSensor3 << 2);
    #endif
    #ifdef ReadSensor4
        lineData |= (ReadSensor4 << 3);
    #endif
    #ifdef ReadSensor5
        lineData |= (ReadSensor5 << 4);
    #endif
    #ifdef ReadSensor6
        lineData |= (ReadSensor6 << 5);
    #endif
    #ifdef ReadSensor7
        lineData |= (ReadSensor7 << 6);
    #endif
    #ifdef ReadSensor8
        lineData |= (ReadSensor8 << 7);
    #endif
    #ifdef ReadSensor9
        lineData |= (ReadSensor9 << 8);
    #endif
    #ifdef ReadSensor10
        lineData |= (ReadSensor10 << 9);
    #endif
    #ifdef ReadSensor11
        lineData |= (ReadSensor11 << 10);
    #endif
    #ifdef ReadSensor12
        lineData |= (ReadSensor12 << 11);
    #endif
    #ifdef ReadSensor13
        lineData |= (ReadSensor13 << 12);
    #endif
    #ifdef ReadSensor14
        lineData |= (ReadSensor14 << 13);
    #endif
    #ifdef ReadSensor15
        lineData |= (ReadSensor15 << 14);
    #endif
    #ifdef ReadSensor16
        lineData |= (ReadSensor16 << 15);
    #endif

    return lineData;

}

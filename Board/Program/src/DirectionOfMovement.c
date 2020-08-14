/**************************** Includes ****************************/

#include "DirectionOfMovement.h"

/**************************** Function ****************************/

void MoveForward (void) {

    if (LEFT_MOTOR_QUOTIENT > RIGHT_MOTOR_QUOTIENT) {
        OCR0A = 255;
        OCR0B = 0;
        OCR2A = 255 / LEFT_MOTOR_QUOTIENT;
        OCR2B = 0;
    }
    else if (LEFT_MOTOR_QUOTIENT < RIGHT_MOTOR_QUOTIENT) {
        OCR0A = 255 / RIGHT_MOTOR_QUOTIENT;
        OCR0B = 0;
        OCR2A = 255;
        OCR2B = 0;
    }
    else if (LEFT_MOTOR_QUOTIENT == RIGHT_MOTOR_QUOTIENT) {
        OCR0A = 255;
        OCR0B = 0;
        OCR2A = 255;
        OCR2B = 0;
    }
}

void MoveStop (void) {

    OCR0A = 0;
    OCR0B = 0;
    OCR2A = 0;
    OCR2B = 0;

}

void MoveLeft (void) {

    OCR0A = 255;
    OCR0B = 0;
    OCR2A = 100;
    OCR2B = 0;

}

void MoveRight (void) {

    OCR0A = 100;
    OCR0B = 0;
    OCR2A = 255;
    OCR2B = 0;

}

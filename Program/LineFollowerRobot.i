
#pragma used+
sfrb PINB=3;
sfrb DDRB=4;
sfrb PORTB=5;
sfrb PINC=6;
sfrb DDRC=7;
sfrb PORTC=8;
sfrb PIND=9;
sfrb DDRD=0xa;
sfrb PORTD=0xb;
sfrb TIFR0=0x15;
sfrb TIFR1=0x16;
sfrb TIFR2=0x17;
sfrb PCIFR=0x1b;
sfrb EIFR=0x1c;
sfrb EIMSK=0x1d;
sfrb GPIOR0=0x1e;
sfrb EECR=0x1f;
sfrb EEDR=0x20;
sfrb EEARL=0x21;
sfrb EEARH=0x22;
sfrw EEAR=0x21;   
sfrb GTCCR=0x23;
sfrb TCCR0A=0x24;
sfrb TCCR0B=0x25;
sfrb TCNT0=0x26;
sfrb OCR0A=0x27;
sfrb OCR0B=0x28;
sfrb GPIOR1=0x2a;
sfrb GPIOR2=0x2b;
sfrb SPCR=0x2c;
sfrb SPSR=0x2d;
sfrb SPDR=0x2e;
sfrb ACSR=0x30;
sfrb MONDR=0x31;
sfrb SMCR=0x33;
sfrb MCUSR=0x34;
sfrb MCUCR=0x35;
sfrb SPMCSR=0x37;
sfrb SPL=0x3d;
sfrb SPH=0x3e;
sfrb SREG=0x3f;
#pragma used-

#asm
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_adc_noise_red=0x02
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.SET power_ctrl_reg=smcr
	#endif
#endasm

#pragma used+

void delay_us(unsigned int n);
void delay_ms(unsigned int n);

#pragma used-

#pragma used+

signed char cmax(signed char a,signed char b);
int max(int a,int b);
long lmax(long a,long b);
float fmax(float a,float b);
signed char cmin(signed char a,signed char b);
int min(int a,int b);
long lmin(long a,long b);
float fmin(float a,float b);
signed char csign(signed char x);
signed char sign(int x);
signed char lsign(long x);
signed char fsign(float x);
unsigned char isqrt(unsigned int x);
unsigned int lsqrt(unsigned long x);
float sqrt(float x);
float ftrunc(float x);
float floor(float x);
float ceil(float x);
float fmod(float x,float y);
float modf(float x,float *ipart);
float ldexp(float x,int expon);
float frexp(float x,int *expon);
float exp(float x);
float log(float x);
float log10(float x);
float pow(float x,float y);
float sin(float x);
float cos(float x);
float tan(float x);
float sinh(float x);
float cosh(float x);
float tanh(float x);
float asin(float x);
float acos(float x);
float atan(float x);
float atan2(float y,float x);

#pragma used-
#pragma library math.lib

typedef signed char int8_t;
typedef unsigned char uint8_t;

typedef short int16_t;
typedef unsigned short uint16_t;

typedef long int32_t;
typedef unsigned long uint32_t;

typedef short intptr_t;
typedef unsigned short uintptr_t;

typedef short flash_intptr_t;
typedef unsigned short flash_uintptr_t;

typedef short eeprom_intptr_t;
typedef unsigned short eeprom_uintptr_t;

_Bool line_data[8U						] = {0};					

void InitSys (void);
void ReadSensorLineData (void);
float CurrentRobotError (void);

void main (void) {

register float error_history[((uint8_t)10)			] = {0};		
register float error_sum = 0.0;						
register uint8_t i = 0;
register float P = 0.0;
register float I = 0.0;
register float D = 0.0;
register float PID_total_correction = 0.0;      	
register int16_t left_motor_speed = 0;
register int16_t right_motor_speed = 0;

InitSys ();

while (1) {
error_sum = 0.0;

for (i = 0; i < ((uint8_t)10)			 - 1; i++) {
error_history[i] = error_history[i + 1];
}
error_history[((uint8_t)10)			 - 1] = CurrentRobotError ();

P = error_history[((uint8_t)10)			 - 1] * ((uint8_t)1)			;			

for (i = 0; i < ((uint8_t)10)			; i++) {
error_sum += error_history[i];
}
I = error_sum * ((uint8_t)0)			;								

D = (error_history[((uint8_t)10)			 - 1] -        	
error_history[0]) * ((uint8_t)0)			;

PID_total_correction = (P + I) + D;

left_motor_speed  = ((uint8_t)155)			 - (uint16_t)PID_total_correction;
right_motor_speed = ((uint8_t)155)			 + (uint16_t)PID_total_correction;

if (left_motor_speed > 255)
left_motor_speed = 255;
else if (left_motor_speed < 0)
left_motor_speed = 0;
if (right_motor_speed > 255)
right_motor_speed = 255;
else if (right_motor_speed < 0)
right_motor_speed = 0;

(*(unsigned char *) 0xb3) = 0;
(*(unsigned char *) 0xb4) = left_motor_speed * ((float)1.0)			;
OCR0A = 0;
OCR0B = right_motor_speed * ((float)1.07);

delay_ms (((uint8_t)2)			);
}
}

void InitSys (void) {

DDRB |= (1 << 3       );			            	
DDRD |= (1 << 6       ) |			            	
(1 << 5       ) |			            	
(1 << 3       );			            	

DDRB &= ~((1 << 2       ) | (1 << 1       ) | (1 << 0       ));
DDRD &= ~(1 << 7       );

TCCR0A |= (1 << 7       ) | (1 << 5       ) | (1 << 1       ) | (1 << 0       );
TCCR0A &= ~((1 << 6       ) | (1 << 4       ) | (1 << 3) | (1 << 2));
TCCR0B |= (1 << 1       ) | (1 << 0       );
TCCR0B &= ~((1 << 7       ) | (1 << 6       ) | (1 << 5) | (1 << 4) | (1 << 3       ) | (1 << 2       ));
TCNT0  = 0x00;
(*(unsigned char *) 0x6e) = 0x00;
OCR0A  = 0x00;	OCR0B  = 0x00;

(*(unsigned char *) 0x80) |= (1 << 7       ) | (1 << 5       ) | (1 << 1       ) | (1 << 0       );
(*(unsigned char *) 0x80) &= ~((1 << 6       ) | (1 << 4       ) | (1 << 3) | (1 << 2));
(*(unsigned char *) 0x81) |= (1 << 3       ) | (1 << 1       ) | (1 << 0       );
(*(unsigned char *) 0x81) &= ~((1 << 7       ) | (1 << 6       ) | (1 << 5) | (1 << 4       ) | (1 << 2       ));
(*(unsigned char *) 0x82) = 0x00;
(*(unsigned char *) 0x85) = 0x00;	(*(unsigned char *) 0x84) = 0x00;
(*(unsigned char *) 0x6f) = 0x00;
(*(unsigned char *) 0x87)  = 0x00;	(*(unsigned char *) 0x86)  = 0x00;
(*(unsigned char *) 0x89) = 0x00;	(*(unsigned char *) 0x88) = 0x00;
(*(unsigned char *) 0x8b) = 0x00;	(*(unsigned char *) 0x8a) = 0x00;

(*(unsigned char *) 0xb0) |= (1 << 7       ) | (1 << 5       ) | (1 << 1       ) | (1 << 0       );
(*(unsigned char *) 0xb0) &= ~((1 << 6       ) | (1 << 4       ) | (1 << 3) | (1 << 2));
(*(unsigned char *) 0xb1) |= (1 << 2       );
(*(unsigned char *) 0xb1) &= ~((1 << 7       ) | (1 << 6       ) | (1 << 5) | (1 << 4) | (1 << 3       ) | (1 << 1       ) | (1 << 0       ));
(*(unsigned char *) 0xb2)  = 0x00;
(*(unsigned char *) 0x70) = 0x00;
(*(unsigned char *) 0xb3)  = 0x00;	(*(unsigned char *) 0xb4)  = 0x00;

#pragma optsize-
(*(unsigned char *) 0x61) |= (1 << 7       );
(*(unsigned char *) 0x61) = 0x00;
#pragma optsize+
}

void ReadSensorLineData (void) {
line_data[0] = PIND & (1 << 2       );
line_data[1] = PIND & (1 << 4       );
line_data[2] = PINC & (1 << 5       );
line_data[3] = PINC & (1 << 4       );
line_data[4] = PINC & (1 << 3       );
line_data[5] = PINC & (1 << 2       );
line_data[6] = PINC & (1 << 1       );
line_data[7] = PINC & (1 << 0       );
}

float CurrentRobotError (void) {
register uint8_t i = 0;
register float current_error = 0.0;

ReadSensorLineData ();

for (i = 0; i < 8U						; i++) {
if (line_data[i] != 0) {

current_error += pow (8U						 / 2 - 0.5 - i, 3);
}
}

return current_error;
}

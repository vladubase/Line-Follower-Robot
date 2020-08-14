
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

unsigned short int SensorLineData = 0x0000;
float AngleOfRotation = 0.0;

void InitSys (void) {

DDRB |= (1 << 4       );			
DDRD |= (1 << 6       ) |			
(1 << 5       ) |		    
(1 << 3       );		    

DDRC |= (1 << 0       ) |
(1 << 1       ) |
(1 << 2       ) |
(1 << 3       ) |
(1 << 4       ) |
(1 << 5       );
DDRD |= (1 << 2       ) |
(1 << 4       );

TCCR0A |= (1 << 7       ) | (1 << 5       ) | (1 << 0       );
TCCR0A &= ~((1 << 6       ) | (1 << 4       ) | (1 << 3) | (1 << 2) | (1 << 1       ));
TCCR0B |= (1 << 2       ) | (1 << 0       );
TCCR0B &= ~((1 << 7       ) | (1 << 6       ) | (1 << 5) | (1 << 4) | (1 << 3       ) | (1 << 1       ));
TCNT0  = 0x00;
OCR0A  = 0x00;    OCR0B  = 0x00;

(*(unsigned char *) 0x80) = 0x00;
(*(unsigned char *) 0x81) = 0x00;
(*(unsigned char *) 0x85) = 0x00;    (*(unsigned char *) 0x84) = 0x00;
(*(unsigned char *) 0x87)  = 0x00;    (*(unsigned char *) 0x86)  = 0x00;
(*(unsigned char *) 0x89) = 0x00;    (*(unsigned char *) 0x88) = 0x00;
(*(unsigned char *) 0x8b) = 0x00;    (*(unsigned char *) 0x8a) = 0x00;

(*(unsigned char *) 0xb0) |= (1 << 7       ) | (1 << 5       ) | (1 << 0       );
(*(unsigned char *) 0xb0) &= ~((1 << 6       ) | (1 << 4       ) | (1 << 3) | (1 << 2) | (1 << 1       ));
(*(unsigned char *) 0xb1) |= (1 << 2       ) | (1 << 1       ) | (1 << 0       );
(*(unsigned char *) 0xb1) &= ~((1 << 7       ) | (1 << 6       ) | (1 << 5) | (1 << 4) | (1 << 3       ));
(*(unsigned char *) 0xb2)  = 0x00;
(*(unsigned char *) 0xb3)  = 0x00;    (*(unsigned char *) 0xb4)  = 0x00;

#pragma optsize-
(*(unsigned char *) 0x61)  = 0x80;
(*(unsigned char *) 0x61)  = 0x00;
#pragma optsize+

(*(unsigned char *) 0x69)  = 0x00;
EIMSK  = 0x00;
(*(unsigned char *) 0x68)  = 0x00;

(*(unsigned char *) 0x6e) = 0x00;

(*(unsigned char *) 0x6f) = 0x00;

(*(unsigned char *) 0x70) = 0x00;

(*(unsigned char *) 0xc1) = 0x00;

ACSR   = 0x80;
(*(unsigned char *) 0x7b) = 0x00;
(*(unsigned char *) 0x7f)  = 0x00;

(*(unsigned char *) 0x7a) = 0x00;

SPCR   = 0x00;

(*(unsigned char *) 0xbc)   = 0x00;

}

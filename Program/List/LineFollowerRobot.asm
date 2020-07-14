
;CodeVisionAVR C Compiler V2.05.3 Standard
;(C) Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type                : ATmega328P
;Program type             : Application
;Clock frequency          : 20,000000 MHz
;Memory model             : Small
;Optimize for             : Size
;(s)printf features       : int, width
;(s)scanf features        : int, width
;External RAM size        : 0
;Data Stack size          : 512 byte(s)
;Heap size                : 0 byte(s)
;Promote 'char' to 'int'  : No
;'char' is unsigned       : No
;8 bit enums              : Yes
;Global 'const' stored in FLASH     : No
;Enhanced function parameter passing: Yes
;Enhanced core instructions         : On
;Smart register allocation          : On
;Automatic register allocation      : On

	#pragma AVRPART ADMIN PART_NAME ATmega328P
	#pragma AVRPART MEMORY PROG_FLASH 32768
	#pragma AVRPART MEMORY EEPROM 1024
	#pragma AVRPART MEMORY INT_SRAM SIZE 2303
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU EECR=0x1F
	.EQU EEDR=0x20
	.EQU EEARL=0x21
	.EQU EEARH=0x22
	.EQU SPSR=0x2D
	.EQU SPDR=0x2E
	.EQU SMCR=0x33
	.EQU MCUSR=0x34
	.EQU MCUCR=0x35
	.EQU WDTCSR=0x60
	.EQU UCSR0A=0xC0
	.EQU UDR0=0xC6
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU GPIOR0=0x1E

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0100
	.EQU __SRAM_END=0x08FF
	.EQU __DSTACK_SIZE=0x0200
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __GETD1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X+
	LD   R22,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;GPIOR0 INITIALIZATION VALUE
	.EQU __GPIOR0_INIT=0x00

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_0x3:
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0
_0x2020060:
	.DB  0x1
_0x2020000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  __seed_G101
	.DW  _0x2020060*2

_0xFFFFFFFF:
	.DW  0

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	WDR
	IN   R26,MCUSR
	CBR  R26,8
	OUT  MCUSR,R26
	STS  WDTCSR,R31
	STS  WDTCSR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;GPIOR0 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x300

	.CSEG
;/****
;	*	@name		LINE FOLLOWER ROBOT
;	*	@file 		LineFollowerRobot.c
;	*
;	*	@author 	Uladzislau 'vladubase' Dubatouka
;	*				<vladubase@gmail.com>.
;	*	@version	V1.1
;	*	@date 		Created on 2020.07.14.
;	*
;	*	@brief 		This program is controlling the Line following robot using PID regulator.
;	*				It has a flexible settings system via #defines at the beginning of the .C main file.
;	*				IO ports are configured through registers.
;	*
;	*  	@attention 	"The usual procedure for setting up the PID regulator:
;	*					1. At a low speed, we adjust the P-controller (we select a value of kP such
;	*						that in the coolest turns the robot passes keeping the line close to its
;	*						extreme sensors). kD and kI are equal to zero, i.e. use a pure P-regulator;
;	*					2. Increase the speed, select the value of kD. If the robot went without
;	*						inertia when setting the P-controller, then the kP value can be left unchanged.
;	*						If the robot has already gone with inertia, as is usually the case
;	*						with fast robots, then the kP value will need to be lowered -
;	*						we will see this by the fact that the robot will cease to deviate
;	*						strongly from the line thanks to the help of the D-controller;
;	*					3. When the PD controller is configured, then I can be selected,
;	*						reducing the deviation of the robot from the line. The values ​​of
;	*						the coefficients kD and kP are usually also somewhat lower.
;	*						An i-controller is useful for racing where a line can make loops.
;	*						Deviation of the robot from a straight line is fraught with
;	*						the choice of the wrong direction of movement. When racing on tracks
;	*						without loops, the PD controller is often used, since in the general
;	*						case it allows you to develop a higher speed."
;	*						(Credit: https://www.goodlancer.com/pid-control/).
;	*
;	*   @note	4.25 ms for main cycle (not counting MAIN_CYCLE_DELAY) with 4 low-level sensors.
;	*			6 ms for main cycle (not counting MAIN_CYCLE_DELAY) with 15 low-level sensors.
;	*
;*****/
;
;/**************************** Includes ****************************/
;
;#include <mega328p.h>
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
;#include <mega328p_bits.h>
;#include <delay.h>
;#include <math.h>
;#include <stdbool.h>
;#include <stdint.h>
;
;/***************************** Defines ****************************/
;
;#define		F_CPU				((uint32_t)20000000)	// Quartz resonator clock frequency
;
;#define		QTY_OF_SENSORS		8						// Quantity of sensors
;#define		AVG_SPEED			((uint8_t)155)			// Average speed of robot
;
;#define		MOTORS_NOT_PERFECT	true 					// Do the motors have different real parameters (e.g. Speed, Torque, etc.)?
;#if MOTORS_NOT_PERFECT									// There is nothing perfect ;)
;	#define	L_MOTOR_MISMATCH	((float)1.0)			// Coefficient of motor power difference
;	#define	R_MOTOR_MISMATCH	((float)1.07)			// Coefficient of motor power difference
;#endif /* MOTORS_NOT_PERFECT */
;
;// PID
;// Setup: P -> PD -> PID
;#define		kP					((uint8_t)1)			// Proportional	feedback coefficient
;#define		kI					((uint8_t)0)			// Integral 	feedback coefficient
;#define		kD					((uint8_t)0)			// Differential	feedback coefficient
;#define		QTY_OF_ERR			((uint8_t)10)			// Quantity of errors in memory during last (QTY_OF_ERR * MAIN_CYCLE_DELAY) ms
;#define		MAIN_CYCLE_DELAY	((uint8_t)2)			// The main cycle delay (in ms) for correct work of D-regulation
;
;// Sensor order in the right --> direction
;#if (QTY_OF_SENSORS >= 1)
;    #define	READ_SENSOR_1		PIND & (1 << DDD2)
;#endif /* QTY_OF_SENSORS >= 1 */
;#if QTY_OF_SENSORS >= 2
;    #define	READ_SENSOR_2		PIND & (1 << DDD4)
;#endif /* QTY_OF_SENSORS >= 2 */
;#if QTY_OF_SENSORS >= 3
;    #define	READ_SENSOR_3		PINC & (1 << DDC5)
;#endif /* QTY_OF_SENSORS >= 3 */
;#if QTY_OF_SENSORS >= 4
;    #define	READ_SENSOR_4		PINC & (1 << DDC4)
;#endif /* QTY_OF_SENSORS >= 4 */
;#if QTY_OF_SENSORS >= 5
;    #define	READ_SENSOR_5		PINC & (1 << DDC3)
;#endif /* QTY_OF_SENSORS >= 5 */
;#if QTY_OF_SENSORS >= 6
;    #define	READ_SENSOR_6		PINC & (1 << DDC2)
;#endif /* QTY_OF_SENSORS >= 6 */
;#if QTY_OF_SENSORS >= 7
;    #define	READ_SENSOR_7		PINC & (1 << DDC1)
;#endif /* QTY_OF_SENSORS >= 7 */
;#if QTY_OF_SENSORS >= 8
;    #define	READ_SENSOR_8		PINC & (1 << DDC0)
;#endif /* QTY_OF_SENSORS >= 8 */
;#if QTY_OF_SENSORS >= 9
;    #define	READ_SENSOR_9		PINx & (1 << DDxx)
;#endif /* QTY_OF_SENSORS >= 9 */
;#if QTY_OF_SENSORS >= 10
;    #define	READ_SENSOR_10		PINx & (1 << DDxx)
;#endif /* QTY_OF_SENSORS >= 10 */
;#if QTY_OF_SENSORS >= 11
;    #define	READ_SENSOR_11		PINx & (1 << DDxx)
;#endif /* QTY_OF_SENSORS >= 11 */
;#if QTY_OF_SENSORS >= 12
;    #define	READ_SENSOR_12		PINx & (1 << DDxx)
;#endif /* QTY_OF_SENSORS >= 12 */
;#if QTY_OF_SENSORS >= 13
;    #define	READ_SENSOR_13		PINx & (1 << DDxx)
;#endif /* QTY_OF_SENSORS >= 13 */
;#if QTY_OF_SENSORS >= 14
;    #define	READ_SENSOR_14		PINx & (1 << DDxx)
;#endif /* QTY_OF_SENSORS >= 14 */
;#if QTY_OF_SENSORS >= 15
;    #define	READ_SENSOR_15		PINx & (1 << DDxx)
;#endif /* QTY_OF_SENSORS >= 15 */
;#if QTY_OF_SENSORS >= 16
;    #define	READ_SENSOR_16		PINx & (1 << DDxx)
;#endif /* QTY_OF_SENSORS >= 16 */
;
;//#define	READ_IR_SENSOR		PINx & (1 << DDxx)
;
;/************************* Global Variables ***********************/
;
;bool line_data[QTY_OF_SENSORS] = {0};					// Store current values from sensor line
;
;/*********************** Function  prototypes *********************/
;
;void InitSys (void);
;void ReadSensorLineData (void);
;float CurrentRobotError (void);
;
;/****************************** Main ******************************/
;
;void main (void) {
; 0000 0085 void main (void) {

	.CSEG
_main:
; 0000 0086 	// DEFINITION OF VARIABLES
; 0000 0087 	register float error_history[QTY_OF_ERR] = {0};		// Storing the values of recent errors
; 0000 0088 	register float error_sum = 0.0;						// Sum of errors in history
; 0000 0089 	register uint8_t i = 0;
; 0000 008A 	register float P = 0.0;
; 0000 008B 	register float I = 0.0;
; 0000 008C 	register float D = 0.0;
; 0000 008D 	register float PID_total_correction = 0.0;      	// Sum of P, I, D
; 0000 008E 	register int16_t left_motor_speed = 0;
; 0000 008F 	register int16_t right_motor_speed = 0;
; 0000 0090 
; 0000 0091 	// MICROCONTROLLER INITIALIZATION
; 0000 0092 	InitSys ();
	SBIW R28,60
	LDI  R24,60
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x3*2)
	LDI  R31,HIGH(_0x3*2)
	CALL __INITLOCB
;	error_history -> Y+20
;	error_sum -> Y+16
;	i -> R17
;	P -> Y+12
;	I -> Y+8
;	D -> Y+4
;	PID_total_correction -> Y+0
;	left_motor_speed -> R18,R19
;	right_motor_speed -> R20,R21
	LDI  R17,0
	__GETWRN 18,19,0
	__GETWRN 20,21,0
	RCALL _InitSys
; 0000 0093 
; 0000 0094 	// Waiting for a signal on IR sensor
; 0000 0095 	#ifdef READ_IR_SENSOR
; 0000 0096 		while (READ_IR_SENSOR) {
; 0000 0097 			LED_1_ON;
; 0000 0098 			delay_ms (25);
; 0000 0099 			LED_1_OFF;
; 0000 009A 			delay_ms (25);
; 0000 009B 		}
; 0000 009C 	#endif /* READ_IR_SENSOR */
; 0000 009D 
; 0000 009E 	//delay_ms (5000);									// This delay is required by the competition rules
; 0000 009F 
; 0000 00A0 	// MAIN CYCLE
; 0000 00A1 	while (true) {
_0x4:
; 0000 00A2 		error_sum = 0.0;
	LDI  R30,LOW(0)
	__CLRD1S 16
; 0000 00A3 
; 0000 00A4 	    // Shift error values
; 0000 00A5 		for (i = 0; i < QTY_OF_ERR - 1; i++) {
	LDI  R17,LOW(0)
_0x8:
	CPI  R17,9
	BRSH _0x9
; 0000 00A6 			error_history[i] = error_history[i + 1];
	CALL SUBOPT_0x0
	ADD  R30,R26
	ADC  R31,R27
	MOVW R0,R30
	MOV  R30,R17
	SUBI R30,-LOW(1)
	LDI  R31,0
	MOVW R26,R28
	ADIW R26,20
	CALL __LSLW2
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETD1P
	MOVW R26,R0
	CALL __PUTDP1
; 0000 00A7 		}
	SUBI R17,-1
	RJMP _0x8
_0x9:
; 0000 00A8 		error_history[QTY_OF_ERR - 1] = CurrentRobotError ();
	RCALL _CurrentRobotError
	__PUTD1S 56
; 0000 00A9 
; 0000 00AA 		// Calculation of value P
; 0000 00AB 		P = error_history[QTY_OF_ERR - 1] * kP;			// Current error * kP
	__GETD2S 56
	CALL SUBOPT_0x1
	CALL __MULF12
	__PUTD1S 12
; 0000 00AC 		// Calculation of value I
; 0000 00AD 		for (i = 0; i < QTY_OF_ERR; i++) {
	LDI  R17,LOW(0)
_0xB:
	CPI  R17,10
	BRSH _0xC
; 0000 00AE 			error_sum += error_history[i];
	CALL SUBOPT_0x0
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETD1P
	__GETD2S 16
	CALL __ADDF12
	__PUTD1S 16
; 0000 00AF 		}
	SUBI R17,-1
	RJMP _0xB
_0xC:
; 0000 00B0 		I = error_sum * kI;								// sum of errors * kI
	__GETD2S 16
	CALL SUBOPT_0x2
	CALL __MULF12
	__PUTD1S 8
; 0000 00B1 		// Calculation of value D
; 0000 00B2 		D = (error_history[QTY_OF_ERR - 1] -        	// (current error - first error) * kD
; 0000 00B3         	error_history[0]) * kD;
	__GETD2S 20
	__GETD1S 56
	CALL __SUBF12
	__GETD2N 0x0
	CALL __MULF12
	__PUTD1S 4
; 0000 00B4 
; 0000 00B5 		PID_total_correction = (P + I) + D;
	CALL SUBOPT_0x3
	__GETD2S 12
	CALL __ADDF12
	CALL SUBOPT_0x4
	CALL __ADDF12
	CALL __PUTD1S0
; 0000 00B6 
; 0000 00B7 		//
; 0000 00B8 		left_motor_speed  = AVG_SPEED - (uint16_t)PID_total_correction;
	CALL SUBOPT_0x5
	LDI  R26,LOW(155)
	LDI  R27,HIGH(155)
	SUB  R26,R30
	SBC  R27,R31
	MOVW R18,R26
; 0000 00B9 		right_motor_speed = AVG_SPEED + (uint16_t)PID_total_correction;
	CALL SUBOPT_0x5
	SUBI R30,LOW(-155)
	SBCI R31,HIGH(-155)
	MOVW R20,R30
; 0000 00BA 
; 0000 00BB 		// Validating a range of variables
; 0000 00BC 		if (left_motor_speed > 255)
	__CPWRN 18,19,256
	BRLT _0xD
; 0000 00BD 			left_motor_speed = 255;
	__GETWRN 18,19,255
; 0000 00BE 		else if (left_motor_speed < 0)
	RJMP _0xE
_0xD:
	TST  R19
	BRPL _0xF
; 0000 00BF 			left_motor_speed = 0;
	__GETWRN 18,19,0
; 0000 00C0 		if (right_motor_speed > 255)
_0xF:
_0xE:
	__CPWRN 20,21,256
	BRLT _0x10
; 0000 00C1 			right_motor_speed = 255;
	__GETWRN 20,21,255
; 0000 00C2 		else if (right_motor_speed < 0)
	RJMP _0x11
_0x10:
	TST  R21
	BRPL _0x12
; 0000 00C3 			right_motor_speed = 0;
	__GETWRN 20,21,0
; 0000 00C4 
; 0000 00C5 		// Motors power difference compensation
; 0000 00C6 		#if MOTORS_NOT_PERFECT
; 0000 00C7 			OCR2A = 0;
_0x12:
_0x11:
	LDI  R30,LOW(0)
	STS  179,R30
; 0000 00C8 			OCR2B = left_motor_speed * L_MOTOR_MISMATCH;
	MOVW R30,R18
	CALL SUBOPT_0x6
	CALL SUBOPT_0x7
	CALL __MULF12
	LDI  R26,LOW(180)
	LDI  R27,HIGH(180)
	CALL __CFD1U
	ST   X,R30
; 0000 00C9 			OCR0A = 0;
	LDI  R30,LOW(0)
	OUT  0x27,R30
; 0000 00CA 			OCR0B = right_motor_speed * R_MOTOR_MISMATCH;
	MOVW R30,R20
	CALL SUBOPT_0x6
	__GETD2N 0x3F88F5C3
	CALL __MULF12
	CALL __CFD1U
	OUT  0x28,R30
; 0000 00CB 		#else
; 0000 00CC 			OCR2A = 0;
; 0000 00CD 			OCR2B = left_motor_speed;
; 0000 00CE 			OCR0A = 0;
; 0000 00CF 			OCR0B = right_motor_speed;
; 0000 00D0 		#endif /* MOTORS_NOT_PERFECT */
; 0000 00D1 
; 0000 00D2 		delay_ms (MAIN_CYCLE_DELAY);
	LDI  R26,LOW(2)
	LDI  R27,0
	CALL _delay_ms
; 0000 00D3 	}
	RJMP _0x4
; 0000 00D4 }
_0x13:
	RJMP _0x13
;
;/*************************** Functions ****************************/
;
;void InitSys (void) {
; 0000 00D8 void InitSys (void) {
_InitSys:
; 0000 00D9 	// Motors
; 0000 00DA 	    // Output mode
; 0000 00DB 		DDRB |= (1 << DDB3);			            	// OC2A
	SBI  0x4,3
; 0000 00DC 		DDRD |= (1 << DDD6) |			            	// OC0A
; 0000 00DD 				(1 << DDD5) |			            	// OC0B
; 0000 00DE 				(1 << DDD3);			            	// OC2B
	IN   R30,0xA
	ORI  R30,LOW(0x68)
	OUT  0xA,R30
; 0000 00DF 
; 0000 00E0 	// SensorLine
; 0000 00E1 	    // Input mode
; 0000 00E2 		DDRB &= ~((1 << DDB2) | (1 << DDB1) | (1 << DDB0));
	IN   R30,0x4
	ANDI R30,LOW(0xF8)
	OUT  0x4,R30
; 0000 00E3 		DDRD &= ~(1 << DDD7);
	CBI  0xA,7
; 0000 00E4 
; 0000 00E5 	// Infrared Sensor
; 0000 00E6 	    // Input mode
; 0000 00E7 		#ifdef READ_SENSOR_IR
; 0000 00E8 			DDRx &= ~(1 << DDxx);
; 0000 00E9 		#endif /* READ_SENSOR_IR */
; 0000 00EA 
; 0000 00EB 	// Timer/Counter(s) initialization
; 0000 00EC 		// Timer/Counter 0
; 0000 00ED 		// Fast PWM Mode
; 0000 00EE 		// Clear OC0A on Compare Match, set OC0A at BOTTOM (non-inverting mode)
; 0000 00EF 		// TOP = 0xFF
; 0000 00F0 		// Prescaler: 1:64
; 0000 00F1 		TCCR0A |= (1 << COM0A1) | (1 << COM0B1) | (1 << WGM01) | (1 << WGM00);
	IN   R30,0x24
	ORI  R30,LOW(0xA3)
	OUT  0x24,R30
; 0000 00F2 		TCCR0A &= ~((1 << COM0A0) | (1 << COM0B0) | (1 << 3) | (1 << 2));
	IN   R30,0x24
	ANDI R30,LOW(0xA3)
	OUT  0x24,R30
; 0000 00F3 		TCCR0B |= (1 << CS01) | (1 << CS00);
	IN   R30,0x25
	ORI  R30,LOW(0x3)
	OUT  0x25,R30
; 0000 00F4 		TCCR0B &= ~((1 << FOC0A) | (1 << FOC0B) | (1 << 5) | (1 << 4) | (1 << WGM02) | (1 << CS02));
	IN   R30,0x25
	ANDI R30,LOW(0x3)
	OUT  0x25,R30
; 0000 00F5 		TCNT0  = 0x00;
	LDI  R30,LOW(0)
	OUT  0x26,R30
; 0000 00F6 		TIMSK0 = 0x00;
	STS  110,R30
; 0000 00F7 		OCR0A  = 0x00;	OCR0B  = 0x00;
	OUT  0x27,R30
	OUT  0x28,R30
; 0000 00F8 
; 0000 00F9 		// Timer/Counter 1
; 0000 00FA 		// Fast PWM 10-bit Mode
; 0000 00FB 		// Clear OC1A/OC1B on Compare Match, set OC1A/OC1B at BOTTOM (non-inverting mode)
; 0000 00FC 		// TOP = 0x03FF
; 0000 00FD 		// Prescaler: 1:64
; 0000 00FE 		TCCR1A |= (1 << COM1A1) | (1 << COM1B1) | (1 << WGM11) | (1 << WGM10);
	LDS  R30,128
	ORI  R30,LOW(0xA3)
	STS  128,R30
; 0000 00FF 		TCCR1A &= ~((1 << COM1A0) | (1 << COM1B0) | (1 << 3) | (1 << 2));
	LDS  R30,128
	ANDI R30,LOW(0xA3)
	STS  128,R30
; 0000 0100 		TCCR1B |= (1 << WGM12) | (1 << CS11) | (1 << CS10);
	LDS  R30,129
	ORI  R30,LOW(0xB)
	STS  129,R30
; 0000 0101 		TCCR1B &= ~((1 << ICNC1) | (1 << ICES1) | (1 << 5) | (1 << WGM13) | (1 << CS12));
	LDS  R30,129
	ANDI R30,LOW(0xB)
	STS  129,R30
; 0000 0102 		TCCR1C = 0x00;
	LDI  R30,LOW(0)
	STS  130,R30
; 0000 0103 		TCNT1H = 0x00;	TCNT1L = 0x00;
	STS  133,R30
	STS  132,R30
; 0000 0104 		TIMSK1 = 0x00;
	STS  111,R30
; 0000 0105 		ICR1H  = 0x00;	ICR1L  = 0x00;
	STS  135,R30
	STS  134,R30
; 0000 0106 		OCR1AH = 0x00;	OCR1AL = 0x00;
	STS  137,R30
	STS  136,R30
; 0000 0107 		OCR1BH = 0x00;	OCR1BL = 0x00;
	STS  139,R30
	STS  138,R30
; 0000 0108 
; 0000 0109 		// Timer/Counter 2
; 0000 010A 		// Fast PWM Mode
; 0000 010B 		// Clear OC0A on Compare Match, set OC0A at BOTTOM (non-inverting mode)
; 0000 010C 		// TOP = 0xFF
; 0000 010D 		// Prescaler: 1:64
; 0000 010E 		TCCR2A |= (1 << COM2A1) | (1 << COM2B1) | (1 << WGM21) | (1 << WGM20);
	LDS  R30,176
	ORI  R30,LOW(0xA3)
	STS  176,R30
; 0000 010F 		TCCR2A &= ~((1 << COM2A0) | (1 << COM2B0) | (1 << 3) | (1 << 2));
	LDS  R30,176
	ANDI R30,LOW(0xA3)
	STS  176,R30
; 0000 0110 		TCCR2B |= (1 << CS22);
	LDS  R30,177
	ORI  R30,4
	STS  177,R30
; 0000 0111 		TCCR2B &= ~((1 << FOC2A) | (1 << FOC2B) | (1 << 5) | (1 << 4) | (1 << WGM22) | (1 << CS21) | (1 << CS20));
	LDS  R30,177
	ANDI R30,LOW(0x4)
	STS  177,R30
; 0000 0112 		TCNT2  = 0x00;
	LDI  R30,LOW(0)
	STS  178,R30
; 0000 0113 		TIMSK2 = 0x00;
	STS  112,R30
; 0000 0114 		OCR2A  = 0x00;	OCR2B  = 0x00;
	STS  179,R30
	STS  180,R30
; 0000 0115 
; 0000 0116 	// Crystal Oscillator division factor: 1
; 0000 0117 		#pragma optsize-
; 0000 0118 			CLKPR |= (1 << CLKPCE);
	LDS  R30,97
	ORI  R30,0x80
	STS  97,R30
; 0000 0119 			CLKPR = 0x00;
	LDI  R30,LOW(0)
	STS  97,R30
; 0000 011A 		#ifdef _OPTIMIZE_SIZE_
; 0000 011B 			#pragma optsize+
; 0000 011C 		#endif /* _OPTIMIZE_SIZE_ */
; 0000 011D }
	RET
;
;void ReadSensorLineData (void) {
; 0000 011F void ReadSensorLineData (void) {
_ReadSensorLineData:
; 0000 0120 	#ifdef READ_SENSOR_1
; 0000 0121 		line_data[0] = READ_SENSOR_1;
	IN   R30,0x9
	ANDI R30,LOW(0x4)
	LDI  R26,LOW(_line_data)
	LDI  R27,HIGH(_line_data)
	CALL SUBOPT_0x8
; 0000 0122 	#endif /* READ_SENSOR_1 */
; 0000 0123 	#ifdef READ_SENSOR_2
; 0000 0124 		line_data[1] = READ_SENSOR_2;
	__POINTW2MN _line_data,1
	IN   R30,0x9
	ANDI R30,LOW(0x10)
	CALL SUBOPT_0x8
; 0000 0125 	#endif /* READ_SENSOR_2 */
; 0000 0126 	#ifdef READ_SENSOR_3
; 0000 0127 		line_data[2] = READ_SENSOR_3;
	__POINTW2MN _line_data,2
	IN   R30,0x6
	ANDI R30,LOW(0x20)
	CALL SUBOPT_0x8
; 0000 0128 	#endif /* READ_SENSOR_3 */
; 0000 0129 	#ifdef READ_SENSOR_4
; 0000 012A 		line_data[3] = READ_SENSOR_4;
	__POINTW2MN _line_data,3
	IN   R30,0x6
	ANDI R30,LOW(0x10)
	CALL SUBOPT_0x8
; 0000 012B 	#endif /* READ_SENSOR_4 */
; 0000 012C 	#ifdef READ_SENSOR_5
; 0000 012D 		line_data[4] = READ_SENSOR_5;
	__POINTW2MN _line_data,4
	IN   R30,0x6
	ANDI R30,LOW(0x8)
	CALL SUBOPT_0x8
; 0000 012E 	#endif /* READ_SENSOR_5 */
; 0000 012F 	#ifdef READ_SENSOR_6
; 0000 0130 		line_data[5] = READ_SENSOR_6;
	__POINTW2MN _line_data,5
	IN   R30,0x6
	ANDI R30,LOW(0x4)
	CALL SUBOPT_0x8
; 0000 0131 	#endif /* READ_SENSOR_6 */
; 0000 0132 	#ifdef READ_SENSOR_7
; 0000 0133 		line_data[6] = READ_SENSOR_7;
	__POINTW2MN _line_data,6
	IN   R30,0x6
	ANDI R30,LOW(0x2)
	CALL SUBOPT_0x8
; 0000 0134 	#endif /* READ_SENSOR_7 */
; 0000 0135 	#ifdef READ_SENSOR_8
; 0000 0136 		line_data[7] = READ_SENSOR_8;
	__POINTW2MN _line_data,7
	IN   R30,0x6
	ANDI R30,LOW(0x1)
	CALL SUBOPT_0x8
; 0000 0137 	#endif /* READ_SENSOR_8 */
; 0000 0138 	#ifdef READ_SENSOR_9
; 0000 0139 		line_data[8] = READ_SENSOR_9;
; 0000 013A 	#endif /* READ_SENSOR_9 */
; 0000 013B 	#ifdef READ_SENSOR_10
; 0000 013C 		line_data[9] = READ_SENSOR_10;
; 0000 013D 	#endif /* READ_SENSOR_10 */
; 0000 013E 	#ifdef READ_SENSOR_11
; 0000 013F 		line_data[10] = READ_SENSOR_11;
; 0000 0140 	#endif /* READ_SENSOR_11 */
; 0000 0141 	#ifdef READ_SENSOR_12
; 0000 0142 		line_data[11] = READ_SENSOR_12;
; 0000 0143 	#endif /* READ_SENSOR_12 */
; 0000 0144 	#ifdef READ_SENSOR_13
; 0000 0145 		line_data[12] = READ_SENSOR_13;
; 0000 0146 	#endif /* READ_SENSOR_13 */
; 0000 0147 	#ifdef READ_SENSOR_14
; 0000 0148 		line_data[13] = READ_SENSOR_14;
; 0000 0149 	#endif /* READ_SENSOR_14 */
; 0000 014A 	#ifdef READ_SENSOR_15
; 0000 014B 		line_data[14] = READ_SENSOR_15;
; 0000 014C 	#endif /* READ_SENSOR_15 */
; 0000 014D 	#ifdef READ_SENSOR_16
; 0000 014E 		line_data[15] = READ_SENSOR_16;
; 0000 014F 	#endif /* READ_SENSOR_16 */
; 0000 0150 }
	RET
;
;float CurrentRobotError (void) {
; 0000 0152 float CurrentRobotError (void) {
_CurrentRobotError:
; 0000 0153 	register uint8_t i = 0;
; 0000 0154 	register float current_error = 0.0;
; 0000 0155 
; 0000 0156 	ReadSensorLineData ();
	SBIW R28,4
	LDI  R30,LOW(0)
	ST   Y,R30
	STD  Y+1,R30
	STD  Y+2,R30
	STD  Y+3,R30
	ST   -Y,R17
;	i -> R17
;	current_error -> Y+1
	LDI  R17,0
	RCALL _ReadSensorLineData
; 0000 0157 
; 0000 0158 	for (i = 0; i < QTY_OF_SENSORS; i++) {
	LDI  R17,LOW(0)
_0x15:
	CPI  R17,8
	BRSH _0x16
; 0000 0159 	    if (line_data[i] == 0) {
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-_line_data)
	SBCI R31,HIGH(-_line_data)
	LD   R30,Z
	CPI  R30,0
	BRNE _0x17
; 0000 015A             // If the data on the [i]th sensor is zero,
; 0000 015B             // then the sensor is located above the black line
; 0000 015C             // Odd degree to preserve the sign '-'
; 0000 015D             current_error += pow (QTY_OF_SENSORS / 2 - 0.5 - i, 3);
	MOV  R30,R17
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __CDF1
	__GETD2N 0x40600000
	CALL SUBOPT_0x9
	CALL __PUTPARD1
	__GETD2N 0x40400000
	CALL _pow
	__GETD2S 1
	CALL __ADDF12
	__PUTD1S 1
; 0000 015E         }
; 0000 015F 	}
_0x17:
	SUBI R17,-1
	RJMP _0x15
_0x16:
; 0000 0160 
; 0000 0161 	return current_error;
	__GETD1S 1
	LDD  R17,Y+0
	ADIW R28,5
	RET
; 0000 0162 }

	.CSEG
_ftrunc:
	CALL __PUTPARD2
   ldd  r23,y+3
   ldd  r22,y+2
   ldd  r31,y+1
   ld   r30,y
   bst  r23,7
   lsl  r23
   sbrc r22,7
   sbr  r23,1
   mov  r25,r23
   subi r25,0x7e
   breq __ftrunc0
   brcs __ftrunc0
   cpi  r25,24
   brsh __ftrunc1
   clr  r26
   clr  r27
   clr  r24
__ftrunc2:
   sec
   ror  r24
   ror  r27
   ror  r26
   dec  r25
   brne __ftrunc2
   and  r30,r26
   and  r31,r27
   and  r22,r24
   rjmp __ftrunc1
__ftrunc0:
   clt
   clr  r23
   clr  r30
   clr  r31
   clr  r22
__ftrunc1:
   cbr  r22,0x80
   lsr  r23
   brcc __ftrunc3
   sbr  r22,0x80
__ftrunc3:
   bld  r23,7
   ld   r26,y+
   ld   r27,y+
   ld   r24,y+
   ld   r25,y+
   cp   r30,r26
   cpc  r31,r27
   cpc  r22,r24
   cpc  r23,r25
   bst  r25,7
   ret
_floor:
	CALL __PUTPARD2
	CALL __GETD2S0
	CALL _ftrunc
	CALL __PUTD1S0
    brne __floor1
__floor0:
	CALL SUBOPT_0xA
	RJMP _0x2080004
__floor1:
    brtc __floor0
	CALL SUBOPT_0xA
	CALL SUBOPT_0x7
	CALL __SUBF12
_0x2080004:
	ADIW R28,4
	RET
_log:
	CALL __PUTPARD2
	SBIW R28,4
	ST   -Y,R17
	ST   -Y,R16
	CALL SUBOPT_0xB
	CALL __CPD02
	BRLT _0x200000C
	__GETD1N 0xFF7FFFFF
	RJMP _0x2080003
_0x200000C:
	CALL SUBOPT_0xC
	CALL __PUTPARD1
	IN   R26,SPL
	IN   R27,SPH
	SBIW R26,1
	PUSH R17
	PUSH R16
	CALL _frexp
	POP  R16
	POP  R17
	CALL SUBOPT_0xD
	CALL SUBOPT_0xB
	__GETD1N 0x3F3504F3
	CALL __CMPF12
	BRSH _0x200000D
	CALL SUBOPT_0xE
	CALL __ADDF12
	CALL SUBOPT_0xD
	__SUBWRN 16,17,1
_0x200000D:
	CALL SUBOPT_0xC
	CALL SUBOPT_0x7
	CALL __SUBF12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0xC
	CALL SUBOPT_0x7
	CALL __ADDF12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __DIVF21
	CALL SUBOPT_0xD
	CALL SUBOPT_0xE
	CALL SUBOPT_0xF
	__GETD2N 0x3F654226
	CALL SUBOPT_0x10
	__GETD1N 0x4054114E
	CALL SUBOPT_0x9
	CALL SUBOPT_0xB
	CALL __MULF12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x11
	__GETD2N 0x3FD4114D
	CALL __SUBF12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __DIVF21
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	MOVW R30,R16
	CALL SUBOPT_0x6
	__GETD2N 0x3F317218
	CALL __MULF12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ADDF12
_0x2080003:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,10
	RET
_exp:
	CALL __PUTPARD2
	SBIW R28,8
	ST   -Y,R17
	ST   -Y,R16
	CALL SUBOPT_0x12
	__GETD1N 0xC2AEAC50
	CALL __CMPF12
	BRSH _0x200000F
	CALL SUBOPT_0x2
	RJMP _0x2080002
_0x200000F:
	__GETD1S 10
	CALL __CPD10
	BRNE _0x2000010
	CALL SUBOPT_0x1
	RJMP _0x2080002
_0x2000010:
	CALL SUBOPT_0x12
	__GETD1N 0x42B17218
	CALL __CMPF12
	BREQ PC+2
	BRCC PC+3
	JMP  _0x2000011
	__GETD1N 0x7F7FFFFF
	RJMP _0x2080002
_0x2000011:
	CALL SUBOPT_0x12
	__GETD1N 0x3FB8AA3B
	CALL __MULF12
	__PUTD1S 10
	CALL SUBOPT_0x12
	RCALL _floor
	CALL __CFD1
	MOVW R16,R30
	MOVW R30,R16
	CALL SUBOPT_0x12
	CALL SUBOPT_0x6
	CALL SUBOPT_0x9
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x3F000000
	CALL SUBOPT_0x9
	CALL SUBOPT_0xD
	CALL SUBOPT_0xE
	CALL SUBOPT_0xF
	__GETD2N 0x3D6C4C6D
	CALL __MULF12
	__GETD2N 0x40E6E3A6
	CALL __ADDF12
	CALL SUBOPT_0xB
	CALL __MULF12
	CALL SUBOPT_0xD
	CALL SUBOPT_0x11
	__GETD2N 0x41A68D28
	CALL __ADDF12
	__PUTD1S 2
	CALL SUBOPT_0xC
	__GETD2S 2
	CALL __ADDF12
	__GETD2N 0x3FB504F3
	CALL __MULF12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0xB
	CALL SUBOPT_0x11
	CALL __SUBF12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __DIVF21
	CALL __PUTPARD1
	MOVW R26,R16
	CALL _ldexp
_0x2080002:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,14
	RET
_pow:
	CALL __PUTPARD2
	SBIW R28,4
	CALL SUBOPT_0x3
	CALL __CPD10
	BRNE _0x2000012
	CALL SUBOPT_0x2
	RJMP _0x2080001
_0x2000012:
	__GETD2S 8
	CALL __CPD02
	BRGE _0x2000013
	CALL SUBOPT_0x13
	CALL __CPD10
	BRNE _0x2000014
	CALL SUBOPT_0x1
	RJMP _0x2080001
_0x2000014:
	__GETD2S 8
	CALL SUBOPT_0x14
	RCALL _exp
	RJMP _0x2080001
_0x2000013:
	CALL SUBOPT_0x13
	MOVW R26,R28
	CALL __CFD1
	CALL __PUTDP1
	CALL SUBOPT_0xA
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	CALL SUBOPT_0x13
	CALL __CPD12
	BREQ _0x2000015
	CALL SUBOPT_0x2
	RJMP _0x2080001
_0x2000015:
	CALL SUBOPT_0x3
	CALL __ANEGF1
	MOVW R26,R30
	MOVW R24,R22
	CALL SUBOPT_0x14
	RCALL _exp
	__PUTD1S 8
	LD   R30,Y
	ANDI R30,LOW(0x1)
	BRNE _0x2000016
	CALL SUBOPT_0x3
	RJMP _0x2080001
_0x2000016:
	CALL SUBOPT_0x3
	CALL __ANEGF1
_0x2080001:
	ADIW R28,12
	RET

	.CSEG

	.DSEG

	.CSEG

	.CSEG

	.CSEG

	.DSEG
_line_data:
	.BYTE 0x8
__seed_G101:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x0:
	MOV  R30,R17
	LDI  R31,0
	MOVW R26,R28
	ADIW R26,20
	CALL __LSLW2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1:
	__GETD1N 0x3F800000
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2:
	__GETD1N 0x0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x3:
	__GETD1S 8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4:
	__GETD2S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x5:
	CALL __GETD1S0
	CALL __CFD1U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x6:
	CALL __CWD1
	CALL __CDF1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x7:
	__GETD2N 0x3F800000
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x8:
	TST  R30
	LDI  R30,1
	BRBC 0x1,PC+2
	LDI  R30,0
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x9:
	CALL __SWAPD12
	CALL __SUBF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xA:
	CALL __GETD1S0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0xB:
	__GETD2S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0xC:
	__GETD1S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xD:
	__PUTD1S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xE:
	RCALL SUBOPT_0xC
	RJMP SUBOPT_0xB

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xF:
	CALL __MULF12
	__PUTD1S 2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x10:
	CALL __MULF12
	MOVW R26,R30
	MOVW R24,R22
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x11:
	__GETD1S 2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x12:
	__GETD2S 10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x13:
	__GETD1S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x14:
	CALL _log
	RCALL SUBOPT_0x4
	RJMP SUBOPT_0x10


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x1388
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

_frexp:
	LD   R30,Y+
	LD   R31,Y+
	LD   R22,Y+
	LD   R23,Y+
	BST  R23,7
	LSL  R22
	ROL  R23
	CLR  R24
	SUBI R23,0x7E
	SBC  R24,R24
	ST   X+,R23
	ST   X,R24
	LDI  R23,0x7E
	LSR  R23
	ROR  R22
	BRTS __ANEGF1
	RET

_ldexp:
	LD   R30,Y+
	LD   R31,Y+
	LD   R22,Y+
	LD   R23,Y+
	BST  R23,7
	LSL  R22
	ROL  R23
	ADD  R23,R26
	LSR  R23
	ROR  R22
	BRTS __ANEGF1
	RET

__ANEGF1:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __ANEGF10
	SUBI R23,0x80
__ANEGF10:
	RET

__ROUND_REPACK:
	TST  R21
	BRPL __REPACK
	CPI  R21,0x80
	BRNE __ROUND_REPACK0
	SBRS R30,0
	RJMP __REPACK
__ROUND_REPACK0:
	ADIW R30,1
	ADC  R22,R25
	ADC  R23,R25
	BRVS __REPACK1

__REPACK:
	LDI  R21,0x80
	EOR  R21,R23
	BRNE __REPACK0
	PUSH R21
	RJMP __ZERORES
__REPACK0:
	CPI  R21,0xFF
	BREQ __REPACK1
	LSL  R22
	LSL  R0
	ROR  R21
	ROR  R22
	MOV  R23,R21
	RET
__REPACK1:
	PUSH R21
	TST  R0
	BRMI __REPACK2
	RJMP __MAXRES
__REPACK2:
	RJMP __MINRES

__UNPACK:
	LDI  R21,0x80
	MOV  R1,R25
	AND  R1,R21
	LSL  R24
	ROL  R25
	EOR  R25,R21
	LSL  R21
	ROR  R24

__UNPACK1:
	LDI  R21,0x80
	MOV  R0,R23
	AND  R0,R21
	LSL  R22
	ROL  R23
	EOR  R23,R21
	LSL  R21
	ROR  R22
	RET

__CFD1U:
	SET
	RJMP __CFD1U0
__CFD1:
	CLT
__CFD1U0:
	PUSH R21
	RCALL __UNPACK1
	CPI  R23,0x80
	BRLO __CFD10
	CPI  R23,0xFF
	BRCC __CFD10
	RJMP __ZERORES
__CFD10:
	LDI  R21,22
	SUB  R21,R23
	BRPL __CFD11
	NEG  R21
	CPI  R21,8
	BRTC __CFD19
	CPI  R21,9
__CFD19:
	BRLO __CFD17
	SER  R30
	SER  R31
	SER  R22
	LDI  R23,0x7F
	BLD  R23,7
	RJMP __CFD15
__CFD17:
	CLR  R23
	TST  R21
	BREQ __CFD15
__CFD18:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R21
	BRNE __CFD18
	RJMP __CFD15
__CFD11:
	CLR  R23
__CFD12:
	CPI  R21,8
	BRLO __CFD13
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R23
	SUBI R21,8
	RJMP __CFD12
__CFD13:
	TST  R21
	BREQ __CFD15
__CFD14:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R21
	BRNE __CFD14
__CFD15:
	TST  R0
	BRPL __CFD16
	RCALL __ANEGD1
__CFD16:
	POP  R21
	RET

__CDF1U:
	SET
	RJMP __CDF1U0
__CDF1:
	CLT
__CDF1U0:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __CDF10
	CLR  R0
	BRTS __CDF11
	TST  R23
	BRPL __CDF11
	COM  R0
	RCALL __ANEGD1
__CDF11:
	MOV  R1,R23
	LDI  R23,30
	TST  R1
__CDF12:
	BRMI __CDF13
	DEC  R23
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R1
	RJMP __CDF12
__CDF13:
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R1
	PUSH R21
	RCALL __REPACK
	POP  R21
__CDF10:
	RET

__SWAPACC:
	PUSH R20
	MOVW R20,R30
	MOVW R30,R26
	MOVW R26,R20
	MOVW R20,R22
	MOVW R22,R24
	MOVW R24,R20
	MOV  R20,R0
	MOV  R0,R1
	MOV  R1,R20
	POP  R20
	RET

__UADD12:
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	RET

__NEGMAN1:
	COM  R30
	COM  R31
	COM  R22
	SUBI R30,-1
	SBCI R31,-1
	SBCI R22,-1
	RET

__SUBF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129
	LDI  R21,0x80
	EOR  R1,R21

	RJMP __ADDF120

__ADDF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129

__ADDF120:
	CPI  R23,0x80
	BREQ __ADDF128
__ADDF121:
	MOV  R21,R23
	SUB  R21,R25
	BRVS __ADDF1211
	BRPL __ADDF122
	RCALL __SWAPACC
	RJMP __ADDF121
__ADDF122:
	CPI  R21,24
	BRLO __ADDF123
	CLR  R26
	CLR  R27
	CLR  R24
__ADDF123:
	CPI  R21,8
	BRLO __ADDF124
	MOV  R26,R27
	MOV  R27,R24
	CLR  R24
	SUBI R21,8
	RJMP __ADDF123
__ADDF124:
	TST  R21
	BREQ __ADDF126
__ADDF125:
	LSR  R24
	ROR  R27
	ROR  R26
	DEC  R21
	BRNE __ADDF125
__ADDF126:
	MOV  R21,R0
	EOR  R21,R1
	BRMI __ADDF127
	RCALL __UADD12
	BRCC __ADDF129
	ROR  R22
	ROR  R31
	ROR  R30
	INC  R23
	BRVC __ADDF129
	RJMP __MAXRES
__ADDF128:
	RCALL __SWAPACC
__ADDF129:
	RCALL __REPACK
	POP  R21
	RET
__ADDF1211:
	BRCC __ADDF128
	RJMP __ADDF129
__ADDF127:
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	BREQ __ZERORES
	BRCC __ADDF1210
	COM  R0
	RCALL __NEGMAN1
__ADDF1210:
	TST  R22
	BRMI __ADDF129
	LSL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVC __ADDF1210

__ZERORES:
	CLR  R30
	CLR  R31
	CLR  R22
	CLR  R23
	POP  R21
	RET

__MINRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	SER  R23
	POP  R21
	RET

__MAXRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	LDI  R23,0x7F
	POP  R21
	RET

__MULF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BREQ __ZERORES
	CPI  R25,0x80
	BREQ __ZERORES
	EOR  R0,R1
	SEC
	ADC  R23,R25
	BRVC __MULF124
	BRLT __ZERORES
__MULF125:
	TST  R0
	BRMI __MINRES
	RJMP __MAXRES
__MULF124:
	PUSH R0
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R17
	CLR  R18
	CLR  R25
	MUL  R22,R24
	MOVW R20,R0
	MUL  R24,R31
	MOV  R19,R0
	ADD  R20,R1
	ADC  R21,R25
	MUL  R22,R27
	ADD  R19,R0
	ADC  R20,R1
	ADC  R21,R25
	MUL  R24,R30
	RCALL __MULF126
	MUL  R27,R31
	RCALL __MULF126
	MUL  R22,R26
	RCALL __MULF126
	MUL  R27,R30
	RCALL __MULF127
	MUL  R26,R31
	RCALL __MULF127
	MUL  R26,R30
	ADD  R17,R1
	ADC  R18,R25
	ADC  R19,R25
	ADC  R20,R25
	ADC  R21,R25
	MOV  R30,R19
	MOV  R31,R20
	MOV  R22,R21
	MOV  R21,R18
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	POP  R0
	TST  R22
	BRMI __MULF122
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	RJMP __MULF123
__MULF122:
	INC  R23
	BRVS __MULF125
__MULF123:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__MULF127:
	ADD  R17,R0
	ADC  R18,R1
	ADC  R19,R25
	RJMP __MULF128
__MULF126:
	ADD  R18,R0
	ADC  R19,R1
__MULF128:
	ADC  R20,R25
	ADC  R21,R25
	RET

__DIVF21:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BRNE __DIVF210
	TST  R1
__DIVF211:
	BRPL __DIVF219
	RJMP __MINRES
__DIVF219:
	RJMP __MAXRES
__DIVF210:
	CPI  R25,0x80
	BRNE __DIVF218
__DIVF217:
	RJMP __ZERORES
__DIVF218:
	EOR  R0,R1
	SEC
	SBC  R25,R23
	BRVC __DIVF216
	BRLT __DIVF217
	TST  R0
	RJMP __DIVF211
__DIVF216:
	MOV  R23,R25
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R1
	CLR  R17
	CLR  R18
	CLR  R19
	CLR  R20
	CLR  R21
	LDI  R25,32
__DIVF212:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R20,R17
	BRLO __DIVF213
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R20,R17
	SEC
	RJMP __DIVF214
__DIVF213:
	CLC
__DIVF214:
	ROL  R21
	ROL  R18
	ROL  R19
	ROL  R1
	ROL  R26
	ROL  R27
	ROL  R24
	ROL  R20
	DEC  R25
	BRNE __DIVF212
	MOVW R30,R18
	MOV  R22,R1
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	TST  R22
	BRMI __DIVF215
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVS __DIVF217
__DIVF215:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__CMPF12:
	TST  R25
	BRMI __CMPF120
	TST  R23
	BRMI __CMPF121
	CP   R25,R23
	BRLO __CMPF122
	BRNE __CMPF121
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	BRLO __CMPF122
	BREQ __CMPF123
__CMPF121:
	CLZ
	CLC
	RET
__CMPF122:
	CLZ
	SEC
	RET
__CMPF123:
	SEZ
	CLC
	RET
__CMPF120:
	TST  R23
	BRPL __CMPF122
	CP   R25,R23
	BRLO __CMPF121
	BRNE __CMPF122
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	BRLO __CMPF122
	BREQ __CMPF123
	RJMP __CMPF121

__ANEGD1:
	COM  R31
	COM  R22
	COM  R23
	NEG  R30
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__LSLW2:
	LSL  R30
	ROL  R31
	LSL  R30
	ROL  R31
	RET

__CBD1:
	MOV  R31,R30
	ADD  R31,R31
	SBC  R31,R31
	MOV  R22,R31
	MOV  R23,R31
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__GETD1P:
	LD   R30,X+
	LD   R31,X+
	LD   R22,X+
	LD   R23,X
	SBIW R26,3
	RET

__PUTDP1:
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	RET

__GETD1S0:
	LD   R30,Y
	LDD  R31,Y+1
	LDD  R22,Y+2
	LDD  R23,Y+3
	RET

__GETD2S0:
	LD   R26,Y
	LDD  R27,Y+1
	LDD  R24,Y+2
	LDD  R25,Y+3
	RET

__PUTD1S0:
	ST   Y,R30
	STD  Y+1,R31
	STD  Y+2,R22
	STD  Y+3,R23
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__PUTPARD2:
	ST   -Y,R25
	ST   -Y,R24
	ST   -Y,R27
	ST   -Y,R26
	RET

__SWAPD12:
	MOV  R1,R24
	MOV  R24,R22
	MOV  R22,R1
	MOV  R1,R25
	MOV  R25,R23
	MOV  R23,R1

__SWAPW12:
	MOV  R1,R27
	MOV  R27,R31
	MOV  R31,R1

__SWAPB12:
	MOV  R1,R26
	MOV  R26,R30
	MOV  R30,R1
	RET

__CPD10:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	RET

__CPD02:
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
	CPC  R0,R24
	CPC  R0,R25
	RET

__CPD12:
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	CPC  R23,R25
	RET

__INITLOCB:
__INITLOCW:
	ADD  R26,R28
	ADC  R27,R29
__INITLOC0:
	LPM  R0,Z+
	ST   X+,R0
	DEC  R24
	BRNE __INITLOC0
	RET

;END OF CODE MARKER
__END_OF_CODE:

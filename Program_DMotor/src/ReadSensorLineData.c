/****
	*	@name		DMotor_linefollower
	*	@file 		ReadSensorLineData.c
	*
	*	@author 	Uladzislau 'vladubase' Dubatouka
	*				<vladubase@gmail.com>
	*
*****/


/************************************** Includes **************************************/

#include "../inc/ReadSensorLineData.h"


/************************************** Function **************************************/

void ReadSensorLineData (void) {
	#ifdef READ_SENSOR_1
		line_data[0] = READ_SENSOR_1;
	#endif /* READ_SENSOR_1 */
	#ifdef READ_SENSOR_2
		line_data[1] = READ_SENSOR_2;
	#endif /* READ_SENSOR_2 */
	#ifdef READ_SENSOR_3
		line_data[2] = READ_SENSOR_3;
	#endif /* READ_SENSOR_3 */
	#ifdef READ_SENSOR_4
		line_data[3] = READ_SENSOR_4;
	#endif /* READ_SENSOR_4 */
	#ifdef READ_SENSOR_5
		line_data[4] = READ_SENSOR_5;
	#endif /* READ_SENSOR_5 */
	#ifdef READ_SENSOR_6
		line_data[5] = READ_SENSOR_6;
	#endif /* READ_SENSOR_6 */
	#ifdef READ_SENSOR_7
		line_data[6] = READ_SENSOR_7;
	#endif /* READ_SENSOR_7 */
	#ifdef READ_SENSOR_8
		line_data[7] = READ_SENSOR_8;
	#endif /* READ_SENSOR_8 */
	#ifdef READ_SENSOR_9
		line_data[8] = READ_SENSOR_9;
	#endif /* READ_SENSOR_9 */
	#ifdef READ_SENSOR_10
		line_data[9] = READ_SENSOR_10;
	#endif /* READ_SENSOR_10 */
	#ifdef READ_SENSOR_11
		line_data[10] = READ_SENSOR_11;
	#endif /* READ_SENSOR_11 */
	#ifdef READ_SENSOR_12
		line_data[11] = READ_SENSOR_12;
	#endif /* READ_SENSOR_12 */
	#ifdef READ_SENSOR_13
		line_data[12] = READ_SENSOR_13;
	#endif /* READ_SENSOR_13 */
	#ifdef READ_SENSOR_14
		line_data[13] = READ_SENSOR_14;
	#endif /* READ_SENSOR_14 */
	#ifdef READ_SENSOR_15
		line_data[14] = READ_SENSOR_15;
	#endif /* READ_SENSOR_15 */
	#ifdef READ_SENSOR_16
		line_data[15] = READ_SENSOR_16;
	#endif /* READ_SENSOR_16 */
}

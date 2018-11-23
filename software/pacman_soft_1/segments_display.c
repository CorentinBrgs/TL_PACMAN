/*
 * segments_display.c
 *
 *  Created on: 23 nov. 2018
 *      Author: berges_cor
 */

#include "segments_display.h"

void display_number(alt_u16 number) {
 	alt_u32 mask = 0;
	if (number/100 != 0) {
		mask |= (char_array_2[number/100] << 14) | 
				(char_array_1[(number%100)/10] << 7) | 
				(char_array_1[number%10]);
	} else if (number/10 != 0) {
		mask |= (char_array_1[(number%100)/10] << 7) | 
				(char_array_1[number%10]);
	} else {
		mask |= (char_array_1[number%10]);
	}
	IOWR_32DIRECT(SEGMENTS_DISPLAY_BASE, 0, ~mask);
}

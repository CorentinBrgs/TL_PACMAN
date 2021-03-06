/*
 * segments_display.h
 *
 *  Created on: 23 nov. 2018
 *      Author: berges_cor
 */

#include "io.h"
#include "system.h"
#include "alt_types.h"

#ifndef SEGMENTS_DISPLAY_H_
#define SEGMENTS_DISPLAY_H_

static alt_u8 char_array_1[] = {
	0x3F, //0
	0x06, //1
	0x5B, //2
	0x4F, //3
	0x66, //4
	0x6D, //5
	0x7D, //6
	0x07, //7
	0x7F, //8
	0x6F  //9
};
static alt_u8 char_array_2[] = {
	0x7E, //0
	0x30, //1
	0x6D, //2
	0x79, //3
	0x33, //4
	0x5B, //5
	0x5F, //6
	0x70, //7
	0x7F, //8
	0x7B  //9
};

void display_number(alt_u16 number);

#endif /* SEGMENTS_DISPLAY_H_ */

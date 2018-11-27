/*
 * background.h
 *
 *  Created on: 21 nov. 2018
 *      Author: berges_cor
 */


#include <stdio.h>

#include "io.h"
#include "system.h"
#include "alt_types.h"

#include "general.h"

#ifndef BACKGROUND_H_
#define BACKGROUND_H_


static alt_u32 background[15] = {
	0b11111111111111111111111111111111,
	0b10000000000000000000000111111111,
	0b10101111101111111011110111111111,
	0b10000000000000000000010111111111,
	0b10101110101011101011110111111111,
	0b10101000001000101010000111111111,
	0b10101010101010101010111111111111,
	0b10101010101000101010111111111111,
	0b10101010101010101010000111111111,
	0b10101010101010101011110111111111,
	0b10101010100010101000010111111111,
	0b10101010111010101111010111111111,
	0b10000010000000000000000111111111,
	0b11111111111111111111111111111111,
	0b11111111111111111111111111111111
};

static alt_u32 foodLayer[15];

void set_background_in_memory(alt_u32 background[15]);
void init_foodLayer(alt_u32 background[15], alt_32 foodLayer[15], alt_u8 sizeY);
void set_foodLayer_in_memory(alt_u32 foodLayer[15]);
void refresh_food_layer(position* charPosition, alt_u32 foodLayer[15], alt_u16* score);
alt_u8 food_layer_empty(alt_u32 foodLayer[15]);

#endif /* BACKGROUND_H_ */

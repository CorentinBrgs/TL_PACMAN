/*
 * general.c
 *
 *  Created on: 22 nov. 2018
 *      Author: moreira_ben
 */

#include "general.h"


alt_u8 get_block_with_coordinates(alt_u32 positionX, alt_u32 positionY, alt_u32 layer[]){
	alt_u16 blockX = positionX / 60;
	alt_u16 blockY = positionY / 60;
	return ((layer[blockY] & 1<<(8+blockX))>>(8+blockX));
}

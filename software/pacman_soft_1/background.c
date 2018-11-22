/*
 * background.h
 *
 *  Created on: 21 nov. 2018
 *      Author: berges_cor
 */


#include "background.h"

void set_background_in_memory(alt_u32 background[15])
{
	for(int i=0; i<16; i++){
		IOWR_32DIRECT(BACKGROUND_DATA_BASE, 0, background[i]);
		IOWR_8DIRECT(BACKGROUND_WR_BASE, 0, 0b00000 + i);
		IOWR_8DIRECT(BACKGROUND_WR_BASE, 0, 0b10000 + i);
		IOWR_8DIRECT(BACKGROUND_WR_BASE, 0, 0b00000 + i);
	}
}

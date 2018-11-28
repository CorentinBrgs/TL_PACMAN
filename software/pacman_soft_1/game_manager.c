/*
 * game_manager.c
 *
 *  Created on: 27 nov. 2018
 *      Author: moreira_ben
 */

#include "game_manager.h"

void init_game(
	position charPosition[4],
	alt_u32 positionX,
	alt_u32 positionY,
	orientation orientation,
	alt_u32 charBackground[15],
	alt_u32 ghostBackground[15],
	alt_u32 foodLayer[15],
	alt_u16 *score
	)
{
	*score = 0;

	init_position(&(charPosition[0]), 0, positionX, positionY, ACTIVE, orientation, charBackground);
	IOWR_32DIRECT(POSITION_BASE, 0, charPosition[0].bytePacket);

	init_position(&(charPosition[1]), 1, 12*60, 6*60, ACTIVE, NORTH, ghostBackground);
	IOWR_32DIRECT(POSITION_BASE, 0, charPosition[1].bytePacket);

	init_position(&(charPosition[2]), 2, 12*60, 5*60, ACTIVE, SOUTH, ghostBackground);
	IOWR_32DIRECT(POSITION_BASE, 0, charPosition[2].bytePacket);

	init_position(&(charPosition[3]), 3, 11*60, 6*60, ACTIVE, EAST, ghostBackground);
	IOWR_32DIRECT(POSITION_BASE, 0, charPosition[3].bytePacket);

	init_position(&(charPosition[4]), 4, 11*60, 5*60, ACTIVE, EAST, ghostBackground);
	IOWR_32DIRECT(POSITION_BASE, 0, charPosition[3].bytePacket);


	set_background_in_memory(ghostBackground);
	init_foodLayer(charBackground, foodLayer, 15);
	set_foodLayer_in_memory(foodLayer);
	compute_collision(charPosition);
}

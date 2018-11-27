/*
 * game_manager.c
 *
 *  Created on: 27 nov. 2018
 *      Author: moreira_ben
 */

#include "game_manager.h"

void init_game(alt_u8 ghostNb)
{
	set_background_in_memory(background);
	init_foodLayer(background, foodLayer, 15);
	set_foodLayer_in_memory(foodLayer);

	position pacmanPosition;
	//position ghostPosition[5];
	init_position(&pacmanPosition, 0, 60, 60, ACTIVE, SOUTH);
	//init_position(ghostPosition[5], ghostNb, 7*60, 12*60, ACTIVE, NORTH);
	compute_collision(&pacmanPosition);
}
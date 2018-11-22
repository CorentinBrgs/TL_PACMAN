/*
 * refresh_position.c
 *
 *  Created on: 21 nov. 2018
 *      Author: berges_cor
 */

#include "refresh_position.h"

#define MOVEMENT_STEP 5

void compute_byte_packet(position* charPosition)
//computes the binary data sent to the logic given the other arguments (position, orientation,...)
//contained in the structure position
{
	charPosition->bytePacket = (charPosition->charId << 29) + (charPosition->positionX << 17 ) + (charPosition->positionY << 5) + (charPosition->state << 2) + (charPosition->orientation );
}

void initCollision(position* charPosition){
	charPosition->collision.north = 0;
	charPosition->collision.east = 0;
	charPosition->collision.south = 0;
	charPosition->collision.west = 0;
}

void init_position(position* charPosition, alt_u8 charId, alt_u32 positionX, alt_u32 positionY, alt_u8 state, orientation orientation)
//initialize the charPosition with the given arguments
{
	charPosition->charId = charId ;
	charPosition->positionX = positionX ;
	charPosition->positionY = positionY ;
	charPosition->state = state ;
	charPosition->orientation = orientation ;
	initCollision(charPosition);
	compute_byte_packet(charPosition);
}

void compute_collision(position* charPosition){
	charPosition->collision.north = 1 -
		(int)
		(
			(get_block_with_coordinates(charPosition->positionX, 		charPosition->positionY - 1, background) 	== 0)
			&& 
			(get_block_with_coordinates(charPosition->positionX + 59, 	charPosition->positionY - 1, background) 	== 0)
		);

	charPosition->collision.east = 1 -
		(int)
		(
			(get_block_with_coordinates(charPosition->positionX + 60, 	charPosition->positionY, background) 		== 0)
			&& 
			(get_block_with_coordinates(charPosition->positionX + 60, 	charPosition->positionY + 59, background) 	== 0)
		);

	charPosition->collision.south = 1 -
		(int)
		(
			(get_block_with_coordinates(charPosition->positionX, 		charPosition->positionY + 60, background) 	== 0)
			&& 
			(get_block_with_coordinates(charPosition->positionX + 59, 	charPosition->positionY + 60, background) 	== 0)
		);

	charPosition->collision.west = 1 -
		(int)
		(
			(get_block_with_coordinates(charPosition->positionX - 1, 	charPosition->positionY, background) 		== 0)
			&& 
			(get_block_with_coordinates(charPosition->positionX - 1, 	charPosition->positionY + 59, background) 	== 0)
		);
}

void refresh_position(position* charPosition, alt_u8 autoMode)
/*this function computes the new position of the pacman given :
 * - the orientation
 * - the collisions around the character
 */
{
	compute_collision(charPosition);
	alt_u16 step = MOVEMENT_STEP;
	
	srand((unsigned int)time(NULL) + charPosition->positionX);
	int randomOrientation = rand() % 5;

	switch(charPosition->directionControl)
	{
		case UP:
			if(charPosition->collision.north == 0){
				charPosition->orientation = NORTH;
				charPosition->positionY = charPosition->positionY - step;
				charPosition->directionControl = NONE;
			} else {
				refresh_position_keepGoing(charPosition, step, autoMode);
			}
		break;
		case RIGHT:
			if(charPosition->collision.east == 0){
				charPosition->orientation = EAST;
				charPosition->positionX = charPosition->positionX + step;
				charPosition->directionControl = NONE;
			} else {
				refresh_position_keepGoing(charPosition, step, autoMode);
			}
		break;
		case DOWN:
			if(charPosition->collision.south == 0){
				charPosition->orientation = SOUTH;
				charPosition->positionY = charPosition->positionY + step;
				charPosition->directionControl = NONE;
			} else {
				refresh_position_keepGoing(charPosition, step, autoMode);
			}
		break;
		case LEFT:
			if(charPosition->collision.west == 0){
				charPosition->orientation = WEST;
				charPosition->positionX = charPosition->positionX - step;
				charPosition->directionControl = NONE;
			} else {
				refresh_position_keepGoing(charPosition, step, autoMode);
			}
		break;
		default :
			refresh_position_keepGoing(charPosition, step, autoMode);
		break;
	}
	compute_byte_packet(charPosition);
}

void refresh_position_keepGoing(position* charPosition, alt_u16 step, alt_u8 autoMode){
	switch(charPosition->orientation)
	{
		case NORTH :
			if (charPosition->collision.north == 0){
				charPosition->positionY = charPosition->positionY - step;	
			} else if (autoMode == 1) {
				randomDirection(charPosition, step);
			} 
		break;
		case EAST :
			if (charPosition->collision.east == 0){
				charPosition->positionX = charPosition->positionX + step;
			} else if (autoMode == 1) {
				randomDirection(charPosition, step);
			} 
		break;
		case SOUTH :
			if (charPosition->collision.south == 0){
				charPosition->positionY = charPosition->positionY + step;
			} else if (autoMode == 1) {
				randomDirection(charPosition, step);
			} 
		break;
		case WEST :
			if (charPosition->collision.west == 0){
				charPosition->positionX = charPosition->positionX - step;
			} else if (autoMode == 1) {
				randomDirection(charPosition, step);
			} 
		break;
	}
}

//this function should be removed once the button controls are working
void randomDirection(position* charPosition, alt_u16 step){
	if (charPosition->collision.north == 0){
		charPosition->orientation = NORTH;
		charPosition->positionY = charPosition->positionY - step;				
	}	
	else if (charPosition->collision.east == 0){	
		charPosition->orientation = EAST;
		charPosition->positionX = charPosition->positionX + step;		
	}	
	else if (charPosition->collision.south == 0){
		charPosition->orientation = SOUTH;
		charPosition->positionY = charPosition->positionY + step;				
	}	
	else if (charPosition->collision.west == 0){
		charPosition->orientation = WEST;
		charPosition->positionX = charPosition->positionX - step;		
	}
}






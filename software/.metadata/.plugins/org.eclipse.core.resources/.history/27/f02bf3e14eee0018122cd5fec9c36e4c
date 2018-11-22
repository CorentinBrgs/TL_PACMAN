/*
 * refresh_position.h
 *
 *  Created on: 21 nov. 2018
 *      Author: berges_cor
 */
#include <stdio.h>
#include <time.h>
#include <stdlib.h>

#include "io.h"
#include "system.h"
#include "alt_types.h"

#include "background.h"

#ifndef REFRESH_POSITION_H_
#define REFRESH_POSITION_H_

typedef enum {
	WEST,
	NORTH,
	EAST,
	SOUTH
} orientation;

typedef enum {
	INACTIVE,
	ACTIVE
} char_state;

typedef struct {
	alt_u8 north;
	alt_u8 east;
	alt_u8 south;
	alt_u8 west;
} collision;

typedef enum {
	NONE,
	UP,
	RIGHT,
	DOWN,
	LEFT
} direction;

typedef struct {
	alt_u8 charId;
	alt_u32 positionX;
	alt_u32 positionY;
	alt_u8 state;
	orientation orientation;
	alt_u32 bytePacket;
	collision collision;
	direction directionControl;
} position;

void compute_byte_packet(position* charPosition);
void initCollision(position* charPosition);
void init_position(position* charPosition, alt_u8 charId, alt_u32 positionX, alt_u32 positionY, alt_u8 state, orientation orientation);
void compute_collision(position* charPosition);
alt_u8 get_block_with_coordinates(alt_u32 positionX, alt_u32 positionY);
void refresh_position(position* charPosition);
void refresh_position_keepGoing(position* charPosition, alt_u8 step);
//this function should be removed once the button controls are working
void randomDirection(position* charPosition, alt_u8 step);
static void update_direction(void* context);

#endif /* REFRESH_POSITION_H_ */

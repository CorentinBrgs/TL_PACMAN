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
#include "general.h"

#ifndef REFRESH_POSITION_H_
#define REFRESH_POSITION_H_

void compute_byte_packet(position* charPosition);
void initCollision(position* charPosition);
void init_position(position* charPosition, alt_u8 charId, alt_u32 positionX, alt_u32 positionY, alt_u8 state, orientation orientation);
void compute_collision(position* charPosition);
void refresh_position(position* charPosition, alt_u8 autoMode);
void refresh_position_keepGoing(position* charPosition, alt_u16 step, alt_u8 autoMode);
//this function should be removed once the button controls are working
void randomDirection(position* charPosition, alt_u16 step);

#endif /* REFRESH_POSITION_H_ */

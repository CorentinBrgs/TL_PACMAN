#include <stdio.h>

#include "io.h"
#include "system.h"
#include "alt_types.h"
#include "sys\alt_irq.h"
#include "priv\alt_legacy_irq.h"

alt_u32 refreshIO;
alt_u32 counter = 0;
alt_8	counter_dir = -1;
alt_u32 temp_counter = 0;

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
	alt_u8 charId;
	alt_u32 positionX;
	alt_u32 positionY;
	alt_u8 state;
	orientation orientation;
	alt_u32 bytePacket;
} position;

void compute_byte_packet(position* charPosition)
{
	charPosition->bytePacket = (charPosition->charId << 29) + (charPosition->positionX << 17 ) + (charPosition->positionY << 5) + (charPosition->state << 2) + (charPosition->orientation );
}

void init_position(position* charPosition, alt_u8 charId, alt_u32 positionX, alt_u32 positionY, alt_u8 state, orientation orientation)
{
	charPosition->charId = charId ;
	charPosition->positionX = positionX ;
	charPosition->positionY = positionY ;
	charPosition->state = state ;
	charPosition->orientation = orientation ;
	compute_byte_packet(charPosition);
}

void refresh_position(position* charPosition)
{
	alt_u8 step = 1<<2;
	switch(charPosition->orientation)
	{
		case NORTH :
			charPosition->positionY = (charPosition->positionY > 0) ? charPosition->positionY - step : charPosition->positionY ;
		break;
		case EAST :
			charPosition->positionX = (charPosition->positionX < 1440) ? charPosition->positionX + step : charPosition->positionX ;
		break;
		case SOUTH :
			charPosition->positionY = (charPosition->positionY < 900) ? charPosition->positionY + step : charPosition->positionY ;
		break;
		case WEST :
			charPosition->positionX = (charPosition->positionX > 0) ? charPosition->positionX - step : charPosition->positionX ;
		break;
	}
	compute_byte_packet(charPosition);
}

static void refresh_position_interrupt_handler(void* context)
{


	position* p_pacmanPosition = (position*) context;
	refresh_position(p_pacmanPosition);
	IOWR_32DIRECT(POSITION_BASE, 0, p_pacmanPosition->bytePacket);
	IOWR(REFRESH_BASE,3,0xf);

	if(counter > 600){
		counter_dir = -1;
		p_pacmanPosition->orientation = NORTH;
	}
	if(counter < 60){
		counter_dir = 1;
		p_pacmanPosition->orientation = SOUTH;
	}
	counter = counter + (1<<2)*counter_dir;

	printf("%lu %u\n", counter, counter_dir);

}

int main()
{
	position pacmanPosition;
	init_position(&pacmanPosition, 0, 60, 60, ACTIVE, SOUTH);
	printf("Hello from Nios II!\n");

	//IRQ initialisation
	IOWR(REFRESH_BASE,2,0xf); //enable interrupt
	IOWR(REFRESH_BASE,3,0xf); //clear edge register
	printf("alt_ic_irq_enabled : %lu \n", alt_ic_irq_enabled(REFRESH_IRQ_INTERRUPT_CONTROLLER_ID, REFRESH_IRQ));
	alt_irq_register(REFRESH_IRQ,(void*)&pacmanPosition,refresh_position_interrupt_handler);

	int counter_dir = 1;

	while(1)
	{
		// if (temp_counter != counter)
		// {
		// 	printf("bytePacket : %lu \n", pacmanPosition.bytePacket);
		// 	printf("charId : %u \n", pacmanPosition.charId);
		// 	printf("positionX : %lu \n", pacmanPosition.positionX);
		// 	printf("positionY : %lu \n", pacmanPosition.positionY);
		// 	printf("state : %u \n", pacmanPosition.state);
		// 	printf("orientation : %u \n", pacmanPosition.orientation);
		// 	temp_counter = counter;
		// }
	}
}

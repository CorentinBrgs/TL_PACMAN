#include "background.h"
#include "refresh_position.h"

#include <stdio.h>


#include "io.h"
#include "system.h"
#include "alt_types.h"
#include "sys\alt_irq.h"
#include "priv\alt_legacy_irq.h"


alt_u32 counter = 0;
alt_8	counter_dir = -1;
alt_u32 temp_counter = 0;

static void refresh_position_interrupt_handler(void* context)
/* interrupt handler : this function is called each time a new frame is build (60Hz)
 * it calls *refresh_position()* function and ensures the char doesn't go out of the frame.
*/
{
	position* p_pacmanPosition = (position*) context;
	refresh_position(p_pacmanPosition);
	IOWR_32DIRECT(POSITION_BASE, 0, p_pacmanPosition->bytePacket);
	if(counter > 600){
		counter_dir = -1;
		p_pacmanPosition->orientation = NORTH;
	}
	if(counter < 60){
		counter_dir = 1;
		p_pacmanPosition->orientation = SOUTH;
	}
	counter = counter + (1<<0)*counter_dir;
	IOWR(REFRESH_BASE,3,0xf);
}

int main()
{
	set_background_in_memory(background);

	position pacmanPosition;
	init_position(&pacmanPosition, 0, 60, 60, ACTIVE, SOUTH);
	compute_collision(&pacmanPosition);

	printf("Hello from Nios II!\n");
	printf("get_blocks : %u\n",
		get_block_with_coordinates(50,50)
	);

	//IRQ initialization
	IOWR(REFRESH_BASE,2,0xf); //enable interrupt
	IOWR(REFRESH_BASE,3,0xf); //clear edge register
	printf("alt_ic_irq_enabled : %lu \n", alt_ic_irq_enabled(REFRESH_IRQ_INTERRUPT_CONTROLLER_ID, REFRESH_IRQ));
	alt_irq_register(REFRESH_IRQ,(void*)&pacmanPosition,refresh_position_interrupt_handler);

	printf("%lu\n", background[1]);

	long whileCounter = 0;
	while(1)
	{
		whileCounter++;
		if (whileCounter > 30000){
			printf("N : %u, E : %u, S : %u, W : %u, DControl : %u\n",
				pacmanPosition.collision.north,
				pacmanPosition.collision.south,
				pacmanPosition.collision.east,
				pacmanPosition.collision.west,
				pacmanPosition.directionControl
			);
			whileCounter = 0;
			pacmanPosition.directionControl = ((pacmanPosition.orientation + 2*(rand()%2))%4) + 1 ;
		}
	}
}
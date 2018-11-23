#include "background.h"
#include "refresh_position.h"
#include "segments_display.h"

#include <stdio.h>


#include "io.h"
#include <system.h>
#include "alt_types.h"
#include "sys\alt_irq.h"
#include "priv\alt_legacy_irq.h"

alt_u16 score = 0;

static void refresh_position_interrupt_handler(void* context)
/* interrupt handler : this function is called each time a new frame is build (60Hz)
 * it calls *refresh_position()* function and ensures the char doesn't go out of the frame.
*/
{
	position* p_pacmanPosition = (position*) context;
	refresh_position(p_pacmanPosition, 0);
	refresh_food_layer(p_pacmanPosition, foodLayer, &score);
	IOWR_32DIRECT(POSITION_BASE, 0, p_pacmanPosition->bytePacket);
	IOWR(REFRESH_BASE,3,0xf);
}

static void left_button_interrupt_handler(void* context)
/* interrupt handler : this function is called each time the left button direction is pressed */
{
	position* p_pacmanPosition = (position*) context;
	p_pacmanPosition->directionControl = LEFT;
	IOWR(LEFT_BUTTON_BASE,3,0xf);
}

static void up_button_interrupt_handler(void* context)
/* interrupt handler : this function is called each time the up button direction is pressed */
{
	position* p_pacmanPosition = (position*) context;
	p_pacmanPosition->directionControl = DOWN;
	IOWR(UP_BUTTON_BASE,3,0xf);
}

static void down_button_interrupt_handler(void* context)
/* interrupt handler : this function is called each time the down button direction is pressed */
{
	position* p_pacmanPosition = (position*) context;
	p_pacmanPosition->directionControl = UP;
	IOWR(DOWN_BUTTON_BASE,3,0xf);
}

static void right_button_interrupt_handler(void* context)
/* interrupt handler : this function is called each time the right button direction is pressed */
{
	position* p_pacmanPosition = (position*) context;
	p_pacmanPosition->directionControl = RIGHT;
	IOWR(RIGHT_BUTTON_BASE,3,0xf);
}

int main()
{
	set_background_in_memory(background);
	init_foodLayer(background, foodLayer, 15);
	set_foodLayer_in_memory(foodLayer);

	position pacmanPosition;
	init_position(&pacmanPosition, 0, 60, 60, ACTIVE, SOUTH);
	compute_collision(&pacmanPosition);

	printf("Hello from Nios II!\n");

	//IRQ initialization
	IOWR(REFRESH_BASE,2,0xf); //enable interrupt
	IOWR(REFRESH_BASE,3,0xf); //clear edge register
	alt_irq_register(REFRESH_IRQ,(void*)&pacmanPosition,refresh_position_interrupt_handler);
	printf("Refresh IRQ : ");
	printf("alt_ic_irq_enabled : %lu \n", alt_ic_irq_enabled(REFRESH_IRQ_INTERRUPT_CONTROLLER_ID, REFRESH_IRQ));

	//Left button IRQ initialization
	IOWR(LEFT_BUTTON_BASE,2,0xf); //enable interrupt
	IOWR(LEFT_BUTTON_BASE,3,0xf); //clear edge register
	alt_irq_register(LEFT_BUTTON_IRQ,(void*)&pacmanPosition,left_button_interrupt_handler);
	printf("Left button IRQ : ");
	printf("left_button_irq_enabled : %lu \n", alt_ic_irq_enabled(LEFT_BUTTON_IRQ_INTERRUPT_CONTROLLER_ID, LEFT_BUTTON_IRQ));

	//Up button IRQ initialization
	IOWR(UP_BUTTON_BASE,2,0xf); //enable interrupt
	IOWR(UP_BUTTON_BASE,3,0xf); //clear edge register
	alt_irq_register(UP_BUTTON_IRQ,(void*)&pacmanPosition,up_button_interrupt_handler);
	printf("Up button IRQ : ");
	printf("up_button_irq_enabled : %lu \n", alt_ic_irq_enabled(UP_BUTTON_IRQ_INTERRUPT_CONTROLLER_ID, UP_BUTTON_IRQ));

	//Down button IRQ initialization
	IOWR(DOWN_BUTTON_BASE,2,0xf); //enable interrupt
	IOWR(DOWN_BUTTON_BASE,3,0xf); //clear edge register
	alt_irq_register(DOWN_BUTTON_IRQ,(void*)&pacmanPosition,down_button_interrupt_handler);
	printf("Down button IRQ : ");
	printf("down_button_irq_enabled : %lu \n", alt_ic_irq_enabled(DOWN_BUTTON_IRQ_INTERRUPT_CONTROLLER_ID, DOWN_BUTTON_IRQ));

	//Right button IRQ initialization
	IOWR(RIGHT_BUTTON_BASE,2,0xf); //enable interrupt
	IOWR(RIGHT_BUTTON_BASE,3,0xf); //clear edge register
	alt_irq_register(RIGHT_BUTTON_IRQ,(void*)&pacmanPosition,right_button_interrupt_handler);
	printf("Right button IRQ : ");
	printf("right_button_irq_enabled : %lu \n", alt_ic_irq_enabled(RIGHT_BUTTON_IRQ_INTERRUPT_CONTROLLER_ID, RIGHT_BUTTON_IRQ));

	printf("%lu\n", background[1]);

	long whileCounter = 0;
	while(1)
	{
		display_number(score);
		whileCounter++;
		if (whileCounter > 500000){
			printf("directionControl : %u, orientation : %u , Score : %u\n",
					pacmanPosition.directionControl,
					pacmanPosition.orientation,
					score
			);
			whileCounter = 0;
		}
	}
}

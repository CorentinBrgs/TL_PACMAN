// #include "background.h"
// #include "refresh_position.h"
// #include "segments_display.h"
#include "game_manager.h"

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
	position* charPosition = (position*) context;
	refresh_position(&(charPosition[0]), 0);
	refresh_position(&(charPosition[1]), 1);
	refresh_position(&(charPosition[2]), 1);
	refresh_position(&(charPosition[3]), 1);
	refresh_food_layer(&(charPosition[0]), foodLayer, &score);

	// printf("0.x = %u, 0.y = %u, 1.x = %u, 1.y = %u, 2.x = %u, 2.y = %u, 3.x = %u, 3.y = %u,\n",
	// 	charPosition[0].positionX,
	// 	charPosition[0].positionY,
	// 	charPosition[1].positionX,
	// 	charPosition[1].positionY,
	// 	charPosition[2].positionX,
	// 	charPosition[2].positionY,
	// 	charPosition[3].positionX,
	// 	charPosition[3].positionY
	// );

	IOWR_32DIRECT(POSITION_BASE, 0, charPosition[0].bytePacket|(0b111<<29));
	IOWR_32DIRECT(POSITION_BASE, 0, charPosition[0].bytePacket);
	IOWR_32DIRECT(POSITION_BASE, 0, charPosition[0].bytePacket|(0b111<<29));
	IOWR_32DIRECT(POSITION_BASE, 0, charPosition[1].bytePacket|(0b111<<29));
	IOWR_32DIRECT(POSITION_BASE, 0, charPosition[1].bytePacket);
	IOWR_32DIRECT(POSITION_BASE, 0, charPosition[1].bytePacket|(0b111<<29));
	IOWR_32DIRECT(POSITION_BASE, 0, charPosition[2].bytePacket|(0b111<<29));
	IOWR_32DIRECT(POSITION_BASE, 0, charPosition[2].bytePacket);
	IOWR_32DIRECT(POSITION_BASE, 0, charPosition[2].bytePacket|(0b111<<29));
	IOWR_32DIRECT(POSITION_BASE, 0, charPosition[3].bytePacket|(0b111<<29));
	IOWR_32DIRECT(POSITION_BASE, 0, charPosition[3].bytePacket);
	IOWR_32DIRECT(POSITION_BASE, 0, charPosition[3].bytePacket|(0b111<<29));

	IOWR(REFRESH_BASE,3,0xf);
}

static void left_button_interrupt_handler(void* context)
/* interrupt handler : this function is called each time the left button direction is pressed */
{
	position* charPosition = (position*) context;
	charPosition[0].directionControl = LEFT;
	IOWR(LEFT_BUTTON_BASE,3,0xf);
}

static void up_button_interrupt_handler(void* context)
/* interrupt handler : this function is called each time the up button direction is pressed */
{
	position* charPosition = (position*) context;
	charPosition[0].directionControl = DOWN;
	IOWR(UP_BUTTON_BASE,3,0xf);
}

static void down_button_interrupt_handler(void* context)
/* interrupt handler : this function is called each time the down button direction is pressed */
{
	position* charPosition = (position*) context;
	charPosition[0].directionControl = UP;
	IOWR(DOWN_BUTTON_BASE,3,0xf);
}

static void right_button_interrupt_handler(void* context)
/* interrupt handler : this function is called each time the right button direction is pressed */
{
	position* charPosition = (position*) context;
	charPosition[0].directionControl = RIGHT;
	IOWR(RIGHT_BUTTON_BASE,3,0xf);
}

int main()
{

	position charPosition[5];
	position (*charPosition_ptr)[5] = &charPosition; //& obligatoire
	init_game(charPosition, 60, 60, SOUTH, charBackground, ghostBackground, foodLayer, &score);

	printf("Hello from Nios II!\n");

	//IRQ initialization
	IOWR(REFRESH_BASE,2,0xf); //enable interrupt
	IOWR(REFRESH_BASE,3,0xf); //clear edge register
	alt_irq_register(REFRESH_IRQ,(void*)charPosition_ptr,refresh_position_interrupt_handler);
	printf("Refresh IRQ : ");
	printf("alt_ic_irq_enabled : %lu \n", alt_ic_irq_enabled(REFRESH_IRQ_INTERRUPT_CONTROLLER_ID, REFRESH_IRQ));

	//Left button IRQ initialization
	IOWR(LEFT_BUTTON_BASE,2,0xf); //enable interrupt
	IOWR(LEFT_BUTTON_BASE,3,0xf); //clear edge register
	alt_irq_register(LEFT_BUTTON_IRQ,(void*)charPosition_ptr,left_button_interrupt_handler);
	printf("Left button IRQ : ");
	printf("left_button_irq_enabled : %lu \n", alt_ic_irq_enabled(LEFT_BUTTON_IRQ_INTERRUPT_CONTROLLER_ID, LEFT_BUTTON_IRQ));

	//Up button IRQ initialization
	IOWR(UP_BUTTON_BASE,2,0xf); //enable interrupt
	IOWR(UP_BUTTON_BASE,3,0xf); //clear edge register
	alt_irq_register(UP_BUTTON_IRQ,(void*)charPosition_ptr,up_button_interrupt_handler);
	printf("Up button IRQ : ");
	printf("up_button_irq_enabled : %lu \n", alt_ic_irq_enabled(UP_BUTTON_IRQ_INTERRUPT_CONTROLLER_ID, UP_BUTTON_IRQ));

	//Down button IRQ initialization
	IOWR(DOWN_BUTTON_BASE,2,0xf); //enable interrupt
	IOWR(DOWN_BUTTON_BASE,3,0xf); //clear edge register
	alt_irq_register(DOWN_BUTTON_IRQ,(void*)charPosition_ptr,down_button_interrupt_handler);
	printf("Down button IRQ : ");
	printf("down_button_irq_enabled : %lu \n", alt_ic_irq_enabled(DOWN_BUTTON_IRQ_INTERRUPT_CONTROLLER_ID, DOWN_BUTTON_IRQ));

	//Right button IRQ initialization
	IOWR(RIGHT_BUTTON_BASE,2,0xf); //enable interrupt
	IOWR(RIGHT_BUTTON_BASE,3,0xf); //clear edge register
	alt_irq_register(RIGHT_BUTTON_IRQ,(void*)charPosition_ptr,right_button_interrupt_handler);
	printf("Right button IRQ : ");
	printf("right_button_irq_enabled : %lu \n", alt_ic_irq_enabled(RIGHT_BUTTON_IRQ_INTERRUPT_CONTROLLER_ID, RIGHT_BUTTON_IRQ));



	long whileCounter = 0;
	while(1)
	{
		display_number(score);
		whileCounter++;


		if (whileCounter > 500000){
			if(food_layer_empty(foodLayer) == 1){
				init_game(charPosition, 60, 60, SOUTH, charBackground, ghostBackground, foodLayer, &score);
			}

//			printf("directionControl : %u, orientation : %u , Score : %u, foodLayer is Empty : %u\n",
//				pacmanPosition.directionControl,
//				pacmanPosition.orientation,
//				score,
//				food_layer_empty(foodLayer)
//			);
			
//			 printf("%lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu \n",
//			 	foodLayer[0],
//			 	foodLayer[1],
//			 	foodLayer[2],
//			 	foodLayer[3],
//			 	foodLayer[4],
//			 	foodLayer[5],
//			 	foodLayer[6],
//			 	foodLayer[7],
//			 	foodLayer[8],
//			 	foodLayer[9],
//			 	foodLayer[10],
//			 	foodLayer[11],
//			 	foodLayer[12],
//			 	foodLayer[13],
//			 	foodLayer[14]
//			 );
			whileCounter = 0;
		}
	}
}

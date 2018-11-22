// --------------------------------------------------------------------
// Copyright (c) 2007 by Terasic Technologies Inc. 
// --------------------------------------------------------------------
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// --------------------------------------------------------------------
//           
//                     Terasic Technologies Inc
//                     356 Fu-Shin E. Rd Sec. 1. JhuBei City,
//                     HsinChu County, Taiwan
//                     302
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// --------------------------------------------------------------------

module vga_generator(                                    
  input              	clk,                
  input              	reset_n,                                                
  input       [11:0] 	h_total,           
  input       [11:0] 	h_sync,           
  input       [11:0] 	h_start,             
  input       [11:0] 	h_end,                                                    
  input       [11:0] 	v_total,           
  input       [11:0] 	v_sync,            
  input       [11:0] 	v_start,           
  input       [11:0] 	v_end, 
  input       [11:0] 	v_active_14, 
  input       [11:0] 	v_active_24, 
  input       [11:0] 	v_active_34, 

  output  reg		    vga_hs,             
  output  reg        	vga_vs,           
  output  reg 	     	vga_de,
  output  reg [7:0]  	vga_r,
  output  reg [7:0]  	vga_g,
  output  reg [7:0]  	vga_b,

  input       [31:0]	position_data,
  output  reg			refresh_image,

  input                 nios_clk,
  input       [31:0]    background_data,
  input       [3:0]     background_wraddress,
  input                 background_wren,

  input       [31:0]    food_layer_data,
  input       [3:0]     food_layer_wraddress,
  input                 food_layer_wren

);

background_generator background_generator_inst0 (
	.clk(clk),
	.nios_clk(nios_clk),
	.row_x(pixel_x),
	.line_y(pixel_y),
	.enable(pre_vga_de),
	.reset(end_image),
	.data(background_data),
	.wraddress(background_wraddress),
	.wren(background_wren),
	.vga_r(s_vga_r_2),
	.vga_g(s_vga_g_2),
	.vga_b(s_vga_b_2)
);

food_layer_generator food_layer_generator_inst0 (
	.clk(clk),
	.nios_clk(nios_clk),
	.row_x(pixel_x),
	.line_y(pixel_y),
	.enable(pre_vga_de),
	.reset(end_image),
	.data(food_layer_data),
	.wraddress(food_layer_wraddress),
	.wren(food_layer_wren),
	.vga_r(s_vga_r_3),
	.vga_g(s_vga_g_3),
	.vga_b(s_vga_b_3)
);

character_generator pacman_generator(
	.clk(clk),
	.row_x(pixel_x),
	.line_y(pixel_y),
	.position_data(position_data),
	.enable(pre_vga_de),
	.reset(end_image),
	.refresh_image(new_image),
	.vga_r(s_vga_r_1),
	.vga_g(s_vga_g_1),
	.vga_b(s_vga_b_1)
);

sync_signals_buffer sync_signals_buffer_inst0(
	.clk(clk),
	.e1(vga_hs_in),
	.e2(vga_vs_in),
	.e3(vga_de_in),
	.s1(vga_hs),
	.s2(vga_vs),
	.s3(vga_de)
);

vga_or vga_or_inst0(
	.vga_r_1(s_vga_r_1),
	.vga_r_2(s_vga_r_2),
	.vga_r_3(s_vga_r_3),
	.vga_r_4(s_vga_r_4),
	.vga_r_5(s_vga_r_5),
	.vga_r_6(s_vga_r_6),
	.vga_g_1(s_vga_g_1),
	.vga_g_2(s_vga_g_2),
	.vga_g_3(s_vga_g_3),
	.vga_g_4(s_vga_g_4),
	.vga_g_5(s_vga_g_5),
	.vga_g_6(s_vga_g_6),
	.vga_b_1(s_vga_b_1),
	.vga_b_2(s_vga_b_2),
	.vga_b_3(s_vga_b_3),
	.vga_b_4(s_vga_b_4),
	.vga_b_5(s_vga_b_5),
	.vga_b_6(s_vga_b_6),
	.vga_r_out(vga_r),
	.vga_g_out(vga_g),
	.vga_b_out(vga_b)
);


//=======================================================
//  Signal declarations
//=======================================================
reg		[11:0]		h_count;
reg		[11:0]		pixel_x;
reg		[11:0]		v_count;
reg 	[11:0]		pixel_y;
reg 				h_act; 
reg 				h_act_d;
reg 				v_act; 
reg 				v_act_d; 
reg 				pre_vga_de;
wire				h_max, hs_end, hr_start, hr_end;
wire				v_max, vs_end, vr_start, vr_end;
wire				v_act_14, v_act_24, v_act_34;
reg					new_image;
reg 				boarder;
reg 				end_image;
reg					vga_hs_in;             
reg 				vga_vs_in;        
reg 				vga_de_in;

//VGA intern signals
reg [7:0] 	s_vga_r_1;
reg [7:0] 	s_vga_g_1;
reg [7:0] 	s_vga_b_1;
reg [7:0] 	s_vga_r_2;
reg [7:0] 	s_vga_g_2;
reg [7:0] 	s_vga_b_2;
reg [7:0] 	s_vga_g_3;
reg [7:0] 	s_vga_r_3;
reg [7:0] 	s_vga_b_3;
reg [7:0] 	s_vga_b_4 = 0;
reg [7:0] 	s_vga_r_4 = 0;
reg [7:0] 	s_vga_g_4 = 0;
reg [7:0] 	s_vga_r_5 = 0;
reg [7:0] 	s_vga_g_5 = 0;
reg [7:0] 	s_vga_b_5 = 0;
reg [7:0] 	s_vga_r_6 = 0;
reg [7:0] 	s_vga_g_6 = 0;
reg [7:0] 	s_vga_b_6 = 0;

//=======================================================
//  Structural coding
//=======================================================
assign h_max = h_count == h_total;
assign hs_end = h_count >= h_sync;
assign hr_start = h_count == h_start; 
assign hr_end = h_count == h_end;
assign v_max = v_count == v_total;
assign vs_end = v_count >= v_sync;
assign vr_start = v_count == v_start; 
assign vr_end = v_count == v_end;
assign v_act_14 = v_count == v_active_14;
assign v_act_24 = v_count == v_active_24;
assign v_act_34 = v_count == v_active_34;

//horizontal control signals

//s_vga_g_3 <= 8'b0;
//s_vga_r_3 <= 8'b0;
//s_vga_b_3 <= 8'b0;
//s_vga_b_4 <= 8'b0;
//s_vga_r_4 <= 8'b0;
//s_vga_g_4 <= 8'b0;
//s_vga_r_5 <= 8'b0;
//s_vga_g_5 <= 8'b0;
//s_vga_b_5 <= 8'b0;
//s_vga_r_6 <= 8'b0;
//s_vga_g_6 <= 8'b0;
//s_vga_b_6 <= 8'b0;


always @ (posedge clk or negedge reset_n)
	if (!reset_n)
	begin
		h_act_d		<=  1'b0;
		h_count		<=	12'b0;
		pixel_x		<=  12'b0;
		vga_hs_in	<=	1'b1;
		h_act 		<=	1'b0;
	end
	else
	begin
    h_act_d   <=  h_act;
    if (h_max)
		  h_count	<= 12'b0;
		else
		  h_count	<= h_count + 12'b1;

		if (hs_end && !h_max)
		  vga_hs_in	<=	1'b1;
		else
		  vga_hs_in	<= 1'b0;

		if (hr_start)
		  h_act	  <=	1'b1;
		else if (hr_end)
		  h_act	  <=	1'b0;

		if (h_act)
		  	pixel_x <= pixel_x + 1'b1;
	  else
	  	pixel_x <= 12'b0;
	end

//vertical control signals
always@(posedge clk or negedge reset_n)
	if(!reset_n)
	begin
		v_act_d	  <=	1'b0;
		v_count		<=	12'b0;
		vga_vs_in		<=	1'b1;
		v_act	    <=	1'b0;
	end
	else 
	begin		
		if (h_max)
		begin		  
  		v_act_d	  <=	v_act;
		  
		  if (v_max)
		  begin
		    v_count	<=	12'b0;
		    new_image <= 1'b1;
		    refresh_image <= 1'b1;
		  end
		  else
		  begin
		    v_count	<=	v_count + 12'b1;
		    new_image <= 1'b0;
		    refresh_image <= 1'b0;
		  end
		  if (vs_end && !v_max)
		    vga_vs_in	<=	1'b1;
		  else
		    vga_vs_in	<=	1'b0;

  		if (vr_start)
	  	  v_act <=	1'b1;
		  else if (vr_end)
		    v_act <=	1'b0;
		end
	end

//pattern generator and display enable
always @(posedge clk or negedge reset_n)
begin
	if (!reset_n)
	begin
		pixel_y 	<= 	12'b0;
		end_image <= 1'b0;
    vga_de_in <= 1'b0;
    pre_vga_de <= 1'b0;
    boarder <= 1'b0;		
  end
	else
	begin
    vga_de_in <= pre_vga_de;
    pre_vga_de <= v_act && h_act;
    
    if ((!h_act_d && h_act) || hr_end || (!v_act_d && v_act) || vr_end)
      boarder <= 1'b1;
    else
      boarder <= 1'b0;   

    if (v_act)
    	begin
    	if (hr_start)
    		pixel_y <= pixel_y + 1'b1;
    	end
    else
    	pixel_y <= 12'b0;
    
    if (hr_end && vr_end)
    	end_image <= 1'b1;
	end
end	

endmodule
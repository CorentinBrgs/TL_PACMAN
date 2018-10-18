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
  input              clk,                
  input              reset_n,                                                
  input       [11:0] h_total,           
  input       [11:0] h_sync,           
  input       [11:0] h_start,             
  input       [11:0] h_end,                                                    
  input       [11:0] v_total,           
  input       [11:0] v_sync,            
  input       [11:0] v_start,           
  input       [11:0] v_end, 
  input       [11:0] v_active_14, 
  input       [11:0] v_active_24, 
  input       [11:0] v_active_34, 
  output  reg		     vga_hs,             
  output  reg        vga_vs,           
  output  reg 	     vga_de,
  output  reg [7:0]  vga_r,
  output  reg [7:0]  vga_g,
  output  reg [7:0]  vga_b                                                 
);

image_generator image_generator_inst0 (
	.row_x(pixel_x),
	.line_y(pixel_y),
	.enable(pre_vga_de),
	.reset(end_image),
	.clk(clk),
	.vga_r(vga_r),
	.vga_g(vga_g),
	.vga_b(vga_b)
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



//=======================================================
//  Signal declarations
//=======================================================
reg		[11:0]		h_count;
reg		[11:0]		pixel_x;
reg		[11:0]		v_count;
reg 		[11:0]		pixel_y;
reg      	         h_act; 
reg         	      h_act_d;
reg            	   v_act; 
reg               	v_act_d; 
reg      	         pre_vga_de;
wire        	      h_max, hs_end, hr_start, hr_end;
wire           	   v_max, vs_end, vr_start, vr_end;
wire              	v_act_14, v_act_24, v_act_34;
reg               	boarder;
reg 						end_image;
reg		     vga_hs_in;             
reg        vga_vs_in;        
reg 	     vga_de_in;

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
always @ (posedge clk or negedge reset_n)
	if (!reset_n)
	begin
    h_act_d   <=  1'b0;
		h_count		<=	12'b0;
		pixel_x   <=  12'b0;
		vga_hs_in		<=	1'b1;
		h_act	    <=	1'b0;
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
		    v_count	<=	12'b0;
		  else
		    v_count	<=	v_count + 12'b1;

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
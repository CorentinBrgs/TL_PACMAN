module vpg_mode (
	reset_n,
	clk,
	clk_en,
	mode_button,
	vpg_mode_change,
	vpg_mode
);

`include "vpg_source/vpg.h"

input			   reset_n;
input			   clk;
input			   clk_en;
input			   mode_button;
output       vpg_mode_change;
output [3:0] vpg_mode;



reg		      pre_mode_button;
reg			    vpg_mode_change;
reg		[3:0]	vpg_mode;	
reg   [9:0] virtual;



always@(posedge clk or negedge reset_n)
begin
	if (!reset_n)
	begin
		virtual <= 10'b0;
	  pre_mode_button <= 1'b1;
	  vpg_mode_change <= 1'b0;
		vpg_mode <= `VESA_1600x1200p60;
	end
  else if (clk_en)
  begin
  	virtual <= {virtual[8:0], 1'b1};
    pre_mode_button <= mode_button;
    
    if (mode_button && !pre_mode_button || virtual[8] && !virtual[9])
    begin
    	vpg_mode_change <= 1'b1;
    	
      if (vpg_mode == `VESA_1600x1200p60)
				vpg_mode <= `VGA_640x480p60;
			else
				vpg_mode <= vpg_mode + 1'b1;
    end
    else
    	vpg_mode_change <= 1'b0;
  end	
end
endmodule

module HDMI_QSYS (
	background_data_export,
	background_wr_export,
	clk_clk,
	down_button_export,
	hdmi_tx_int_n_external_connection_export,
	i2c_scl_external_connection_export,
	i2c_sda_external_connection_export,
	led_external_connection_export,
	left_button_export,
	position_table_export,
	refresh_image_export,
	reset_reset_n,
	right_button_export,
	up_button_export,
	food_layer_data_export,
	food_layer_wr_export);	

	output	[31:0]	background_data_export;
	output	[4:0]	background_wr_export;
	input		clk_clk;
	input		down_button_export;
	input		hdmi_tx_int_n_external_connection_export;
	output		i2c_scl_external_connection_export;
	inout		i2c_sda_external_connection_export;
	output	[7:0]	led_external_connection_export;
	input		left_button_export;
	output	[31:0]	position_table_export;
	input		refresh_image_export;
	input		reset_reset_n;
	input		right_button_export;
	input		up_button_export;
	output	[31:0]	food_layer_data_export;
	output	[4:0]	food_layer_wr_export;
endmodule

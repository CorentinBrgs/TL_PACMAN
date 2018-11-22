
module HDMI_QSYS (
	background_data_export,
	background_wr_export,
	clk_clk,
	hdmi_tx_int_n_external_connection_export,
	i2c_scl_external_connection_export,
	i2c_sda_external_connection_export,
	led_external_connection_export,
	position_table_export,
	refresh_image_export,
	reset_reset_n);	

	output	[31:0]	background_data_export;
	output	[4:0]	background_wr_export;
	input		clk_clk;
	input		hdmi_tx_int_n_external_connection_export;
	output		i2c_scl_external_connection_export;
	inout		i2c_sda_external_connection_export;
	output	[7:0]	led_external_connection_export;
	output	[31:0]	position_table_export;
	input		refresh_image_export;
	input		reset_reset_n;
endmodule

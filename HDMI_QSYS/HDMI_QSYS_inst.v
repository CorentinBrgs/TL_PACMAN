	HDMI_QSYS u0 (
		.clk_clk                                  (<connected-to-clk_clk>),                                  //                               clk.clk
		.hdmi_tx_int_n_external_connection_export (<connected-to-hdmi_tx_int_n_external_connection_export>), // hdmi_tx_int_n_external_connection.export
		.i2c_scl_external_connection_export       (<connected-to-i2c_scl_external_connection_export>),       //       i2c_scl_external_connection.export
		.i2c_sda_external_connection_export       (<connected-to-i2c_sda_external_connection_export>),       //       i2c_sda_external_connection.export
		.led_external_connection_export           (<connected-to-led_external_connection_export>),           //           led_external_connection.export
		.position_table_export                    (<connected-to-position_table_export>),                    //                    position_table.export
		.reset_reset_n                            (<connected-to-reset_reset_n>)                             //                             reset.reset_n
	);


	component HDMI_QSYS is
		port (
			clk_clk                                  : in    std_logic                     := 'X'; -- clk
			hdmi_tx_int_n_external_connection_export : in    std_logic                     := 'X'; -- export
			i2c_scl_external_connection_export       : out   std_logic;                            -- export
			i2c_sda_external_connection_export       : inout std_logic                     := 'X'; -- export
			led_external_connection_export           : out   std_logic_vector(7 downto 0);         -- export
			position_table_export                    : out   std_logic_vector(31 downto 0);        -- export
			reset_reset_n                            : in    std_logic                     := 'X'; -- reset_n
			refresh_image_export                     : in    std_logic                     := 'X'  -- export
		);
	end component HDMI_QSYS;

	u0 : component HDMI_QSYS
		port map (
			clk_clk                                  => CONNECTED_TO_clk_clk,                                  --                               clk.clk
			hdmi_tx_int_n_external_connection_export => CONNECTED_TO_hdmi_tx_int_n_external_connection_export, -- hdmi_tx_int_n_external_connection.export
			i2c_scl_external_connection_export       => CONNECTED_TO_i2c_scl_external_connection_export,       --       i2c_scl_external_connection.export
			i2c_sda_external_connection_export       => CONNECTED_TO_i2c_sda_external_connection_export,       --       i2c_sda_external_connection.export
			led_external_connection_export           => CONNECTED_TO_led_external_connection_export,           --           led_external_connection.export
			position_table_export                    => CONNECTED_TO_position_table_export,                    --                    position_table.export
			reset_reset_n                            => CONNECTED_TO_reset_reset_n,                            --                             reset.reset_n
			refresh_image_export                     => CONNECTED_TO_refresh_image_export                      --                     refresh_image.export
		);

